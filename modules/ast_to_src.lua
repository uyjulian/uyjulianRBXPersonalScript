local M = { }

M.__index = M

--local pp = require "metalua.pprint"

function M.new ()
   local self = {
      _acc = { },
      current_indent = 0,
      indent_step = "   "
   }
   return setmetatable (self, M)
end

function M:run (ast)
   if not ast then
      self, ast = M.new (), self
   end
   self._acc = { }
   self:node (ast)
   return table.concat (self._acc)
end

function M:acc (x)
   if x then
      table.insert (self._acc, x)
   end
end

function M:nl ()
   if self.current_indent == 0 then
      self:acc "\n"
   end
   self:acc ("\n" .. self.indent_step:rep (self.current_indent))
end

function M:nlindent ()
   self.current_indent = self.current_indent + 1
   self:nl ()
end

function M:nldedent ()
   self.current_indent = self.current_indent - 1
   self:acc ("\n" .. self.indent_step:rep (self.current_indent))
end

local keywords_list = {
   "and",
   "break",
   "do",
   "else",
   "elseif",
   "end",
   "false",
   "for",
   "function",
   "if",
   "in",
   "local",
   "nil",
   "not",
   "or",
   "repeat",
   "return",
   "then",
   "true",
   "until",
   "while"
}

local keywords = { }

for _, kw in pairs (keywords_list) do
   keywords[kw] = true
end

local function is_ident (id)
   return string.match (id, "^[%a_][%w_]*$") and not keywords[id]
end

local function is_idx_stack (ast)
   do
      local Id_3_v = ast
      do
         local Id_1_submatch_2, _
         if type (Id_3_v) ~= "table" then
             goto Label_5_match_fail
         end
         Id_1_submatch_2 = Id_3_v.tag
         if Id_1_submatch_2 ~= "Id" then
             goto Label_5_match_fail
         end
         if # Id_3_v ~= 1 then
             goto Label_5_match_fail
         end
          ::Label_4_on_success::
         do
            return true
         end
          goto Label_2_after_success
          ::Label_5_match_fail::
      end
      do
         local _, Id_1_submatch_2, Id_1_submatch_3, left, Id_1_submatch_4
         if type (Id_3_v) ~= "table" then
             goto Label_7_match_fail
         end
         Id_1_submatch_2 = Id_3_v.tag
         if Id_1_submatch_2 ~= "Index" then
             goto Label_7_match_fail
         end
         left = Id_3_v[1]
         if left == nil then
             goto Label_7_match_fail
         end
         Id_1_submatch_3 = Id_3_v[2]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_7_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3.tag
         if Id_1_submatch_4 ~= "String" then
             goto Label_7_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_7_match_fail
         end
         if # Id_3_v ~= 2 then
             goto Label_7_match_fail
         end
          ::Label_6_on_success::
         do
            return is_idx_stack (left)
         end
          goto Label_2_after_success
          ::Label_7_match_fail::
      end
      do
         local _
          ::Label_8_on_success::
         do
            return false
         end
          goto Label_2_after_success
          ::Label_9_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L113-115|C6-49|K4529-4685>")
       ::Label_2_after_success::
   end
end

local op_preprec = {
   {
      "or",
      "and"
   },
   {
      "lt",
      "le",
      "eq",
      "ne"
   },
   { "concat" },
   {
      "add",
      "sub"
   },
   {
      "mul",
      "div",
      "mod"
   },
   {
      "unm",
      "not",
      "len"
   },
   { "pow" },
   { "index" }
}

local op_prec = { }

for prec, ops in ipairs (op_preprec) do
   for _, op in ipairs (ops) do
      op_prec[op] = prec
   end
end

local op_symbol = {
   add = " + ",
   sub = " - ",
   mul = " * ",
   div = " / ",
   mod = " % ",
   pow = " ^ ",
   concat = " .. ",
   eq = " == ",
   ne = " ~= ",
   lt = " < ",
   le = " <= ",
   ["and"] = " and ",
   ["or"] = " or ",
   ["not"] = "not ",
   unm = "- ",
   len = "# "
}

local pp = require"lua-parser.pp"

function M:node (node)
   assert (self ~= M and self._acc)
   if node == nil then
      self:acc "<<error>>"
      return 
   end
   if (not node.tag) or (node.tag == "Block") then
      self:list (node, self.nl)
   else
      local f = M[node.tag]
      if type (f) == "function" then
         f (self, node, unpack (node))
      elseif type (f) == "string" then
         self:acc (f)
      else
         self:acc " -{ "
         self:acc (pp.tostring (node, {
            metalua_tag = 1,
            hide_hash = 1
         }), 80)
         self:acc " }"
      end
   end
