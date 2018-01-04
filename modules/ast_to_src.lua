-------------------------------------------------------------------------------
-- Copyright (c) 2006-2013 Fabien Fleutot and others.
--
-- All rights reserved.
--
-- This program and the accompanying materials are made available
-- under the terms of the Eclipse Public License v1.0 which
-- accompanies this distribution, and is available at
-- http://www.eclipse.org/legal/epl-v10.html
--
-- This program and the accompanying materials are also made available
-- under the terms of the MIT public license which accompanies this
-- distribution, and is available at http://www.lua.org/license.html
--
-- Contributors:
--     Fabien Fleutot - API and implementation
--
-------------------------------------------------------------------------------

--Modified by Julian Uy to not use Metalua-specific syntax

-- -{ extension ('match', ...) }

local M = { }
M.__index = M

-- local pp = require "metalua.pprint"

--------------------------------------------------------------------------------
-- Instanciate a new AST->source synthetizer
--------------------------------------------------------------------------------
function M.new ()
    local self = {
        _acc = { }, -- Accumulates pieces of source as strings
        current_indent = 0, -- Current level of line indentation
        indent_step = "\t" -- Indentation symbol, normally spaces or '\t'
    }
    return setmetatable (self, M)
end

--------------------------------------------------------------------------------
-- Run a synthetizer on the `ast' arg and return the source as a string.
-- Can also be used as a static method `M.run (ast)'; in this case,
-- a temporary Metizer is instanciated on the fly.
--------------------------------------------------------------------------------
function M:run (ast)
    if not ast then
        self, ast = M.new (), self
    end
    self._acc = {}
    self:node (ast)
    return table.concat (self._acc)
end

--------------------------------------------------------------------------------
-- Accumulate a piece of source file in the synthetizer.
--------------------------------------------------------------------------------
function M:acc (x)
    if x then
        table.insert (self._acc, x)
    end
end

--------------------------------------------------------------------------------
-- Accumulate an indented newline.
-- Jumps an extra line if indentation is 0, so that
-- toplevel definitions are separated by an extra empty line.
--------------------------------------------------------------------------------
function M:nl ()
    if self.current_indent == 0 then
        self:acc "\n"
    end
    self:acc ("\n" .. self.indent_step:rep (self.current_indent))
end

--------------------------------------------------------------------------------
-- Increase indentation and accumulate a new line.
--------------------------------------------------------------------------------
function M:nlindent ()
    self.current_indent = self.current_indent + 1
    self:nl ()
end

--------------------------------------------------------------------------------
-- Decrease indentation and accumulate a new line.
--------------------------------------------------------------------------------
function M:nldedent ()
    self.current_indent = self.current_indent - 1
    self:acc ("\n" .. self.indent_step:rep (self.current_indent))
end

--------------------------------------------------------------------------------
-- Keywords, which are illegal as identifiers.
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Return true if string `id' is a legal identifier name.
--------------------------------------------------------------------------------
local function is_ident (id)
    return string.match (id, "^[%a_][%w_]*$") and not keywords[id]
end

--------------------------------------------------------------------------------
-- Return true if ast represents a legal function name for
-- syntax sugar ``function foo.bar.gnat() ... end'':
-- a series of nested string indexes, with an identifier as
-- the innermost node.
--------------------------------------------------------------------------------
local function is_idx_stack (ast)
    -- match ast with
    -- | `Id{ _ }                     -> return true
    while true do
        if type (ast) ~= "table" then
            break
        end
        if ast.tag ~= "Id" then
            break
        end
        if # ast ~= 1 then
            break
        end
        return true
    end
    -- | `Index{ left, `String{ _ } } -> return is_idx_stack (left)
    while true do
        local Id_1_submatch_3, left
        if type (ast) ~= "table" then
            break
        end
        if ast.tag ~= "Index" then
            break
        end
        left = ast[1]
        if left == nil then
            break
        end
        Id_1_submatch_3 = ast[2]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        if Id_1_submatch_3.tag ~= "String" then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        if # ast ~= 2 then
            break
        end
        
        return is_idx_stack (left)
    end
    -- | _                            -> return false
    return false
end

--------------------------------------------------------------------------------
-- Operator precedences, in increasing order.
-- This is not directly used, it's used to generate op_prec below.
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- operator --> precedence table, generated from op_preprec.
--------------------------------------------------------------------------------
local op_prec = { }

