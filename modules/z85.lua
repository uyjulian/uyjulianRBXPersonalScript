local M = {}

local z85Decoder = { 0x00, 0x44, 0x00, 0x54, 0x53, 0x52, 0x48, 0x00,
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
                     0x21, 0x22, 0x23, 0x4F, 0x00, 0x50, 0x00, 0x00 }

function M.from_z85( str )
   if #str % 5 ~= 0 then return nil end

   local result = {}

   local value = 0
   for i = 1, #str do
      local index = string.byte( str, i ) - 31
      if index < 1 or index >= #z85Decoder then return nil end
      value = ( value * 85 ) + z85Decoder[ index ]
      if ( i % 5 ) == 0 then
         local divisor = 256 * 256 * 256
         while divisor ~= 0 do
            local b = math.floor( value / divisor ) % 256
            table.insert( result, string.char( b ) )
            divisor = math.floor( divisor / 256 )
         end
         value = 0
      end
   end

   return table.concat( result )
end

local z85Encoder = "0123456789"..
                   "abcdefghijklmnopqrstuvwxyz"..
                   "ABCDEFGHIJKLMNOPQRSTUVWXYZ"..
                   ".-:+=^!/*?&<>()[]{}@%$#"

function M.to_z85( str )
   if ( #str % 4 ) ~= 0 then return nil end

   local result = {}

   local value = 0
   for i = 1, #str do
      local b = string.byte( str, i )
      value = ( value * 256 ) + b
      if ( i % 4 ) == 0 then
         local divisor = 85 * 85 * 85 * 85
         while divisor ~= 0 do
            local index = ( math.floor( value / divisor ) % 85 ) + 1
            table.insert( result, z85Encoder:sub( index, index ) )
            divisor = math.floor( divisor / 85 )
         end
         value = 0
      end
   end

   return table.concat( result )
end

return M