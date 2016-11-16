-- 
-- <user> has quit (Leaving...)
-- otr disconnect in buffer "&bitlbee

-- <user> has joined &bitlbee
-- otr reconnect in buffer "&bitlbee

-- init
local w = weechat

-- todo: read variablelist from weechat buffer
local user1 = "exampleuser"


-- weechat.register(Name, Author, Version, Lizenz, Beschreibung, Shutdown_Funktion, Zeichensatz)
w.register("OTRMeise", "markus", "17.0", "WTFPL", "OTR Hooks für user mit lausigen xmpp client", "", "")
w.print("", "OTRMeise passt jetzt auf!")

-- perform otr disconnect user1
function otr_disconnect (data, signal, signal_data)
	local nick = w.info_get("irc_nick_from_host", signal_data)
	if (nick == user1) then
		local buffer = w.info_get("irc_buffer", "osuv,&bitlbee")
		w.command(buffer, "otr disconnect " .. user1)
		w.print("", "OTRMeise: otr disconnect " .. user1)
	elseif (nick == user2) then
		local buffer = w.info_get("irc_buffer", "osuv,&bitlbee")
		w.command(buffer, "otr disconnect " .. user2)
		w.print("", "OTRMeise: otr disconnect " .. user2)
	end
	return w.WEECHAT_RC_OK
end -- otr_disconnect

-- perform otr reconnect user
function otr_reconnect (data, signal, signal_data)
	local nick = w.info_get("irc_nick_from_host", signal_data)
	if (nick == user1) then
		local buffer = w.info_get("irc_buffer", "osuv,&bitlbee")
		w.command(buffer, "otr connect " .. user1)
		w.print("", "OTRMeise: otr connect " .. user1)
	elseif (nick == user2) then
		local buffer = w.info_get("irc_buffer", "osuv,&bitlbee")
		w.command("", "OTRMeise: otr connect " .. user2)
		w.print("", "OTRMeise: otr connect " .. user2)
	end
	return w.WEECHAT_RC_OK
end -- otr_disconnect

w.hook_signal("*,irc_in2_quit", "otr_disconnect", "")
w.hook_signal("*,irc_in2_join", "otr_reconnect", "")
