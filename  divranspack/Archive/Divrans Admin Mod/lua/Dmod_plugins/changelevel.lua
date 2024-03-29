-------------------------------------------------------------------------------------------------------------------------
-- Changelevel
-------------------------------------------------------------------------------------------------------------------------
local DmodPlugin = {}
DmodPlugin.ChatCommand = "changelevel" -- The chat command you need to use this plugin
DmodPlugin.Name = "Changelevel" -- The name of the plugin
DmodPlugin.Description = "Allows you to change the level. Syntax example: '!changelevel sb_gooniverse sb3'" -- The description shown in the Menu
DmodPlugin.ShowInMenu = false -- Do you want this plugin to be shown in the menu at all?
DmodPlugin.Type = "administration" -- Where in the Menu will it show?
DmodPlugin.Creator = "Divran" -- Who created it?
DmodPlugin.RequiredRank = "Super Admin" -- The rank required to use this command. Can be "Guest", "Respected", "Admin", "Super Admin", or "Owner".
if SERVER then Dmod_AddPlugin(DmodPlugin) else Dmod_ClientAddPlugin(DmodPlugin) end


local function Dmod_Plugin( ply, Args )
if (Dmod_CheckRequiredRank(ply, DmodPlugin.RequiredRank)) then
	if (Args[2]) then
		if (Args[3]) then
			game.ConsoleCommand( "changegamemode " .. Args[2] .. " " .. Args[3] .. "\n" )
		else
			game.ConsoleCommand( "changelevel " .. Args[2] .. "\n" )
		end
	else
		Dmod_Message(false, ply, "You must enter a map name!","warning" )
	end
end
end
hook.Add( DmodPlugin.Name, DmodPlugin.Name, Dmod_Plugin )