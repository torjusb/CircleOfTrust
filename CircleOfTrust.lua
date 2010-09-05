local myname, ns = ...

ns.inviteMatches = {
	['inv'] = true,
	['invite'] = true, 
}

function ns:isFriend (name)
	for i = 1, GetNumFriends() do
		if GetFriendInfo(i) == name then
			return true
		end
	end
	
	for i = 1, BNGetNumFriends() do
		local _,_,_, toonName, _, client = BNGetFriendInfo(i)
		
		if client == 'WoW' and toonName == name then
			return true
		end
	end
			
	if IsInGuild() then
		for i = 1, GetNumGuildMembers() do
			if GetGuildRosterInfo(i) == name then
				return true
			end
		end
	end
end


ns:RegisterEvent("PARTY_INVITE_REQUEST")
function ns:PARTY_INVITE_REQUEST(e, sender)
	if self:isFriend(sender) then
		-- http://gist.github.com/96930
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local frame = getglobal("StaticPopup"..i)
			if frame:IsVisible() and frame.which == "PARTY_INVITE" then
				StaticPopup_OnClick(frame, 1)
			end
		end
	end
end

ns.f:RegisterEvent("CHAT_MSG_WHISPER")
function ns:CHAT_MSG_WHISPER(e, msg, sender)
	if ns.inviteMatches[msg] and ns:isFriend(sender) then
		 InviteUnit(sender)
	end
end

ns.f:RegisterEvent("CHAT_MSG_BN_WHISPER")
function ns:CHAT_MSG_BN_WHISPER(e, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
	print(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15)
end