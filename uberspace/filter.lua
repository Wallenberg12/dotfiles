#!/usr/local/bin/lua
-- use in .qmail-name like that
--   | /usr/bin/spamc --socket=/home/UBERSPACEUSER/tmp/spamd.sock | ./filter.lua ~/users/m/

local stdin = io.stdin:lines()
local MAILDIR = arg[1]
local tool = require "git.dotfiles.knife.tools"
-- https://github.com/markuman/lua-maildir
local md = require "git.lua-maildir.Maildir"

local THIS_MAIL = {}
local RECEIPT_FOUND = false
local SUBJECT_FOUND = false
local FILTER = {}
FILTER["name@example.tld"] = "Maildir Folder"
local DESTINATION = false

for line in stdin do
	table.insert (THIS_MAIL, line)
	
	if ((not RECEIPT_FOUND) and (line:find("To:") == 1)) then
		RECEIPT_FOUND = true
		for k,v in pairs (FILTER) do
			if (line:find(k)) then
				DESTINATION = "INBOX." .. FILTER[k]
			end
		end
	end
	
	if ((not SUBJECT_FOUND) and (line:find("Subject:") == 1)) then
		SUBJECT_FOUND = true
		if (line:find("[SPAM]")) then
			DESTINATION = "SPAM"
		end
	end
end 

local maildir = md.new (MAILDIR)

if (DESTINATION) then
	print("currently not implemented in lua-maildir")
end

maildir:add (table.concat (THIS_MAIL, "\n"))
print(tool.process_information()["memory_peak"])
