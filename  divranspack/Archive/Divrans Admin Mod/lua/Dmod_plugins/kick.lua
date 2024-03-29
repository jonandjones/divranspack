-------------------------------------------------------------------------------------------------------------------------
-- Kick
-------------------------------------------------------------------------------------------------------------------------
local DmodPlugin = {}
DmodPlugin.ChatCommand = "kick" -- The chat command you need to use this plugin
DmodPlugin.Name = "Kick" -- The name of the plugin
DmodPlugin.Description = "Allows you to kick someone from your server." -- The description shown in the Menu
DmodPlugin.ShowInMenu = true -- Do you want this plugin to be shown in the menu at all?
DmodPlugin.Type = "administration" -- Where in the Menu will it show?
DmodPlugin.Creator = "Divran" -- Who created it?
DmodPlugin.RequiredRank = "Admin" -- The rank required to use this command. Can be "guest", "respected", "admin", "super admin", or "owner".
if SERVER then Dmod_AddPlugin(DmodPlugin) else Dmod_ClientAddPlugin(DmodPlugin) end


local function Dmod_Plugin( ply, Args )
if (Dmod_CheckRequiredRank(ply, DmodPlugin.RequiredRank)) then
	if (Args[2]) then
		if (Dmod_FindPlayer(Args[2])) then
			local T = Dmod_FindPlayer(Args[2])
			local Reason = Dmod_GetReason(Args, 3)
			T:Kick(Reason)
			Dmod_Message(true, ply, ply:Nick() .. " kicked " .. T:Nick() .. " with the reason '" .. Reason .. "'.","punish")
		else
			Dmod_Message(false, ply, "No player named '"..Args[2].."' found.","warning")
		end
	else
		Dmod_Message( false, ply, "You must enter a name!","warning")
	end
end
end
hook.Add( DmodPlugin.Name, DmodPlugin.Name, Dmod_Plugin )

-------------------------------------------------------------------------------------------------------------------------
-- Get Reason
-------------------------------------------------------------------------------------------------------------------------

function Dmod_GetReason(Args, Num)
	local Rsn = ""
	Rsn = table.concat( Args, " ", Num, table.Count(Args))
	if (string.Trim(Rsn) == "") then Rsn = "No reason" end
	return Rsn
end