end

function M:list (list, sep, start)
   for i = start or 1, # list do
      self:node (list[i])
      if list[i + 1] then
         if not sep then
            
         elseif type (sep) == "function" then
            sep (self)
         elseif type (sep) == "string" then
            self:acc (sep)
         else
            error "Invalid list separator"
         end
      end
   end
end

function M:Do (node)
   self:acc "do"
   self:nlindent ()
   self:list (node, self.nl)
   self:nldedent ()
   self:acc "end"
end

function M:Set (node)
   do
      local Id_11_v = node
      do
         local Id_1_submatch_5, Id_1_submatch_13, Id_1_submatch_14, Id_1_submatch_8, Id_1_submatch_4, method, lhs, Id_1_submatch_2, Id_1_submatch_12, body, Id_1_submatch_6, Id_1_submatch_10, Id_1_submatch_9, Id_1_submatch_11, Id_1_submatch_3, Id_1_submatch_7, params
         if type (Id_11_v) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_2 = Id_11_v.tag
         if Id_1_submatch_2 ~= "Set" then
             goto Label_13_match_fail
         end
         Id_1_submatch_3 = Id_11_v[1]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3[1]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4.tag
         if Id_1_submatch_5 ~= "Index" then
             goto Label_13_match_fail
         end
         lhs = Id_1_submatch_4[1]
         if lhs == nil then
             goto Label_13_match_fail
         end
         Id_1_submatch_6 = Id_1_submatch_4[2]
         if type (Id_1_submatch_6) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_7 = Id_1_submatch_6.tag
         if Id_1_submatch_7 ~= "String" then
             goto Label_13_match_fail
         end
         method = Id_1_submatch_6[1]
         if method == nil then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_6 ~= 1 then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_4 ~= 2 then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_13_match_fail
         end
         Id_1_submatch_8 = Id_11_v[2]
         if type (Id_1_submatch_8) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_9 = Id_1_submatch_8[1]
         if type (Id_1_submatch_9) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_10 = Id_1_submatch_9.tag
         if Id_1_submatch_10 ~= "Function" then
             goto Label_13_match_fail
         end
         Id_1_submatch_11 = Id_1_submatch_9[1]
         if type (Id_1_submatch_11) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_12 = Id_1_submatch_11[1]
         if type (Id_1_submatch_12) ~= "table" then
             goto Label_13_match_fail
         end
         Id_1_submatch_13 = Id_1_submatch_12.tag
         if Id_1_submatch_13 ~= "Id" then
             goto Label_13_match_fail
         end
         Id_1_submatch_14 = Id_1_submatch_12[1]
         if Id_1_submatch_14 ~= "self" then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_12 ~= 1 then
             goto Label_13_match_fail
         end
         params = Id_1_submatch_11
         body = Id_1_submatch_9[2]
         if body == nil then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_9 ~= 2 then
             goto Label_13_match_fail
         end
         if # Id_1_submatch_8 ~= 1 then
             goto Label_13_match_fail
         end
         if # Id_11_v ~= 2 then
             goto Label_13_match_fail
         end
          ::Label_12_on_success::
         if not (is_idx_stack (lhs) and is_ident (method)) then
             goto Label_13_match_fail
         end
         do
            self:acc "function "
            self:node (lhs)
            self:acc ":"
            self:acc (method)
            self:acc " ("
            self:list (params, ", ", 2)
            self:acc ")"
            self:nlindent ()
            self:list (body, self.nl)
            self:nldedent ()
            self:acc "end"
         end
          goto Label_10_after_success
          ::Label_13_match_fail::
      end
      do
         local body, Id_1_submatch_6, params, lhs, Id_1_submatch_2, Id_1_submatch_3, Id_1_submatch_5, Id_1_submatch_4
         if type (Id_11_v) ~= "table" then
             goto Label_15_match_fail
         end
         Id_1_submatch_2 = Id_11_v.tag
         if Id_1_submatch_2 ~= "Set" then
             goto Label_15_match_fail
         end
         Id_1_submatch_3 = Id_11_v[1]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_15_match_fail
         end
         lhs = Id_1_submatch_3[1]
         if lhs == nil then
             goto Label_15_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_15_match_fail
         end
         Id_1_submatch_4 = Id_11_v[2]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_15_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4[1]
         if type (Id_1_submatch_5) ~= "table" then
             goto Label_15_match_fail
         end
         Id_1_submatch_6 = Id_1_submatch_5.tag
         if Id_1_submatch_6 ~= "Function" then
             goto Label_15_match_fail
         end
         params = Id_1_submatch_5[1]
         if params == nil then
             goto Label_15_match_fail
         end
         body = Id_1_submatch_5[2]
         if body == nil then
             goto Label_15_match_fail
         end
         if # Id_1_submatch_5 ~= 2 then
             goto Label_15_match_fail
         end
         if # Id_1_submatch_4 ~= 1 then
             goto Label_15_match_fail
         end
         if # Id_11_v ~= 2 then
             goto Label_15_match_fail
         end
          ::Label_14_on_success::
         if not is_idx_stack (lhs) then
             goto Label_15_match_fail
         end
         do
            self:acc "function "
            self:node (lhs)
            self:acc " ("
            self:list (params, ", ")
            self:acc ")"
            self:nlindent ()
            self:list (body, self.nl)
            self:nldedent ()
            self:acc "end"
         end
          goto Label_10_after_success
          ::Label_15_match_fail::
      end
      do
         local Id_1_submatch_2, rhs, lhs1, lhs, Id_1_submatch_5, Id_1_submatch_3, lhs1name, Id_1_submatch_4
         if type (Id_11_v) ~= "table" then
             goto Label_17_match_fail
         end
         Id_1_submatch_2 = Id_11_v.tag
         if Id_1_submatch_2 ~= "Set" then
             goto Label_17_match_fail
         end
         Id_1_submatch_3 = Id_11_v[1]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_17_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3[1]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_17_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4.tag
         if Id_1_submatch_5 ~= "Id" then
             goto Label_17_match_fail
         end
         lhs1name = Id_1_submatch_4[1]
         if lhs1name == nil then
             goto Label_17_match_fail
         end
         if # Id_1_submatch_4 ~= 1 then
             goto Label_17_match_fail
         end
         lhs1 = Id_1_submatch_4
         lhs = Id_1_submatch_3
         rhs = Id_11_v[2]
         if rhs == nil then
             goto Label_17_match_fail
         end
         if # Id_11_v ~= 2 then
             goto Label_17_match_fail
         end
          ::Label_16_on_success::
         if not (not is_ident (lhs1name)) then
             goto Label_17_match_fail
         end
         do
            self:acc "("
            self:node (lhs1)
            self:acc ")"
            if lhs[2] then
               self:acc ", "
               self:list (lhs, ", ", 2)
            end
            self:acc " = "
            self:list (rhs, ", ")
         end
          goto Label_10_after_success
          ::Label_17_match_fail::
      end
      do
         local Id_1_submatch_2, rhs, lhs
         if type (Id_11_v) ~= "table" then
             goto Label_19_match_fail
         end
         Id_1_submatch_2 = Id_11_v.tag
         if Id_1_submatch_2 ~= "Set" then
             goto Label_19_match_fail
         end
         lhs = Id_11_v[1]
         if lhs == nil then
             goto Label_19_match_fail
         end
         rhs = Id_11_v[2]
         if rhs == nil then
             goto Label_19_match_fail
         end
         if # Id_11_v ~= 2 then
             goto Label_19_match_fail
         end
          ::Label_18_on_success::
         do
            self:list (lhs, ", ")
            self:acc " = "
            self:list (rhs, ", ")
         end
          goto Label_10_after_success
          ::Label_19_match_fail::
      end
      do
         local Id_1_submatch_2, rhs, annot, lhs
         if type (Id_11_v) ~= "table" then
             goto Label_21_match_fail
         end
         Id_1_submatch_2 = Id_11_v.tag
         if Id_1_submatch_2 ~= "Set" then
             goto Label_21_match_fail
         end
         lhs = Id_11_v[1]
         if lhs == nil then
             goto Label_21_match_fail
         end
         rhs = Id_11_v[2]
         if rhs == nil then
             goto Label_21_match_fail
         end
         annot = Id_11_v[3]
         if annot == nil then
             goto Label_21_match_fail
         end
         if # Id_11_v ~= 3 then
             goto Label_21_match_fail
         end
          ::Label_20_on_success::
         do
            local n = # lhs
            for i = 1, n do
               local ell, a = lhs[i], annot[i]
               self:node (ell)
               if a then
                  self:acc " #"
                  self:node (a)
               end
               if i ~= n then
                  self:acc ", "
               end
            end
            self:acc " = "
            self:list (rhs, ", ")
         end
          goto Label_10_after_success
          ::Label_21_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L236-298|C6-28|K9257-11269>")
       ::Label_10_after_success::
   end