for prec, ops in ipairs (op_preprec) do
    for _, op in ipairs (ops) do
        op_prec[op] = prec
    end
end

--------------------------------------------------------------------------------
-- operator --> source representation.
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Accumulate the source representation of AST `node' in
-- the synthetizer. Most of the work is done by delegating to
-- the method having the name of the AST tag.
-- If something can't be converted to normal sources, it's
-- instead dumped as a `-{ ... }' splice in the source accumulator.
--------------------------------------------------------------------------------
function M:node (node)
    assert (self ~= M and self._acc)
    if node == nil then
        self:acc "<<error>>"
        return 
    end
    if (not node.tag) or (node.tag == "Block") then -- tagless block.
        self:list (node, self.nl)
    else
        local f = M[node.tag]
        if type (f) == "function" then -- Delegate to tag method.
            f (self, node, unpack (node))
        elseif type (f) == "string" then -- tag string.
            self:acc (f)
        else
            -- No appropriate method, fall back to splice dumping.
            -- This cannot happen in a plain Lua AST.
            self:acc " -{ "
            self:acc (pp.tostring (node, {
                metalua_tag = 1,
                hide_hash = 1
            }), 80)
            self:acc " }"
        end
    end
end

--------------------------------------------------------------------------------
-- Convert every node in the AST list `list' passed as 1st arg.
-- `sep' is an optional separator to be accumulated between each list element,
-- it can be a string or a synth method.
-- `start' is an optional number (default == 1), indicating which is the
-- first element of list to be converted, so that we can skip the begining
-- of a list.
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
--
-- Tag methods.
-- ------------
--
-- Specific AST node dumping methods, associated to their node kinds
-- by their name, which is the corresponding AST tag.
-- synth:node() is in charge of delegating a node's treatment to the
-- appropriate tag method.
--
-- Such tag methods are called with the AST node as 1st arg.
-- As a convenience, the n node's children are passed as args #2 ... n+1.
--
-- There are several things that could be refactored into common subroutines
-- here: statement blocks dumping, function dumping...
-- However, given their small size and linear execution
-- (they basically perform series of :acc(), :node(), :list(),
-- :nl(), :nlindent() and :nldedent() calls), it seems more readable
-- to avoid multiplication of such tiny functions.
--
-- To make sense out of these, you need to know metalua's AST syntax, as
-- found in the reference manual or in metalua/doc/ast.txt.
--
--------------------------------------------------------------------------------

function M:Do (node)
    self:acc "do"
    self:nlindent ()
    self:list (node, self.nl)
    self:nldedent ()
    self:acc "end"
end

function M:Set (node)
    -- match node with
    -- ``function foo:bar(...) ... end'' --
    -- | `Set{ { `Index{ lhs, `String{ method } } },
    --   { `Function{ { `Id "self", ... } == params, body } } }
    --   if is_idx_stack (lhs) and is_ident (method) ->
    while true do
        local Id_1_submatch_5, Id_1_submatch_13, Id_1_submatch_14, Id_1_submatch_8, Id_1_submatch_4, method, lhs, Id_1_submatch_2, Id_1_submatch_12, body, Id_1_submatch_6, Id_1_submatch_10, Id_1_submatch_9, Id_1_submatch_11, Id_1_submatch_3, Id_1_submatch_7, params
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Set" then
            break
        end
        Id_1_submatch_3 = node[1]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3[1]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4.tag
        if Id_1_submatch_5 ~= "Index" then
            break
        end
        lhs = Id_1_submatch_4[1]
        if lhs == nil then
            break
        end
        Id_1_submatch_6 = Id_1_submatch_4[2]
        if type (Id_1_submatch_6) ~= "table" then
            break
        end
        Id_1_submatch_7 = Id_1_submatch_6.tag
        if Id_1_submatch_7 ~= "String" then
            break
        end
        method = Id_1_submatch_6[1]
        if method == nil then
            break
        end
        if # Id_1_submatch_6 ~= 1 then
            break
        end
        if # Id_1_submatch_4 ~= 2 then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        Id_1_submatch_8 = node[2]
        if type (Id_1_submatch_8) ~= "table" then
            break
        end
        Id_1_submatch_9 = Id_1_submatch_8[1]
        if type (Id_1_submatch_9) ~= "table" then
            break
        end
        Id_1_submatch_10 = Id_1_submatch_9.tag
        if Id_1_submatch_10 ~= "Function" then
            break
        end
        Id_1_submatch_11 = Id_1_submatch_9[1]
        if type (Id_1_submatch_11) ~= "table" then
            break
        end
        Id_1_submatch_12 = Id_1_submatch_11[1]
        if type (Id_1_submatch_12) ~= "table" then
            break
        end
        Id_1_submatch_13 = Id_1_submatch_12.tag
        if Id_1_submatch_13 ~= "Id" then
            break
        end
        Id_1_submatch_14 = Id_1_submatch_12[1]
        if Id_1_submatch_14 ~= "self" then
            break
        end
        if # Id_1_submatch_12 ~= 1 then
            break
        end
        params = Id_1_submatch_11
        body = Id_1_submatch_9[2]
        if body == nil then
            break
        end
        if # Id_1_submatch_9 ~= 2 then
            break
        end
        if # Id_1_submatch_8 ~= 1 then
            break
        end
        if # node ~= 2 then
            break
        end
         
        if not (is_idx_stack (lhs) and is_ident (method)) then
            break
        end
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
        return
    end
    -- ``function foo(...) ... end'' --
    -- | `Set{ { lhs }, { `Function{ params, body } } } if is_idx_stack (lhs) ->
    while true do
        local body, Id_1_submatch_6, params, lhs, Id_1_submatch_2, Id_1_submatch_3, Id_1_submatch_5, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Set" then
            break
        end
        Id_1_submatch_3 = node[1]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        lhs = Id_1_submatch_3[1]
        if lhs == nil then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        Id_1_submatch_4 = node[2]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4[1]
        if type (Id_1_submatch_5) ~= "table" then
            break
        end
        Id_1_submatch_6 = Id_1_submatch_5.tag
        if Id_1_submatch_6 ~= "Function" then
            break
        end
        params = Id_1_submatch_5[1]
        if params == nil then
            break
        end
        body = Id_1_submatch_5[2]
        if body == nil then
            break
        end
        if # Id_1_submatch_5 ~= 2 then
            break
        end
        if # Id_1_submatch_4 ~= 1 then
            break
        end
        if # node ~= 2 then
            break
        end
         
        if not is_idx_stack (lhs) then
            break
        end
        self:acc "function "
        self:node (lhs)
        self:acc " ("
        self:list (params, ", ")
        self:acc ")"
        self:nlindent ()
        self:list (body, self.nl)
        self:nldedent ()
        self:acc "end"
        return
    end
    -- ``foo, ... = ...'' when foo is *not* a valid identifier.
    -- In that case, the spliced 1st variable must get parentheses,
    -- to be distinguished from a statement splice.
    -- This cannot happen in a plain Lua AST.
    -- | `Set{ { `Id{ lhs1name } == lhs1, ... } == lhs, rhs }
    --   if not is_ident (lhs1name) ->
    while true do
        local Id_1_submatch_2, rhs, lhs1, lhs, Id_1_submatch_5, Id_1_submatch_3, lhs1name, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Set" then
            break
        end
        Id_1_submatch_3 = node[1]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3[1]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4.tag
        if Id_1_submatch_5 ~= "Id" then
            break
        end
        lhs1name = Id_1_submatch_4[1]
        if lhs1name == nil then
            break
        end
        if # Id_1_submatch_4 ~= 1 then
            break
        end
        lhs1 = Id_1_submatch_4
        lhs = Id_1_submatch_3
        rhs = node[2]
        if rhs == nil then
            break
        end
        if # node ~= 2 then
            break
        end
         
        if not (not is_ident (lhs1name)) then
            break
        end
        self:acc "("
        self:node (lhs1)
        self:acc ")"
        if lhs[2] then -- more than one lhs variable
            self:acc ", "
            self:list (lhs, ", ", 2)
        end
        self:acc " = "
        self:list (rhs, ", ")
        return
    end
    -- ``... = ...'', no syntax sugar --
    -- | `Set{ lhs, rhs } ->
    while true do
        local Id_1_submatch_2, rhs, lhs
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Set" then
            break
        end
        lhs = node[1]
        if lhs == nil then
            break
        end
        rhs = node[2]
        if rhs == nil then
            break
        end
        if # node ~= 2 then
            break
        end
        self:list (lhs, ", ")
        self:acc " = "
        self:list (rhs, ", ")
        return
    end
    -- ``... = ...'', no syntax sugar, annotation --
    -- | `Set{ lhs, rhs, annot } ->
    while true do
        local Id_1_submatch_2, rhs, annot, lhs
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Set" then
            break
        end
        lhs = node[1]
        if lhs == nil then
            break
        end
        rhs = node[2]
        if rhs == nil then
            break
        end
        annot = node[3]
        if annot == nil then
            break
        end
        if # node ~= 3 then
            break
        end
    
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
        return
    end
    error ("cannot match Set")
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
        -- for each ``if/then'' and ``elseif/then'' pair --
        local cond, body = node[i], node[i + 1]
        self:acc ((i == 1 and "if ") or "elseif ")
        self:node (cond)
        self:acc " then"
        self:nlindent ()
        self:list (body, self.nl)
        self:nldedent ()
    end
    -- odd number of children --> last one is an `else' clause --
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
    if # node == 5 then -- 5 children --> child #4 is a step increment.
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
    else -- Can't create a local statement with 0 variables in plain Lua
        self:acc (table.tostring (node, "nohash", 80))
    end
end

function M:Localrec (node, lhs, rhs)
    -- match node with

    -- ``local function name() ... end'' --
    -- | `Localrec{ { `Id{name} }, { `Function{ params, body } } }
    --   if is_ident (name) ->
    while true do
        local Id_1_submatch_5, body, params, Id_1_submatch_6, name, Id_1_submatch_2, Id_1_submatch_8, Id_1_submatch_3, Id_1_submatch_7, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Localrec" then
            break
        end
        Id_1_submatch_3 = node[1]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3[1]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4.tag
        if Id_1_submatch_5 ~= "Id" then
            break
        end
        name = Id_1_submatch_4[1]
        if name == nil then
            break
        end
        if # Id_1_submatch_4 ~= 1 then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        Id_1_submatch_6 = node[2]
        if type (Id_1_submatch_6) ~= "table" then
            break
        end
        Id_1_submatch_7 = Id_1_submatch_6[1]
        if type (Id_1_submatch_7) ~= "table" then
            break
        end
        Id_1_submatch_8 = Id_1_submatch_7.tag
        if Id_1_submatch_8 ~= "Function" then
            break
        end
        params = Id_1_submatch_7[1]
        if params == nil then
            break
        end
        body = Id_1_submatch_7[2]
        if body == nil then
            break
        end
        if # Id_1_submatch_7 ~= 2 then
            break
        end
        if # Id_1_submatch_6 ~= 1 then
            break
        end
        if # node ~= 2 then
            break
        end
         
        if not is_ident (name) then
            break
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
        return
    end
    -- Other localrec are unprintable ==> splice them --
    -- This cannot happen in a plain Lua AST. --
    self:acc "-{ "
    self:acc (table.tostring (node, "nohash", 80))
    self:acc " }"
