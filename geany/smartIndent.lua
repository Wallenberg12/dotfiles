--[[
Smart Indent for bash scripts in geany using lua plugin
https://github.com/markuman/dotfiles/
]]--

--[[
-- some string help functions
--]]
function trim (str)
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end
mt = getmetatable ("")
mt.__index["trim"] = trim

function isMember (str, list)
	for n = 1,#list do
		if (str:find (list[n], 1, true) == 1) then
			return true
		end
	end
	return false
end

-- Check content
valid_shebang  = {"#!/bin/sh", "#!/bin/bash"}
if (geany.text () == nil) then return end
if not (isMember (geany.lines (1), valid_shebang)) then return end

-- Object of reformatted content
local this = {}
setmetatable (this, {__index = table})

-- settings
TAB = "\t"
rep = 0
increase_words = {"for", "while", "if", "function", "{", "case"}
decrease_words = {"done", "fi", "}", "esac"}
neutral_words  = {"el", "elif", "then"}

local line = ""

-- split content into table by new line
for n in geany.lines() do
	line = geany.lines(n):trim()

	-- first decrease
	if (isMember (line, decrease_words)) then
		rep = rep - 1
	end

	-- indent current line
	if (#line == 0) then
		this:insert ("\n")
	elseif (isMember (line, neutral_words)) then
		this:insert (TAB:rep (rep - 1) .. line .. "\n")
	else
		this:insert (TAB:rep (rep) .. line .. "\n")
	end
	
	-- last increase
	if (isMember (line, increase_words)) then
		rep = rep + 1
	end
end 

-- update content
geany.text (this:concat ())
