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
if (geany.text () == nil) then geany.status ("smartIndent: File is empty") return end
valid_shebang  = {
	bash = {"#!/bin/sh", "#!/bin/bash"},
	octave = {"#!/usr/bin/octave", "#!/usr/local/bin/octave"},
	lua = {"#!/usr/bin/lua", "#!/usr/local/bin/lua"}
}

-- settings
TAB = "\t"
rep = 0

increase_words = { 
	bash = {"for", "while", "if", "function", "{", "case", "until", "select"},
	octave =  {"for", "while", "if", "function"},
	lua =  {"for", "while", "if", "function"},
}
decrease_words = {
	bash = {"done", "fi", "}", "esac"},
	octave = {"end"},
	lua = {"end"}
}
neutral_words  = {
	bash = {"else", "elif", "then", "do"},
	octave = {"else", "elseif"},
	lua = {"else", "elseif"}
}

-- look for a valid/known shebang in file
for k,v in pairs(valid_shebang) do
	if (isMember (geany.lines (1), valid_shebang[k])) then
		increase_words = increase_words[k]
		decrease_words = decrease_words[k]
		neutral_words = neutral_words[k]
		geany.status ("smartIndent: " .. k)
		break
	end
end

local unknown = function()
	geany.status ("smartIndent: Unkown shebang")
	return
end

--[[
uh this looks so ugly
checking if we can follow indent rules by file extension instead of shebang
--]]
if (#increase_words == 0) then
	local filename = geany.filename ()
	if (filename ~= nil) then		
		local file_extensions = {".sh", ".m", ".lua"}
		local file_ext_idx = {"bash", "octave", "lua"}
		for n = 1,#file_extensions do
			local from, to = filename:find (file_extensions[n], 1, true) 
			if (from ~= nil and to ~= nil) then
				if (#filename == to) then
					local k = file_ext_idx[n]
					increase_words = increase_words[k]
					decrease_words = decrease_words[k]
					neutral_words = neutral_words[k]
					geany.status ("smartIndent: " .. k)
					break
				end
			end
		end
	else
		unknown ()
		return
	end
end
if (#increase_words == 0) then unknown () return end

-- Object of reformatted content
local this = {}
setmetatable (this, {__index = table})


local line = ""
-- split content into table by new line
for n in geany.lines() do
	line = geany.lines(n):trim()

	-- first decrease
	if (isMember (line, decrease_words)) then
		rep = rep - 1
	end

	-- indent current line
	if (#line > 0) then		
		if (isMember (line, neutral_words)) then
			this:insert (TAB:rep (rep - 1))
		else
			this:insert (TAB:rep (rep))
		end
	end
	this:insert (line)
	this:insert ("\n")
	
	-- last increase
	if (isMember (line, increase_words)) then
		rep = rep + 1
	end
end 

-- remove last new line
this:remove()
-- update content
geany.text (this:concat ())
