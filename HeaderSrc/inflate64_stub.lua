local function Invoke(self, name, ...)
	return self[name](self, ...)
end

local function inflate64(strin)
	local str = ""

	local env = getfenv()

	local ipairs, pairs, type, setmetatable, tonumber, string, math, table = env.ipairs, env.pairs, env.type, env.setmetatable, env.tonumber, env.string, env.math, env.table
	local table_sort, table_insert, table_concat, math_max, math_huge, math_min, math_floor, math_pow, string_char, string_byte, string_sub, string_match = table.sort, table.insert, table.concat, math.max, math.huge, math.min, math.floor, math.pow, string.char, string.byte, string.sub, string.match

	local function byb(q)
		str = str .. string_char(q)
	end

	local function make_outstate(outbs)
		local outstate = {}
		outstate.o = outbs
		outstate.w = {}
		outstate.p = 1
		return outstate
	end


	local function output(outstate, byte)
		local window_pos = outstate.p
		outstate.o(byte)
		outstate.w[window_pos] = byte
		outstate.p = window_pos % 32768 + 1  -- 32K
	end

	local function hasbit(bits, bit)
		return bits % (bit + bit) >= bit
	end


	local function memoize(f)
		local mt = {}
		local t = setmetatable({}, mt)
		function mt:__index(k)
			local v = f(k)
			t[k] = v
			return v
		end
		return t
	end


	-- small optimization (lookup table for powers of 2)
	local pow2 = memoize(function(n) return 2^n end)

	-- weak metatable marking objects as bitstream type
	local is_bitstream = setmetatable({}, {__mode='k'})


	local function bytestream_from_string(s)
		local i = 1
		local o = {}
		function o:r()
			local by
			if i <= #s then
				by = string_byte(s,i)
				i = i + 1
			end
			return by
		end
		return o
	end


	local function bytestream_from_function(f)
		local i = 0
		local buffer = ''
		local o = {}
		function o:r()
			i = i + 1
			if i > #buffer then
				buffer = f()
				if not buffer then return end
				i = 1
			end
			return string_byte(buffer,i,i)
		end
		return o
	end


	local function bitstream_from_bytestream(bys)
		local buf_byte = 0
		local buf_nbit = 0
		local o = {}

		function o:n()
			return buf_nbit
		end


		function o:r(nbits)
			nbits = nbits or 1
			while buf_nbit < nbits do
				local byte = bys:r()
				if not byte then return end  -- note: more calls also return nil
				buf_byte = buf_byte + pow2[buf_nbit] * byte
				buf_nbit = buf_nbit + 8
			end
			local m = pow2[nbits]
			local bits = buf_byte % m
			buf_byte = (buf_byte - bits) / m
			buf_nbit = buf_nbit - nbits
			return bits
		end

		is_bitstream[o] = true

		return o
	end


	local function get_bitstream(o)
		local bs
		if is_bitstream[o] then
			return o
		elseif type(o) == 'string' then
			bs = bitstream_from_bytestream(bytestream_from_string(o))
		end
		return bs
	end


	local function get_obytestream(o)
		local bs
		if type(o) == 'function' then
			bs = o
		end
		return bs
	end


	local function HuffmanTable(init, is_full)
		local t = {}
		if is_full then
			for val,nbits in pairs(init) do
				if nbits ~= 0 then
					t[#t+1] = {v=val, n=nbits}
				end
			end
		else
			for i=1,#init-2,2 do
				local firstval, nbits, nextval = init[i], init[i+1], init[i+2]
				if nbits ~= 0 then
					for val=firstval,nextval-1 do
						t[#t+1] = {v=val, n=nbits}
					end
				end
			end
		end
		table_sort(t, function(a,b)
			return a.n == b.n and a.v < b.v or a.n < b.n
		end)

		-- assign codes
		local code = 1  -- leading 1 marker
		local nbits = 0
		for i,s in ipairs(t) do
			if s.n ~= nbits then
				code = code * pow2[s.n - nbits]
				nbits = s.n
			end
			s.c = code
			code = code + 1
		end

		local minbits = math_huge
		local look = {}
		for i,s in ipairs(t) do
			minbits = math_min(minbits, s.n)
			look[s.c] = s.v
		end

		-- function t:lookup(bits) return look[bits] end

		local msb = function(bits, nbits)
			local res = 0
			for i=1,nbits do
				local b = bits % 2
				bits = (bits - b) / 2
				res = res * 2 + b
			end
			return res
		end
		
		local tfirstcode = memoize(function(bits) return pow2[minbits] + msb(bits, minbits) end)

		function t:r(bs)
			local code = 1 -- leading 1 marker
			local nbits = 0
			while 1 do
				if nbits == 0 then  -- small optimization (optional)
					code = tfirstcode[bs:r(minbits)]
					nbits = nbits + minbits
				else
					local b = bs:r()
					nbits = nbits + 1
					code = code * 2 + b   -- MSB first
				end
				local val = look[code]
				if val then
					return val
				end
			end
		end

		return t
	end

	local function parse_huffmantables(bs)
		local hlit = bs:r(5)  -- # of literal/length codes - 257
		local hdist = bs:r(5) -- # of distance codes - 1
		local hclen = bs:r(4) -- # of code length codes - 4

		local ncodelen_codes = hclen + 4
		local codelen_init = {}
		local codelen_vals = {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15}
		for i=1,ncodelen_codes do
			local nbits = bs:r(3)
			local val = codelen_vals[i]
			codelen_init[val] = nbits
		end
		local codelentable = HuffmanTable(codelen_init, true)

		local function decode(ncodes)
			local init = {}
			local nbits
			local val = 0
			while val < ncodes do
				local codelen = codelentable:r(bs)
				--FIX:check nil?
				local nrepeat
				if codelen <= 15 then
					nrepeat = 1
					nbits = codelen
				elseif codelen == 16 then
					nrepeat = 3 + bs:r(2)
					-- nbits unchanged
				elseif codelen == 17 then
					nrepeat = 3 + bs:r(3)
					nbits = 0
				elseif codelen == 18 then
					nrepeat = 11 + bs:r(7)
					nbits = 0
				end
				for i=1,nrepeat do
					init[val] = nbits
					val = val + 1
				end
			end
			local huffmantable = HuffmanTable(init, true)
			return huffmantable
		end

		local nlit_codes = hlit + 257
		local ndist_codes = hdist + 1

		local littable = decode(nlit_codes)
		local disttable = decode(ndist_codes)

		return littable, disttable
	end


	local tdecode_len_base
	local tdecode_len_nextrabits
	local tdecode_dist_base
	local tdecode_dist_nextrabits
	local function parse_compressed_item(bs, outstate, littable, disttable)
		local val = littable:r(bs)
		if val < 256 then -- literal
			output(outstate, val)
		elseif val == 256 then -- end of block
			return true
		else
			if not tdecode_len_base then
				local t = {[257]=3}
				local skip = 1
				for i=258,285,4 do
					for j=i,i+3 do 
						t[j] = t[j-1] + skip 
					end
					if i ~= 258 then 
						skip = skip * 2 
					end
				end
				t[285] = 258
				tdecode_len_base = t
			end
			if not tdecode_len_nextrabits then
				local t = {}
				for i=257,285 do
					local j = math_max(i - 261, 0)
					t[i] = (j - (j % 4)) / 4
				end
				t[285] = 0
				tdecode_len_nextrabits = t
			end
			local len_base = tdecode_len_base[val]
			local nextrabits = tdecode_len_nextrabits[val]
			local extrabits = bs:r(nextrabits)
			local len = len_base + extrabits

			if not tdecode_dist_base then
				local t = {[0]=1}
				local skip = 1
				for i=1,29,2 do
					for j=i,i+1 do 
						t[j] = t[j-1] + skip 
					end
					if i ~= 1 then 
						skip = skip * 2 
					end
				end
				tdecode_dist_base = t
			end
			if not tdecode_dist_nextrabits then
				local t = {}
				for i=0,29 do
					local j = math_max(i - 2, 0)
					t[i] = (j - (j % 2)) / 2
				end
				tdecode_dist_nextrabits = t
			end
			local dist_val = disttable:r(bs)
			local dist_base = tdecode_dist_base[dist_val]
			local dist_nextrabits = tdecode_dist_nextrabits[dist_val]
			local dist_extrabits = bs:r(dist_nextrabits)
			local dist = dist_base + dist_extrabits

			for i=1,len do
				local pos = (outstate.p - 1 - dist) % 32768 + 1  -- 32K
				output(outstate, outstate.w[pos])
			end
		end
		return false
	end


	local function parse_block(bs, outstate)
		local bfinal = bs:r(1)
		local btype = bs:r(2)

		local BTYPE_NO_COMPRESSION = 0
		local BTYPE_FIXED_HUFFMAN = 1
		local BTYPE_DYNAMIC_HUFFMAN = 2
		local BTYPE_RESERVED_ = 3

		if btype == BTYPE_NO_COMPRESSION then
			bs:r(bs:n())
			local len = bs:r(16)
			local nlen_ = bs:r(16)

			for i=1,len do
				local by = bs:r(8)
				output(outstate, by)
			end
		elseif btype == BTYPE_FIXED_HUFFMAN or btype == BTYPE_DYNAMIC_HUFFMAN then
			local littable, disttable
			if btype == BTYPE_DYNAMIC_HUFFMAN then
				littable, disttable = parse_huffmantables(bs)
			else
				littable  = HuffmanTable {0,8, 144,9, 256,7, 280,8, 288,nil}
				disttable = HuffmanTable {0,5, 32,nil}
			end

			repeat
				local is_done = parse_compressed_item(bs, outstate, littable, disttable)
			until is_done
		end

		return bfinal ~= 0
	end




	local z85Decoder = {	
		0x00, 0x44, 0x00, 0x54, 0x53, 0x52, 0x48, 0x00,
		0x4B, 0x4C, 0x46, 0x41, 0x00, 0x3F, 0x3E, 0x45, 
		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 
		0x08, 0x09, 0x40, 0x00, 0x49, 0x42, 0x4A, 0x47, 
		0x51, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 
		0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x30, 0x31, 0x32, 
		0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 
		0x3B, 0x3C, 0x3D, 0x4D, 0x00, 0x4E, 0x43, 0x00, 
		0x00, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10, 
		0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 
		0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0x20, 
		0x21, 0x22, 0x23, 0x4F, 0x00, 0x50, 0x00, 0x00,
	}

	local function decodez85( str )
		local result = {}

		local value = 0
		for i = 1, #str do
			local index = string_byte( str, i ) - 31
			value = ( value * 85 ) + z85Decoder[ index ]
			if ( i % 5 ) == 0 then
				local divisor = 256 * 256 * 256
				while divisor ~= 0 do
					local b = math_floor( value / divisor ) % 256
					table_insert( result, string_char( b ) )
					divisor = math_floor( divisor / 256 )
				end
				value = 0
			end
		end

		return table_concat( result )
	end

	local function inflate()
		local bs = get_bitstream(decodez85(strin))
		local outbs = get_obytestream(byb)
		local outstate = make_outstate(outbs)

		repeat
			local is_final = parse_block(bs, outstate)
		until is_final
	end

	local function dec(doc)
		local luatab = {}
		local len = string_byte(doc,1) + (string_byte(doc,2)*256) + (string_byte(doc,3)*65536) + (string_byte(doc,4)*16777216)
		doc=string_sub(doc,5)
		repeat
			local val
			local etype = string_byte(doc,1)
			if etype == 0 then doc=string_sub(doc,2) break end
			local ename = string_match(doc,"(%Z+)\000",2)
			doc = string_sub(doc,#ename+3)
			if etype == 1 then
				local buffer = {}
				local bias = 1023
				local last = 0
				local sign = 1
				local succ = true
				
				-- Create a reverse version of the buffer
				for i=1, 8 do
					last = 8 - (i - 1)
					buffer[i] = string_byte(string_sub(doc, last, last))
				end
				
				-- If the first bit is 1 turn sign to -1
				if math_floor(buffer[1] / math_pow(2, 7)) > 0 then
					sign = -1
				end
				
				-- Take the last 7 bits
				local exponent = math_floor(buffer[1] % 128)
				-- Left shift 8 bits and sum with the seconds octect
				exponent = exponent * 256 + buffer[2]
				
				-- Take the last 4 bits
				local mantissa = math_floor(exponent % 16)
				
				-- Right shift 4 bits
				exponent = math_floor(exponent / math_pow(2, 4))
				
				-- Read the buffer as int32 value
				for i=3, 8 do
					mantissa = mantissa * 256 + buffer[i]
				end

				if exponent == 0 then -- Very tiny
					exponent = 1 - bias
				elseif exponent == 2047 then -- Very big
					if mantissa > 0 then
						succ = 0 / 0 -- Not a number
					else
						succ = sign * (1 / 0) -- Positive or negative infinite
					end
				else -- Most of the time will fall here
					mantissa = mantissa + 4503599627370496
					exponent = exponent - bias
				end
				if succ == true then
					val = sign * mantissa * math_pow(2, exponent - 52) 
				else
					val = succ
				end
				doc = string_sub(doc,9)
			elseif etype == 2 then
				local len = string_byte(doc,1) + (string_byte(doc,2)*256) + (string_byte(doc,3)*65536) + (string_byte(doc,4)*16777216)
				doc = string_sub(doc,5)
				val = string_sub(doc,1,len-1)
				doc = string_sub(doc,len+1)
			elseif etype == 3 then
				val, doc = dec(doc)
			elseif etype == 8 then
				val = string_byte(doc,1) == 1
				doc = string_sub(doc,2)
			elseif etype == 16 then
				val = string_byte(doc,1) + (string_byte(doc,2)*256) + (string_byte(doc,3)*65536) + (string_byte(doc,4)*16777216)
				doc = string_sub(doc,5)
			end
			luatab[tonumber(ename) or ename] = val
		until not doc
		return luatab,doc
	end


	inflate()

	local a, s = dec(str)

	return a

end

