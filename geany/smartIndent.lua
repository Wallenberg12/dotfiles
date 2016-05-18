--[[
Smart Indent for bash scripts in geany using lua plugin
]]--

-- Current content
local content = geany.text ()
if (content == nil) then
	return
end


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


-- Object of reformatted content
local this = {}
setmetatable (this, {__index = table})

-- settings
TAB = "\t"
rep = 0
increase_words = {"for", "while", "if"}
decrease_words = {"done", "fi"}
neutral_words  = {"el", "elif", "then"}

-- split content into table by new linr
for line in string.gmatch(content, "([^\n]+)") do
	line = line:trim ()
	
	-- first decrease
	if (isMember (line, decrease_words)) then
		rep = rep - 1
	end
	
	-- minimum repeats of tab is 0
	rep = math.max (rep, 0)
	
	-- indent current line
	if (isMember (line, neutral_words)) then
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