end

function M:While (node, cond, body)
   self:acc "while "
   self:node (cond)
   self:acc " do"
   self:nlindent ()
   self:list (body, self.nl)
   self:nldedent ()
   self:acc "end"
end

function M:Repeat (node, body, cond)
   self:acc "repeat"
   self:nlindent ()
   self:list (body, self.nl)
   self:nldedent ()
   self:acc "until "
   self:node (cond)
end

function M:If (node)
   for i = 1, # node - 1, 2 do
      local cond, body = node[i], node[i + 1]
      self:acc ((i == 1 and "if ") or "elseif ")
      self:node (cond)
      self:acc " then"
      self:nlindent ()
      self:list (body, self.nl)
      self:nldedent ()
   end
   if # node % 2 == 1 then
      self:acc "else"
      self:nlindent ()
      self:list (node[# node], self.nl)
      self:nldedent ()
   end
   self:acc "end"
end

function M:Fornum (node, var, first, last)
   local body = node[# node]
   self:acc "for "
   self:node (var)
   self:acc " = "
   self:node (first)
   self:acc ", "
   self:node (last)
   if # node == 5 then
      self:acc ", "
      self:node (node[4])
   end
   self:acc " do"
   self:nlindent ()
   self:list (body, self.nl)
   self:nldedent ()
   self:acc "end"
end

function M:Forin (node, vars, generators, body)
   self:acc "for "
   self:list (vars, ", ")
   self:acc " in "
   self:list (generators, ", ")
   self:acc " do"
   self:nlindent ()
   self:list (body, self.nl)
   self:nldedent ()
   self:acc "end"
end

function M:Local (node, lhs, rhs, annots)
   if next (lhs) then
      self:acc "local "
      if annots then
         local n = # lhs
         for i = 1, n do
            self:node (lhs)
            local a = annots[i]
            if a then
               self:acc " #"
               self:node (a)
            end
            if i ~= n then
               self:acc ", "
            end
         end
      else
         self:list (lhs, ", ")
      end
      if rhs[1] then
         self:acc " = "
         self:list (rhs, ", ")
      end
   else
      self:acc (table.tostring (node, "nohash", 80))
   end
end

function M:Localrec (node, lhs, rhs)
   do
      local Id_23_v = node
      do
         local Id_1_submatch_5, body, params, Id_1_submatch_6, name, Id_1_submatch_2, Id_1_submatch_8, Id_1_submatch_3, Id_1_submatch_7, Id_1_submatch_4
         if type (Id_23_v) ~= "table" then
             goto Label_25_match_fail
         end
         Id_1_submatch_2 = Id_23_v.tag
         if Id_1_submatch_2 ~= "Localrec" then
             goto Label_25_match_fail
         end
         Id_1_submatch_3 = Id_23_v[1]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_25_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3[1]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_25_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4.tag
         if Id_1_submatch_5 ~= "Id" then
             goto Label_25_match_fail
         end
         name = Id_1_submatch_4[1]
         if name == nil then
             goto Label_25_match_fail
         end
         if # Id_1_submatch_4 ~= 1 then
             goto Label_25_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_25_match_fail
         end
         Id_1_submatch_6 = Id_23_v[2]
         if type (Id_1_submatch_6) ~= "table" then
             goto Label_25_match_fail
         end
         Id_1_submatch_7 = Id_1_submatch_6[1]
         if type (Id_1_submatch_7) ~= "table" then
             goto Label_25_match_fail
         end
         Id_1_submatch_8 = Id_1_submatch_7.tag
         if Id_1_submatch_8 ~= "Function" then
             goto Label_25_match_fail
         end
         params = Id_1_submatch_7[1]
         if params == nil then
             goto Label_25_match_fail
         end
         body = Id_1_submatch_7[2]
         if body == nil then
             goto Label_25_match_fail
         end
         if # Id_1_submatch_7 ~= 2 then
             goto Label_25_match_fail
         end
         if # Id_1_submatch_6 ~= 1 then
             goto Label_25_match_fail
         end
         if # Id_23_v ~= 2 then
             goto Label_25_match_fail
         end
          ::Label_24_on_success::
         if not is_ident (name) then
             goto Label_25_match_fail
         end
         do
            self:acc "local function "
            self:acc (name)
            self:acc " ("
            self:list (params, ", ")
            self:acc ")"
            self:nlindent ()
            self:list (body, self.nl)
            self:nldedent ()
            self:acc "end"
         end
          goto Label_22_after_success
          ::Label_25_match_fail::
      end
      do
         local _
          ::Label_26_on_success::
         do
            self:acc "-{ "
            self:acc (table.tostring (node, "nohash", 80))
            self:acc " }"
         end
          goto Label_22_after_success
          ::Label_27_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L401-419|C6-19|K13787-14396>")
       ::Label_22_after_success::
   end
end

function M:Call (node, f)
   local parens
   do
      local Id_29_v = node
      do
         local Id_1_submatch_2, Id_1_submatch_3, _, Id_1_submatch_4
         if type (Id_29_v) ~= "table" then
             goto Label_31_match_fail
         end
         Id_1_submatch_2 = Id_29_v.tag
         if Id_1_submatch_2 ~= "Call" then
             goto Label_31_match_fail
         end
         Id_1_submatch_3 = Id_29_v[2]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_31_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3.tag
         if Id_1_submatch_4 ~= "String" then
             goto Label_31_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_31_match_fail
         end
         if # Id_29_v ~= 2 then
             goto Label_31_match_fail
         end
          goto Label_30_on_success
          ::Label_31_match_fail::
         if type (Id_29_v) ~= "table" then
             goto Label_32_match_fail
         end
         Id_1_submatch_2 = Id_29_v.tag
         if Id_1_submatch_2 ~= "Call" then
             goto Label_32_match_fail
         end
         Id_1_submatch_3 = Id_29_v[2]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_32_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3.tag
         if Id_1_submatch_4 ~= "Table" then
             goto Label_32_match_fail
         end
         if # Id_29_v ~= 2 then
             goto Label_32_match_fail
         end
          ::Label_30_on_success::
         do
            parens = false
         end
          goto Label_28_after_success
          ::Label_32_match_fail::
      end
      do
         local _
          ::Label_33_on_success::
         do
            parens = true
         end
          goto Label_28_after_success
          ::Label_34_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L427-429|C6-23|K14549-14640>")
       ::Label_28_after_success::
   end
   self:node (f)
   self:acc ((parens and " (") or " ")
   self:list (node, ", ", 2)
   self:acc (parens and ")")
end

function M:Invoke (node, f, method)
   local parens
   do
      local Id_36_v = node
      do
         local Id_1_submatch_2, Id_1_submatch_3, _, Id_1_submatch_4
         if type (Id_36_v) ~= "table" then
             goto Label_38_match_fail
         end
         Id_1_submatch_2 = Id_36_v.tag
         if Id_1_submatch_2 ~= "Invoke" then
             goto Label_38_match_fail
         end
         Id_1_submatch_3 = Id_36_v[3]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_38_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3.tag
         if Id_1_submatch_4 ~= "String" then
             goto Label_38_match_fail
         end
         if # Id_1_submatch_3 ~= 1 then
             goto Label_38_match_fail
         end
         if # Id_36_v ~= 3 then
             goto Label_38_match_fail
         end
          goto Label_37_on_success
          ::Label_38_match_fail::
         if type (Id_36_v) ~= "table" then
             goto Label_39_match_fail
         end
         Id_1_submatch_2 = Id_36_v.tag
         if Id_1_submatch_2 ~= "Invoke" then
             goto Label_39_match_fail
         end
         Id_1_submatch_3 = Id_36_v[3]
         if type (Id_1_submatch_3) ~= "table" then
             goto Label_39_match_fail
         end
         Id_1_submatch_4 = Id_1_submatch_3.tag
         if Id_1_submatch_4 ~= "Table" then
             goto Label_39_match_fail
         end
         if # Id_36_v ~= 3 then
             goto Label_39_match_fail
         end
          ::Label_37_on_success::
         do
            parens = false
         end
          goto Label_35_after_success
          ::Label_39_match_fail::
      end
      do
         local _
          ::Label_40_on_success::
         do
            parens = true
         end
          goto Label_35_after_success
          ::Label_41_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L441-443|C6-23|K14931-15032>")
       ::Label_35_after_success::
   end
   self:node (f)
   self:acc ":"
   self:acc (method[1])
   self:acc ((parens and " (") or " ")
   self:list (node, ", ", 3)
   self:acc (parens and ")")
end

function M:Return (node)
   self:acc "return "
   self:list (node, ", ")
end

M.Break = "break"

M.Nil = "nil"

M.False = "false"

M.True = "true"

M.Dots = "..."

function M:Number (node, n)
   self:acc (tostring (n))
end

function M:String (node, str)
   self:acc (string.format ("%q", str):gsub ("\\\n", "\\n"))
end

function M:Function (node, params, body, annots)
   self:acc "function ("
   if annots then
      local n = # params
      for i = 1, n do
         local p, a = params[i], annots[i]
         self:node (p)
         if annots then
            self:acc " #"
            self:node (a)
         end
         if i ~= n then
            self:acc ", "
         end
      end
   else
      self:list (params, ", ")
   end
   self:acc ")"
   self:nlindent ()
   self:list (body, self.nl)
   self:nldedent ()
   self:acc "end"
end

function M:Table (node)
   if not node[1] then
      self:acc "{ }"
   else
      self:acc "{"
      if 1 < # node then
         self:nlindent ()
      else
         self:acc " "
      end
      for i, elem in ipairs (node) do
         do
            local Id_43_v = elem
            do
               local key, Id_1_submatch_2, Id_1_submatch_3, value, Id_1_submatch_4
               if type (Id_43_v) ~= "table" then
                   goto Label_45_match_fail
               end
               Id_1_submatch_2 = Id_43_v.tag
               if Id_1_submatch_2 ~= "Pair" then
                   goto Label_45_match_fail
               end
               Id_1_submatch_3 = Id_43_v[1]
               if type (Id_1_submatch_3) ~= "table" then
                   goto Label_45_match_fail
               end
               Id_1_submatch_4 = Id_1_submatch_3.tag
               if Id_1_submatch_4 ~= "String" then
                   goto Label_45_match_fail
               end
               key = Id_1_submatch_3[1]
               if key == nil then
                   goto Label_45_match_fail
               end
               if # Id_1_submatch_3 ~= 1 then
                   goto Label_45_match_fail
               end
               value = Id_43_v[2]
               if value == nil then
                   goto Label_45_match_fail
               end
               if # Id_43_v ~= 2 then
                   goto Label_45_match_fail
               end
                ::Label_44_on_success::
               if not is_ident (key) then
                   goto Label_45_match_fail
               end
               do
                  self:acc (key)
                  self:acc " = "
                  self:node (value)
               end
                goto Label_42_after_success
                ::Label_45_match_fail::
            end
            do
               local Id_1_submatch_2, key, value
               if type (Id_43_v) ~= "table" then
                   goto Label_47_match_fail
               end
               Id_1_submatch_2 = Id_43_v.tag
               if Id_1_submatch_2 ~= "Pair" then
                   goto Label_47_match_fail
               end
               key = Id_43_v[1]
               if key == nil then
                   goto Label_47_match_fail
               end
               value = Id_43_v[2]
               if value == nil then
                   goto Label_47_match_fail
               end
               if # Id_43_v ~= 2 then
                   goto Label_47_match_fail
               end
                ::Label_46_on_success::
               do
                  self:acc "["
                  self:node (key)
                  self:acc "] = "
                  self:node (value)
               end
                goto Label_42_after_success
                ::Label_47_match_fail::
            end
            do
               local _
                ::Label_48_on_success::
               do
                  self:node (elem)
               end
                goto Label_42_after_success
                ::Label_49_match_fail::
            end
            error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L503-518|C12-28|K16462-16893>")
             ::Label_42_after_success::
         end
         if node[i + 1] then
            self:acc ","
            self:nl ()
         end
      end
      if 1 < # node then
         self:nldedent ()
      else
         self:acc " "
      end
      self:acc "}"
   end
end

function M:Op (node, op, a, b)
   do
      local Id_51_v = node
      do
         local Id_1_submatch_5, _b, Id_1_submatch_6, _a, Id_1_submatch_2, Id_1_submatch_8, Id_1_submatch_3, Id_1_submatch_7, Id_1_submatch_4
         if type (Id_51_v) ~= "table" then
             goto Label_53_match_fail
         end
         Id_1_submatch_2 = Id_51_v.tag
         if Id_1_submatch_2 ~= "Op" then
             goto Label_53_match_fail
         end
         Id_1_submatch_3 = Id_51_v[1]
         if Id_1_submatch_3 ~= "not" then
             goto Label_53_match_fail
         end
         Id_1_submatch_4 = Id_51_v[2]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_53_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4.tag
         if Id_1_submatch_5 ~= "Op" then
             goto Label_53_match_fail
         end
         Id_1_submatch_6 = Id_1_submatch_4[1]
         if Id_1_submatch_6 ~= "eq" then
             goto Label_53_match_fail
         end
         _a = Id_1_submatch_4[2]
         if _a == nil then
             goto Label_53_match_fail
         end
         _b = Id_1_submatch_4[3]
         if _b == nil then
             goto Label_53_match_fail
         end
         if # Id_1_submatch_4 ~= 3 then
             goto Label_53_match_fail
         end
         if # Id_51_v ~= 2 then
             goto Label_53_match_fail
         end
          goto Label_52_on_success
          ::Label_53_match_fail::
         if type (Id_51_v) ~= "table" then
             goto Label_54_match_fail
         end
         Id_1_submatch_2 = Id_51_v.tag
         if Id_1_submatch_2 ~= "Op" then
             goto Label_54_match_fail
         end
         Id_1_submatch_3 = Id_51_v[1]
         if Id_1_submatch_3 ~= "not" then
             goto Label_54_match_fail
         end
         Id_1_submatch_4 = Id_51_v[2]
         if type (Id_1_submatch_4) ~= "table" then
             goto Label_54_match_fail
         end
         Id_1_submatch_5 = Id_1_submatch_4.tag
         if Id_1_submatch_5 ~= "Paren" then
             goto Label_54_match_fail
         end
         Id_1_submatch_6 = Id_1_submatch_4[1]
         if type (Id_1_submatch_6) ~= "table" then
             goto Label_54_match_fail
         end
         Id_1_submatch_7 = Id_1_submatch_6.tag
         if Id_1_submatch_7 ~= "Op" then
             goto Label_54_match_fail
         end
         Id_1_submatch_8 = Id_1_submatch_6[1]
         if Id_1_submatch_8 ~= "eq" then
             goto Label_54_match_fail
         end
         _a = Id_1_submatch_6[2]
         if _a == nil then
             goto Label_54_match_fail
         end
         _b = Id_1_submatch_6[3]
         if _b == nil then
             goto Label_54_match_fail
         end
         if # Id_1_submatch_6 ~= 3 then
             goto Label_54_match_fail
         end
         if # Id_1_submatch_4 ~= 1 then
             goto Label_54_match_fail
         end
         if # Id_51_v ~= 2 then
             goto Label_54_match_fail
         end
          ::Label_52_on_success::
         do
            op, a, b = "ne", _a, _b
         end
          goto Label_50_after_success
          ::Label_54_match_fail::
      end
      do
         local _
          ::Label_55_on_success::
         do
            
         end
          goto Label_50_after_success
          ::Label_56_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L533-536|C6-9|K17216-17340>")
       ::Label_50_after_success::
   end
   if b then
      local left_paren, right_paren
      do
         local Id_58_v = a
         do
            local Id_1_submatch_2, op_a
            if type (Id_58_v) ~= "table" then
                goto Label_60_match_fail
            end
            Id_1_submatch_2 = Id_58_v.tag
            if Id_1_submatch_2 ~= "Op" then
                goto Label_60_match_fail
            end
            op_a = Id_58_v[1]
            if op_a == nil then
                goto Label_60_match_fail
            end
             ::Label_59_on_success::
            if not (op_prec[op_a] <= op_prec[op]) then
                goto Label_60_match_fail
            end
            do
               left_paren = true
            end
             goto Label_57_after_success
             ::Label_60_match_fail::
         end
         do
            local _
             ::Label_61_on_success::
            do
               left_paren = false
            end
             goto Label_57_after_success
             ::Label_62_match_fail::
         end
         error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L542-543|C9-31|K17446-17545>")
          ::Label_57_after_success::
      end
      do
         local Id_64_v = b
         do
            local Id_1_submatch_2, op_b
            if type (Id_64_v) ~= "table" then
                goto Label_66_match_fail
            end
            Id_1_submatch_2 = Id_64_v.tag
            if Id_1_submatch_2 ~= "Op" then
                goto Label_66_match_fail
            end
            op_b = Id_64_v[1]
            if op_b == nil then
                goto Label_66_match_fail
            end
             ::Label_65_on_success::
            if not (op_prec[op_b] <= op_prec[op]) then
                goto Label_66_match_fail
            end
            do
               right_paren = true
            end
             goto Label_63_after_success
             ::Label_66_match_fail::
         end
         do
            local _
             ::Label_67_on_success::
            do
               right_paren = false
            end
             goto Label_63_after_success
             ::Label_68_match_fail::
         end
         error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L547-548|C9-32|K17646-17747>")
          ::Label_63_after_success::
      end
      self:acc (left_paren and "(")
      self:node (a)
      self:acc (left_paren and ")")
      self:acc (op_symbol[op])
      self:acc (right_paren and "(")
      self:node (b)
      self:acc (right_paren and ")")
   else
      local paren
      do
         local Id_70_v = a
         do
            local Id_1_submatch_2, op_a
            if type (Id_70_v) ~= "table" then
                goto Label_72_match_fail
            end
            Id_1_submatch_2 = Id_70_v.tag
            if Id_1_submatch_2 ~= "Op" then
                goto Label_72_match_fail
            end
            op_a = Id_70_v[1]
            if op_a == nil then
                goto Label_72_match_fail
            end
             ::Label_71_on_success::
            if not (op_prec[op_a] <= op_prec[op]) then
                goto Label_72_match_fail
            end
            do
               paren = true
            end
             goto Label_69_after_success
             ::Label_72_match_fail::
         end
         do
            local _
             ::Label_73_on_success::
            do
               paren = false
            end
             goto Label_69_after_success
             ::Label_74_match_fail::
         end
         error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L564-565|C9-26|K18058-18148>")
          ::Label_69_after_success::
      end
      self:acc (op_symbol[op])
      self:acc (paren and "(")
      self:node (a)
      self:acc (paren and ")")
   end
end

function M:Paren (node, content)
   self:acc "("
   self:node (content)
   self:acc ")"
end

function M:Index (node, table, key)
   local paren_table
   do
      local Id_76_v = table
      do
         local Id_1_submatch_2, op
         if type (Id_76_v) ~= "table" then
             goto Label_78_match_fail
         end
         Id_1_submatch_2 = Id_76_v.tag
         if Id_1_submatch_2 ~= "Op" then
             goto Label_78_match_fail
         end
         op = Id_76_v[1]
         if op == nil then
             goto Label_78_match_fail
         end
          ::Label_77_on_success::
         if not (op_prec[op] < op_prec.index) then
             goto Label_78_match_fail
         end
         do
            paren_table = true
         end
          goto Label_75_after_success
          ::Label_78_match_fail::
      end
      do
         local _
          ::Label_79_on_success::
         do
            paren_table = false
         end
          goto Label_75_after_success
          ::Label_80_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L584-585|C6-29|K18534-18630>")
       ::Label_75_after_success::
   end
   self:acc (paren_table and "(")
   self:node (table)
   self:acc (paren_table and ")")
   do
      local Id_82_v = key
      do
         local Id_1_submatch_2, field
         if type (Id_82_v) ~= "table" then
             goto Label_84_match_fail
         end
         Id_1_submatch_2 = Id_82_v.tag
         if Id_1_submatch_2 ~= "String" then
             goto Label_84_match_fail
         end
         field = Id_82_v[1]
         if field == nil then
             goto Label_84_match_fail
         end
         if # Id_82_v ~= 1 then
             goto Label_84_match_fail
         end
          ::Label_83_on_success::
         if not is_ident (field) then
             goto Label_84_match_fail
         end
         do
            self:acc "."
            self:acc (field)
         end
          goto Label_81_after_success
          ::Label_84_match_fail::
      end
      do
         local _
          ::Label_85_on_success::
         do
            self:acc "["
            self:node (key)
            self:acc "]"
         end
          goto Label_81_after_success
          ::Label_86_match_fail::
      end
      error ("mismatch at " .. "<@/Users/julian/Documents/metalua/metalua/compiler/ast_to_src.mlua|L593-601|C6-20|K18755-18965>")
       ::Label_81_after_success::
   end
end

function M:Id (node, name)
   if is_ident (name) then
      self:acc (name)
   else
      self:acc "-{`Id "
      self:String (node, name)
      self:acc "}"
   end
end

M.TDyn = "*"

M.TDynbar = "**"

M.TPass = "pass"

M.TField = "field"

M.TIdbar = M.TId

M.TReturn = M.Return

function M:TId (node, name)
   self:acc (name)
end

function M:TCatbar (node, te, tebar)
   self:acc "("
   self:node (te)
   self:acc "|"
   self:tebar (tebar)
   self:acc ")"
end

function M:TFunction (node, p, r)
   self:tebar (p)
   self:acc "->"
   self:tebar (r)
end

function M:TTable (node, default, pairs)
   self:acc "["
   self:list (pairs, ", ")
   if default.tag ~= "TField" then
      self:acc "|"
      self:node (default)
   end
   self:acc "]"
end

function M:TPair (node, k, v)
   self:node (k)
   self:acc "="
   self:node (v)
end

function M:TIdbar (node, name)
   self:acc (name)
end

function M:TCatbar (node, a, b)
   self:node (a)
   self:acc " ++ "
   self:node (b)
end

function M:tebar (node)
   if node.tag then
      self:node (node)
   else
      self:acc "("
      self:list (node, ", ")
      self:acc ")"
   end
end

function M:TUnkbar (node, name)
   self:acc "~~"
   self:acc (name)
end

function M:TUnk (node, name)
   self:acc "~"
   self:acc (name)
end

for name, tag in pairs {
   const = "TConst",
   var = "TVar",
   currently = "TCurrently",
   just = "TJust"
} do
   M[tag] = function (self, node, te)
      self:acc (name .. " ")
      self:node (te)
   end
end

return (function (x)
   return M.run (x)
end)