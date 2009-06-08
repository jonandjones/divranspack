//This admin mod was made by Divran. I know it sucks, but so what
AddCSLuaFile( "autorun/client/d_menu.lua" )
resource.AddFile( "materials/gui/silkicons/lightning.vmt" )
resource.AddFile( "materials/gui/silkicons/lightning.vtf" )
resource.AddFile( "materials/gui/silkicons/exclamation.vmt" )
resource.AddFile( "materials/gui/silkicons/exclamation.vtf" )

--Player Spawn
function FirstSpawn( ply )
	Con( "[D] " .. ply:Nick() .. " has spawned." )
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

function Speak( ply, text, toall )
local Msg = string.Explode(" ", text)
	if (ply:IsAdmin()) then
		local Dis = false
		
		//Menu
		if (string.lower(Msg[1]) == "!menu") then
		ply:ConCommand("D_menu")
		Dis = true
		end
		
		//Tele
		if (string.lower(Msg[1]) == "!tp") then
		D_Tele( ply, Msg[2] )
		Dis = true
		end
		
		//Goto
		if (string.lower(Msg[1]) == "!goto") then
		D_Goto( ply, Msg[2] )
		Dis = true
		end
		
		//Bring
		if (string.lower(Msg[1]) == "!bring") then
		D_Bring( ply, Msg[2] )
		Dis = true
		end
		
		//Send
		if (string.lower(Msg[1]) == "!send") then
		D_Send( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Slay
		if (string.lower(Msg[1]) == "!slay") then
		D_Slay( ply, Msg[2] )
		Dis = true
		end
		
		//Health
		if (string.lower(Msg[1]) == "!hp") then
		D_Health( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Armor
		if (string.lower(Msg[1]) == "!armor") then
		D_Armor( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Speed
		if (string.lower(Msg[1]) == "!speed") then
		D_Speed( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Jump
		if (string.lower(Msg[1]) == "!jump") then
		D_Jump( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Godmode
		if (string.lower(Msg[1]) == "!god") then
		D_God( ply, Msg[2] )
		Dis = true
		end
		
		//Ungodmode
		if (string.lower(Msg[1]) == "!ungod") then
		D_Ungod( ply, Msg[2] )
		Dis = true
		end
		
		//Blow
		if (string.lower(Msg[1]) == "!blow") then
		D_Blow( ply, Msg[2] )
		Dis = true
		end
		
		//Burn
		if (string.lower(Msg[1]) == "!burn") then
		D_Burn( ply, Msg[2] )
		Dis = true
		end
		
		//unburn
		if (string.lower(Msg[1]) == "!unburn") then
		D_Unburn( ply, Msg[2] )
		Dis = true
		end
		
		//Help
		if (string.lower(Msg[1]) == "!help") then
		D_Help( ply )
		Dis = true
		end
		
		//Decals
		if (string.lower(Msg[1]) == "!decals") then
		D_Decals( ply )
		Dis = true
		end
		
		//Kick
		if (string.lower(Msg[1]) == "!kick") then
		local Num = table.Count(Msg)
		local Rsn = ""
		for i = 1, Num do
			if (i > 2) then
				Rsn = Rsn .. Msg[i] .. " "
			end
		end
		D_Kick( ply, Msg[2], Rsn )
		Dis = true
		end
		
		//Ban
		if (string.lower(Msg[1]) == "!ban") then
		local Num = table.Count(Msg)
		local Rsn = ""
		for i = 1, Num do
			if (i > 3) then
				Rsn = Rsn .. Msg[i] .. " "
			end
		end
		D_Ban( ply, Msg[2], Msg[3], Rsn )
		Dis = true
		end
		
		//Freeze
		if (string.lower(Msg[1]) == "!freeze") then
		D_Freeze( ply, Msg[2] )
		Dis = true
		end
		
		//Unfreeze
		if (string.lower(Msg[1]) == "!unfreeze") then
		D_Unfreeze( ply, Msg[2] )
		Dis = true
		end
		
		//Spectate
		if (string.lower(Msg[1]) == "!spectate") then
		D_Spectate( ply, Msg[2], Msg[3] )
		Dis = true
		end
		
		//Unspectate
		if (string.lower(Msg[1]) == "!unspectate") then
		D_Unspectate( ply )
		Dis = true
		end

		if (Dis == true) then
			return ""
		end
	else
		local C = false
		if string.lower(Msg[1]) == "!tp" then C = true end
		if string.lower(Msg[1]) == "!bring" then C = true end
		if string.lower(Msg[1]) == "!goto" then C = true end
		if string.lower(Msg[1]) == "!send" then C = true end
		if string.lower(Msg[1]) == "!slay" then C = true end
		if string.lower(Msg[1]) == "!hp" then C = true end
		if string.lower(Msg[1]) == "!armor" then C = true end
		if string.lower(Msg[1]) == "!speed" then C = true end
		if string.lower(Msg[1]) == "!jump" then C = true end
		if string.lower(Msg[1]) == "!god" then C = true end
		if string.lower(Msg[1]) == "!ungod" then C = true end
		if string.lower(Msg[1]) == "!blow" then C = true end
		if string.lower(Msg[1]) == "!burn" then C = true end
		if string.lower(Msg[1]) == "!unburn" then C = true end
		if string.lower(Msg[1]) == "!help" then C = true end
		if string.lower(Msg[1]) == "!decals" then C = true end
		if string.lower(Msg[1]) == "!kick" then C = true end
		if string.lower(Msg[1]) == "!ban" then C = true end
		if string.lower(Msg[1]) == "!freeze" then C = true end
		if string.lower(Msg[1]) == "!unfreeze" then C = true end
		if string.lower(Msg[1]) == "!spectate" then C = true end
		if string.lower(Msg[1]) == "!unspectate" then C = true end
		if string.lower(Msg[1]) == "!menu" then C = true end
		if C == true then return "", ply:PrintMessage( HUD_PRINTTALK, "[D] You are not an admin!") end
	end
end
hook.Add( "PlayerSay", "Speak", Speak )

----------Print to chat
function Con(Txt)
	for k,v in pairs ( player.GetAll() ) do
		v:PrintMessage( HUD_PRINTTALK, Txt );
	end
end
hook.Add( "Con", "Con", Con )

----------Find Player
function FindPlayer( Nick )
	if !Nick then return nil end
	Nick = string.lower( Nick )
	
	local Exact = false
	if string.Left( Nick, 1 ) == "\"" and string.Right( Nick, 1 ) == "\"" then
		Exact = true
		Nick = string.sub( Nick, 2, string.len(Nick) - 1 )
	end
	
	for _, pl in pairs(player.GetAll()) do
		local n = string.lower( pl:Nick() )
		
		if n == Nick then
			return pl
		elseif string.find( n, Nick ) and !Exact then
			return pl
		end
	end
end

----------Teleport
function D_Tele( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			local Pos = ply:GetEyeTrace()
			T:SetPos( Pos.HitPos + Vector(0,0,1) )
			T:SetLocalVelocity( Vector( 0,0,0 ) )
			Con("[D] " .. ply:Nick() .. " teleported " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		local Pos = ply:GetEyeTrace()
		ply:SetPos( Pos.HitPos + Vector(0,0,1) )
		ply:SetLocalVelocity( Vector( 0,0,0 ) )
		Con("[D] " .. ply:Nick() .. " teleported him/herself.")
	end
end

----------Goto
function D_Goto( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			local Pos = T:GetPos() + T:GetForward() * 100
			ply:SetPos( Pos )
			ply:SetLocalVelocity( Vector( 0,0,0 ) )
			Con("[D] " .. ply:Nick() .. " sent him/herself to " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Bring
function D_Bring( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			local Pos = ply:GetPos() + ply:GetForward() * 100
			T:SetPos( Pos )
			T:SetLocalVelocity( Vector( 0,0,0 ) )
			Con("[D] " .. ply:Nick() .. " brought " .. T:Nick() .. " to him/herself.")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Send
function D_Send( ply, Target, Target2 )
	if (Target and Target != "" and Target2 and Target2 != "") then
		if (FindPlayer(Target) and FindPlayer(Target2)) then
			local T = FindPlayer(Target)
			local T2 = FindPlayer(Target2)
			local Pos = T2:GetPos() + T2:GetForward() * 100
			T:SetPos( Pos )
			T:SetLocalVelocity( Vector( 0,0,0 ) )
			Con("[D] " .. ply:Nick() .. " sent " .. T:Nick() .. " to " .. T2:Nick() .. ".")
		else
			Con("[D] One or more of the players were not found!")
		end
	else
		Con("[D] You must enter two names!")
	end
end

----------Slay
function D_Slay( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:Kill()
			T:AddFrags(1)
			Con("[D] " .. ply:Nick() .. " slayed " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Health
function D_Health( ply, Target, Num )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:SetHealth( math.Clamp( tonumber(Num), 1, 99999 ) )
			Con("[D] " .. ply:Nick() .. " set " .. T:Nick() .. "'s health to " .. T:Health() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Armor
function D_Armor( ply, Target, Num )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:SetArmor( math.Clamp( tonumber(Num), 1, 99999 ) )
			Con("[D] " .. ply:Nick() .. " set " .. T:Nick() .. "'s armor to " .. T:Armor() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Speed
function D_Speed( ply, Target, Num )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			if (Num != nil) then
				T:SetWalkSpeed( math.Clamp( tonumber(Num), 1, 1000000) )
				T:SetRunSpeed( math.Clamp( tonumber(Num+250), 1, 1000000) )
			else
				T:SetWalkSpeed( 250 )
				T:SetRunSpeed( 500 )
				Num = 250
			end
				Con("[D] " .. ply:Nick() .. " set " .. T:Nick() .. "'s movement speed to " .. T:WalkSpeed() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Jump
function D_Jump( ply, Target, Num )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			if (Num != nil) then
				T:SetJumpPower( math.Clamp( tonumber(Num), 1, 1000000) )
			else
				T:SetJumpPower( 160 )
				Num = 160
			end
			Con("[D] " .. ply:Nick() .. " set " .. T:Nick() .. "'s jump strength to " .. T:JumpPower() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Godmode
function D_God( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			T = FindPlayer(Target)
			T:GodEnable( )
			Con("[D] " .. ply:Nick() .. " enabled godmode for " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		ply:GodEnable()
		Con("[D] " .. ply:Nick() .. " enabled godmode for him/herself.")
	end
end

----------UnGodmode
function D_Ungod( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:GodDisable( )
			Con("[D] " .. ply:Nick() .. " disabled godmode for " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		ply:GodDisable()
		Con("[D] " .. ply:Nick() .. " disabled godmode for him/herself.")
	end
end

----------Explode
function D_Blow( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			local Pos = T:GetPos() + Vector(0,0,50)
			util.BlastDamage( ply, ply, Pos , 200, 9001 )
			local effectdata = EffectData()
			effectdata:SetOrigin( Pos )
			util.Effect( "Explosion", effectdata, true, true )
			Con("[D] " .. ply:Nick() .. " blew " .. T:Nick() .. " up.")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
			local Pos = ply:GetPos() + Vector(0,0,50)
			util.BlastDamage( ply, ply, Pos, 200, 9001 )
			local effectdata = EffectData()
			effectdata:SetOrigin( Pos )
			util.Effect( "Explosion", effectdata, true, true )
		Con("[D] " .. ply:Nick() .. " blew him/herself up.")
	end
end

----------Ignite
function D_Burn( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			T = FindPlayer(Target)
			T:Ignite( 35, 0 )
			Con("[D] " .. ply:Nick() .. " set " .. T:Nick() .. " on fire.")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		ply:Ignite( 35, 0 )
		Con("[D] " .. ply:Nick() .. " set him/herself on fire.")
	end
end

----------Unignite
function D_Unburn( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			T = FindPlayer(Target)
			T:Extinguish()
			Con("[D] " .. ply:Nick() .. " unignited " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		ply:Extinguish()
		Con("[D] " .. ply:Nick() .. " unignited him/herself.")
	end
end

----------Help
function D_Help( ply )
	ply:PrintMessage( HUD_PRINTTALK, "[D] (All Silent) A list of all commands:" )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !tp - Teleports you or someone else to where you aim." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !goto, !bring, !send - Go to someone, bring someone, send someone." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !slay, !god, !ungod - Slay someone, make someone invurnable, make someone vurnable." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !hp, !armor, !speed, !jump - Changes someones' health, armor, movement speed or jump strength." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !burn, !unburn, !explode - Ignite someone, unignite someone, make someone explode." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !kick, !ban - !kick <Name> <Reason>, !ban <name> <time (minutes)> <reason>." )
	ply:PrintMessage( HUD_PRINTTALK, "[D] !freeze, !unfreeze - Freeze and unfreeze someone." )
end

----------Decals
function D_Decals( ply )
	for k, v in pairs(player.GetAll()) do
		v:ConCommand("r_cleardecals 1")
	end
	Con("[D] " .. ply:Nick() .. " has cleared the decals.")
end

----------Kick
function D_Kick( ply, Target, Reason )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			T = FindPlayer(Target)
				if (!Reason or Reason == "") then Reason = "No reason" end
				T:Kick(Reason)
				Con("[D] " .. ply:Nick() .. " has kicked " .. T:Nick() .. " with the reason '" .. Reason .. "'.")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You need to enter a name!")
	end
end

----------Ban
function D_Ban( ply, Target, Time, Reason )
	if (Target and Target != "") then
		if (Time and Time != "" and tonumber(Time)) then
			if (FindPlayer(Target)) then
				T = FindPlayer(Target)
					if (!Reason or Reason == "") then Reason = "No reason" end
					T:Ban(tonumber(Time), Reason)
					T:Kick("You've been banned. Reason: '" .. Reason .. "', for " .. Time .. " minutes.")
					Con("[D] " .. ply:Nick() .. " has banned " .. T:Nick() .. " with the reason '" .. Reason .. "' for " .. Time .. " minutes.")
			else
				Con("[D] No player with the name '" .. Target .. "' found!")
			end
		else
			Con("[D] No/invalid time specified!")
		end
	else
		Con("[D] You need to enter a name!")
	end
end

----------Freeze
function D_Freeze( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:Lock()
			Con("[D] " .. ply:Nick() .. " froze " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Unfreeze
function D_Unfreeze( ply, Target )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			T:UnLock()
			Con("[D] " .. ply:Nick() .. " unfroze " .. T:Nick() .. ".")
		else
			Con("[D] No player with the name '" .. Target .. "' found!")
		end
	else
		Con("[D] You must enter a name!")
	end
end

----------Spectate
function D_Spectate( ply, Target, Type )
	if (Target and Target != "") then
		if (FindPlayer(Target)) then
			local T = FindPlayer(Target)
			if (Type == "chase") then
				ply:SetMoveType( MOVETYPE_OBSERVER )
				ply:Spectate( OBS_MODE_CHASE )
				ply:SpectateEntity( T )
				ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You are now spectating '" .. T:Nick() .. "' in chase mode." )
			elseif (Type == "firstperson") then
				ply:SetMoveType( MOVETYPE_OBSERVER )
				ply:Spectate( OBS_MODE_IN_EYE )
				ply:SpectateEntity( T )
				ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You are now spectating '" .. T:Nick() .. "' in first person mode." )
			else
				ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You must enter a spectate type! Types are: 'chase' and 'firstperson'." )
			end
		else
			ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) No player with the name '" .. Target .. "' found!" )
		end
	else
		ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You must enter a name!" )
	end
end

----------Unspectate
function D_Unspectate( ply )
	if (ply:GetMoveType() == MOVETYPE_OBSERVER) then
		ply:SetMoveType( MOVETYPE_WALK )
		ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You are no longer spectating." )
	else
		ply:PrintMessage( HUD_PRINTTALK, "[D] (Silent) You are not spectating!" )
	end
end

----------Command Recieve
function D_CommandRecieve( ply, Com, args )
	if (string.lower(Com) == "dmod") then
		if (args[1] and args[1] != "") then
			if string.lower(args[1]) == "tele" then D_Tele( ply, args[2] ) end
			if string.lower(args[1]) == "goto" then D_Goto( ply, args[2] ) end
			if string.lower(args[1]) == "bring" then D_Bring( ply, args[2] ) end
			if string.lower(args[1]) == "send" then D_Send( ply, args[2], args[3] ) end
			if string.lower(args[1]) == "slay" then D_Slay( ply, args[2] ) end
			if string.lower(args[1]) == "blow" then D_Blow( ply, args[2] ) end
			if string.lower(args[1]) == "health" then D_Health( ply, args[2], 100 ) end
			if string.lower(args[1]) == "armor" then D_Armor( ply, args[2], 100 ) end
			if string.lower(args[1]) == "speed" then D_Speed( ply, args[2] ) end
			if string.lower(args[1]) == "jump" then D_Jump( ply, args[2] ) end
			if string.lower(args[1]) == "god" then D_God( ply, args[2] ) end
			if string.lower(args[1]) == "ungod" then D_Ungod( ply, args[2] ) end
			if string.lower(args[1]) == "burn" then D_Burn( ply, args[2] ) end
			if string.lower(args[1]) == "unburn" then D_Unburn( ply, args[2] ) end
			if string.lower(args[1]) == "help" then D_Help( ply ) end
			if string.lower(args[1]) == "decals" then D_Decals( ply ) end
			if string.lower(args[1]) == "kick" then D_Kick( ply, args[2], "No reason" ) end
			if string.lower(args[1]) == "ban" then D_Ban( ply, args[2], 10, "No reason" ) end
			if string.lower(args[1]) == "freeze" then D_Freeze( ply, args[2] ) end
			if string.lower(args[1]) == "unfreeze" then D_Unfreeze( ply, args[2] ) end
			if string.lower(args[1]) == "spectate" then D_Spectate( ply, args[2] ) end
			if string.lower(args[1]) == "unspectate" then D_Unspectate( ply ) end
		else
		ply:PrintMessage( HUD_PRINTTALK, "[D] You must enter a name!")
		end
	end
end
concommand.Add( "Dmod", D_CommandRecieve )