end

function M:Call (node, f)
    -- single string or table literal arg ==> no need for parentheses. --
    local parens = true
    -- match node with
    -- | `Call{ _, `String{_} } -> parens = false
    while true do
        local Id_1_submatch_2, Id_1_submatch_3, _, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Call" then
            break
        end
        Id_1_submatch_3 = node[2]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3.tag
        if Id_1_submatch_4 ~= "String" then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        if # node ~= 2 then
            break
        end
        parens = false
        break
    end
    -- | `Call{ _, `Table{...}} -> parens = false
    while true do
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Call" then
            break
        end
        Id_1_submatch_3 = node[2]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3.tag
        if Id_1_submatch_4 ~= "Table" then
            break
        end
        if # node ~= 2 then
            break
        end
        parens = false
        break
    end
    -- | _ -> parens = true
    self:node (f)
    self:acc ((parens and " (") or " ")
    self:list (node, ", ", 2)
    self:acc (parens and ")")
end

function M:Invoke (node, f, method)
    -- single string or table literal arg ==> no need for parentheses. --
    local parens = true
    while true do
        local Id_1_submatch_2, Id_1_submatch_3, _, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Invoke" then
            break
        end
        Id_1_submatch_3 = node[3]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3.tag
        if Id_1_submatch_4 ~= "String" then
            break
        end
        if # Id_1_submatch_3 ~= 1 then
            break
        end
        if # node ~= 3 then
            break
        end
        parens = false
        break
    end
    while true do
        local Id_1_submatch_2, Id_1_submatch_3, _, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Invoke" then
            break
        end
        Id_1_submatch_3 = node[3]
        if type (Id_1_submatch_3) ~= "table" then
            break
        end
        Id_1_submatch_4 = Id_1_submatch_3.tag
        if Id_1_submatch_4 ~= "Table" then
            break
        end
        if # node ~= 3 then
            break
        end
        parens = false
        break
    end
    self:node (f)
    self:acc ":"
    self:acc (method[1])
    self:acc ((parens and " (") or " ")
    self:list (node, ", ", 3) -- Skip args #1 and #2, object and method name.
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
    -- format "%q" prints '\n' in an unpractical way IMO,
    -- so this is fixed with the :gsub( ) call.
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
            local should_continue = true
            -- match elem with
            -- ``key = value''. --
            -- | `Pair{ `String{ key }, value } if is_ident (key) ->
            while should_continue do
                local key, Id_1_submatch_2, Id_1_submatch_3, value, Id_1_submatch_4
                if type (elem) ~= "table" then
                    break
                end
                Id_1_submatch_2 = elem.tag
                if Id_1_submatch_2 ~= "Pair" then
                    break
                end
                Id_1_submatch_3 = elem[1]
                if type (Id_1_submatch_3) ~= "table" then
                    break
                end
                Id_1_submatch_4 = Id_1_submatch_3.tag
                if Id_1_submatch_4 ~= "String" then
                    break
                end
                key = Id_1_submatch_3[1]
                if key == nil then
                    break
                end
                if # Id_1_submatch_3 ~= 1 then
                    break
                end
                value = elem[2]
                if value == nil then
                    break
                end
                if # elem ~= 2 then
                    break
                end
                if not is_ident (key) then
                    break
                end
                self:acc (key)
                self:acc " = "
                self:node (value)
                should_continue = false
                break
            end
            -- ``[key] = value''. --
            -- | `Pair{ key, value } ->
            while should_continue do
                local Id_1_submatch_2, key, value
                if type (elem) ~= "table" then
                    break
                end
                Id_1_submatch_2 = elem.tag
                if Id_1_submatch_2 ~= "Pair" then
                    break
                end
                key = elem[1]
                if key == nil then
                    break
                end
                value = elem[2]
                if value == nil then
                    break
                end
                if # elem ~= 2 then
                    break
                end
                self:acc "["
                self:node (key)
                self:acc "] = "
                self:node (value)
                should_continue = false
                break
            end
            -- ``value''. --
            -- | _ ->
            while should_continue do
                self:node (elem)
                should_continue = false
                break
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
    -- Transform ``not (a == b)'' into ``a ~= b''. --
    -- match node with
    -- | `Op{ "not", `Op{ "eq", _a, _b } } -> op, a, b = "ne", _a, _b
    while true do
        local Id_1_submatch_5, _b, Id_1_submatch_6, _a, Id_1_submatch_2, Id_1_submatch_8, Id_1_submatch_3, Id_1_submatch_7, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Op" then
            break
        end
        Id_1_submatch_3 = node[1]
        if Id_1_submatch_3 ~= "not" then
            break
        end
        Id_1_submatch_4 = node[2]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4.tag
        if Id_1_submatch_5 ~= "Op" then
            break
        end
        Id_1_submatch_6 = Id_1_submatch_4[1]
        if Id_1_submatch_6 ~= "eq" then
            break
        end
        _a = Id_1_submatch_4[2]
        if _a == nil then
            break
        end
        _b = Id_1_submatch_4[3]
        if _b == nil then
            break
        end
        if # Id_1_submatch_4 ~= 3 then
            break
        end
        if # node ~= 2 then
            break
        end
        op, a, b = "ne", _a, _b
        break
    end
    -- | `Op{ "not", `Paren{ `Op{ "eq", _a, _b } } } -> op, a, b = "ne", _a, _b
    while true do
        local Id_1_submatch_5, _b, Id_1_submatch_6, _a, Id_1_submatch_2, Id_1_submatch_8, Id_1_submatch_3, Id_1_submatch_7, Id_1_submatch_4
        if type (node) ~= "table" then
            break
        end
        Id_1_submatch_2 = node.tag
        if Id_1_submatch_2 ~= "Op" then
            break
        end
        Id_1_submatch_3 = node[1]
        if Id_1_submatch_3 ~= "not" then
            break
        end
        Id_1_submatch_4 = node[2]
        if type (Id_1_submatch_4) ~= "table" then
            break
        end
        Id_1_submatch_5 = Id_1_submatch_4.tag
        if Id_1_submatch_5 ~= "Paren" then
            break
        end
        Id_1_submatch_6 = Id_1_submatch_4[1]
        if type (Id_1_submatch_6) ~= "table" then
            break
        end
        Id_1_submatch_7 = Id_1_submatch_6.tag
        if Id_1_submatch_7 ~= "Op" then
            break
        end
        Id_1_submatch_8 = Id_1_submatch_6[1]
        if Id_1_submatch_8 ~= "eq" then
            break
        end
        _a = Id_1_submatch_6[2]
        if _a == nil then
            break
        end
        _b = Id_1_submatch_6[3]
        if _b == nil then
            break
        end
        if # Id_1_submatch_6 ~= 3 then
            break
        end
        if # Id_1_submatch_4 ~= 1 then
            break
        end
        if # node ~= 2 then
            break
        end
        op, a, b = "ne", _a, _b
        break
    end
    if b then -- binary operator.
        local left_paren = false
        local right_paren = false
        -- match a with
        -- `Op{ op_a, ...} if op_prec[op] >= op_prec[op_a] -> left_paren = true
        while true do
            local op_a
            if type (a) ~= "table" then
                break
            end
            if a.tag ~= "Op" then
                break
            end
            op_a = a[1]
            if op_a == nil then
                break
            end
            if not (op_prec[op_a] <= op_prec[op]) then
                break
            end
            left_paren = true
            break
        end
        -- FIXME: might not work with right assoc operators ^ and ..
        -- match b with
        -- `Op{ op_b, ...} if op_prec[op] >= op_prec[op_b] -> right_paren = true
        while true do
            local op_b
            if type (b) ~= "table" then
                break
            end
            if b.tag ~= "Op" then
                break
            end
            op_b = b[1]
            if op_b == nil then
                break
            end
            if not (op_prec[op_b] <= op_prec[op]) then
                break
            end
            right_paren = true
            break
        end
        self:acc (left_paren and "(")
        self:node (a)
        self:acc (left_paren and ")")
        self:acc (op_symbol[op])
        self:acc (right_paren and "(")
        self:node (b)
        self:acc (right_paren and ")")
    else -- unary operator.
        local paren = false
        -- match a with
        -- | `Op{ op_a, ... } if op_prec[op] >= op_prec[op_a] -> paren = true
        while true do
            local op_a
            if type (a) ~= "table" then
                break
            end
            if a.tag ~= "Op" then
                break
            end
            op_a = a[1]
            if op_a == nil then
                break
            end
            if not (op_prec[op_a] <= op_prec[op]) then
                break
            end
            paren = true
            break
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
    local paren_table = false
    -- Check precedence, see if parens are needed around the table --
    -- match table with
    -- | `Op{ op, ... } if op_prec[op] < op_prec.index -> paren_table = true
    while true do
        local op
        if type (table) ~= "table" then
            break
        end
        if table.tag ~= "Op" then
            break
        end
        op = table[1]
        if op == nil then
            break
        end
        
        if not (op_prec[op] < op_prec.index) then
            break
        end
        paren_table = true
        break
    end
    -- | _ -> paren_table = false

    self:acc (paren_table and "(")
    self:node (table)
    self:acc (paren_table and ")")

    -- match key with
    -- ``table.key''. --
    -- | `String{ field } if is_ident (field) ->
    while true do
        if type (key) ~= "table" then
            break
        end
        if key.tag ~= "String" then
            break
        end
        local field = key[1]
        if field == nil then
            break
        end
        if # key ~= 1 then
            break
        end

        if not is_ident (field) then
            break
        end
        self:acc "."
        self:acc (field)
        return
    end
    -- ``table [key]''. --
    -- | _ ->
    self:acc "["
    self:node (key)
    self:acc "]"
end

function M:Id (node, name)
    if is_ident (name) then
        self:acc (name)
    else 
        -- Unprintable identifier, fall back to splice representation.
        -- This cannot happen in a plain Lua AST.
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
