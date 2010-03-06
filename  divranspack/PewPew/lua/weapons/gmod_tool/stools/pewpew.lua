-- PewTool
-- This is the tool used to spawn all PewPew weapons

TOOL.Category = "PewPew"
TOOL.Name = "PewPew"
TOOL.ClientConVar[ "bulletname" ] = ""
TOOL.ClientConVar[ "model" ] = "models/combatmodels/tank_gun.mdl"
TOOL.ClientConVar[ "fire_key" ] = "1"
TOOL.ClientConVar[ "reload_key" ] = "2"

cleanup.Register("pewpew")

local PewPewModels = { 	["models/combatmodels/tank_gun.mdl"] = {},
						["models/props_junk/TrafficCone001a.mdl"] = {},
						["models/props_lab/huladoll.mdl"] = {},
						["models/props_c17/oildrum001.mdl"] = {},
						["models/props_trainstation/trainstation_column001.mdl"] = {},
						["models/Items/combine_rifle_ammo01.mdl"] = {},
						["models/props_combine/combine_mortar01a.mdl"] = {},
						["models/props_combine/breenlight.mdl"] = {},
						["models/props_c17/pottery03a.mdl"] = {},
						["models/props_junk/PopCan01a.mdl"] = {},
						["models/props_trainstation/trainstation_post001.mdl"] = {},
						["models/props_c17/signpole001.mdl"] = {} }


-- This needs to be shared...
function TOOL:GetCannonModel()
	local mdl = self:GetClientInfo("model")
	if (!util.IsValidModel(mdl) or !util.IsValidProp(mdl)) then return "models/combatmodels/tank_gun.mdl" end
	return mdl
end
						
if (SERVER) then
	AddCSLuaFile("pewpew.lua")
	CreateConVar("sbox_maxpewpew", 6)
	
	function TOOL:GetBulletName()
		local name = self:GetClientInfo("bulletname") or nil
		if (!name) then return end
		return name
	end
	
	function TOOL:CreateCannon( ply, trace, Model, Bullet, fire, reload )
		if (!ply:CheckLimit("pewpew")) then return end
		local ent = ents.Create( "pewpew_base_cannon" )
		if (!ent:IsValid()) then return end
		
		-- Pos/Model/Angle
		ent:SetModel( Model )
		ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().z )
		ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0) )
		
		ent:SetOptions( Bullet, ply, fire, reload )
		
		ent:Spawn()
		ent:Activate()
		return ent
	end
	
	function TOOL:LeftClick( trace )
		if (!trace) then return end
		local ply = self:GetOwner()
		
		-- Get the bullet
		local bullet = pewpew:GetBullet( self:GetBulletName() )
		if (!bullet) then 
			ply:ChatPrint("That PewPew bullet does not exist!")
			return 
		end
		
		-- Check admin only
		if (bullet.AdminOnly and !ply:IsAdmin()) then 
			ply:ChatPrint("You must be an admin to spawn this PewPew weapon.")
			return false
		end
		if (bullet.SuperAdminOnly and !ply:IsSuperAdmin()) then
			ply:ChatPrint("You must be a super admin to spawn this PewPew weapon.")
			return false
		end
		
		-- Get the model
		local model = self:GetCannonModel()
		if (!model) then return end
		
		-- Numpad buttons
		local fire = self:GetClientNumber( "fire_key" )
		local reload = self:GetClientNumber( "reload_key" )
		
		-- If the trace hit an entity
		local traceent = trace.Entity
		if (traceent and traceent:IsValid() and traceent:GetClass() == "pewpew_base_cannon") then
			if (traceent.Owner != ply and !ply:IsAdmin()) then
				ply:ChatPrint("You are not allowed to update other people's cannons.")
				return
			end
			-- Update it
			traceent:SetOptions( bullet, ply, fire, reload )
			ply:ChatPrint("PewPew Cannon updated with bullet: " .. bullet.Name)
		else
			-- else create a new one
			
			local ent = self:CreateCannon( ply, trace, model, bullet, fire, reload )
			if (!ent or !ent:IsValid()) then return end
			
			if (!traceent:IsWorld() and !traceent:IsPlayer()) then
				local weld = constraint.Weld( ent, trace.Entity, 0, trace.PhysicsBone, 0 )
				local nocollide = constraint.NoCollide( ent, trace.Entity, 0, trace.PhysicsBone )
			end
				
			ply:AddCount( "pewpew", ent)
			ply:AddCleanup( "pewpew", ent )

			undo.Create( "pewpew" )
				undo.AddEntity( ent )
				undo.AddEntity( weld )
				undo.AddEntity( nocollide )
				undo.SetPlayer( ply )
			undo.Finish()
		end
			
		return true
	end
	
	function TOOL:RightClick( trace )
		if (!trace) then return end
		local ply = self:GetOwner()
		
		-- Get the bullet
		local bullet = pewpew:GetBullet( self:GetBulletName() )
		if (!bullet) then 
			ply:ChatPrint("That PewPew bullet does not exist!")
			return 
		end
		
		-- Check admin only
		if (bullet.AdminOnly and !ply:IsAdmin()) then 
			ply:ChatPrint("You must be an admin to spawn this PewPew weapon.")
			return false
		end
		if (bullet.SuperAdminOnly and !ply:IsSuperAdmin()) then
			ply:ChatPrint("You must be a super admin to spawn this PewPew weapon.")
			return false
		end
		
		-- Get the model
		local model = self:GetCannonModel()
		if (!model) then return end
		
		-- Numpad buttons
		local fire = self:GetClientNumber( "fire_key" )
		local reload = self:GetClientNumber( "reload_key" )
		
		-- If the trace hit an entity
		local traceent = trace.Entity
		if (traceent and traceent:IsValid() and traceent:GetClass() == "pewpew_base_cannon") then
			if (traceent.Owner != ply and !ply:IsAdmin()) then
				ply:ChatPrint("You are not allowed to update other people's cannons.")
				return
			end
			-- Update it
			traceent:SetOptions( bullet, ply, fire, reload )
			ply:ChatPrint("PewPew Weapon updated with bullet: " .. bullet.Name)
		else
			-- else create a new one
			local ent = self:CreateCannon( ply, trace, model, bullet, fire, reload )
			if (!ent) then return end	
			
			ply:AddCount("pewpew",ent)
			ply:AddCleanup ( "pewpew", ent )

			undo.Create( "pewpew" )
				undo.AddEntity( ent )
				undo.SetPlayer( ply )
			undo.Finish()
				
			return true
		end
	end
	
	function TOOL:Reload( trace )
		if (trace.Hit) then
			if (trace.Entity and ValidEntity(trace.Entity) and !trace.Entity:IsPlayer()) then
				self:GetOwner():ConCommand("pewpew_model " .. trace.Entity:GetModel())
				self:GetOwner():ChatPrint("PewPew Cannon model set to: " .. trace.Entity:GetModel())
			end
		end
	end	
else
	language.Add( "Tool_pewpew_name", "PewTool" )
	language.Add( "Tool_pewpew_desc", "Used to spawn PewPew weaponry." )
	language.Add( "Tool_pewpew_0", "Primary: Spawn a PewPew weapon and weld it, Secondary: Spawn a PewPew weapon and don't weld it, Reload: Change the model of the weapon." )
	language.Add( "undone_pewpew", "Undone PewPew Weapon" )
	language.Add( "Cleanup_pewpew", "PewPew Weapons" )
	language.Add( "Cleaned_pewpew", "Cleaned up all PewPew Weapons" )
	language.Add( "SBoxLimit_pewpew", "You've reached the PewPew Weapon limit!" )
	
	
	function TOOL.BuildCPanel( CPanel )
		-- Header stuff
		CPanel:ClearControls()
		CPanel:AddHeader()
		CPanel:AddDefaultControls()
		CPanel:AddControl("Header", { Text = "#Tool_pewpew_name", Description = "#Tool_pewpew_desc" })
		
		CPanel:AddControl("ComboBox", {
			Label = "#Presets",
			MenuButton = "1",
			Folder = "pewpew",

			Options = {
				Default = {
					pewpew_model = "models/combatmodels/tank_gun.mdl",
					pewpew_bulletname = "",
				}
			},

			CVars = {
				[0] = "pewpew_model",
				[1] = "pewpew_bulletname",
			}
		})
		
		-- (Thanks to Grocel for making this selectable icon thingy)
		CPanel:AddControl( "PropSelect", {
			Label = "#Models (Or click Reload to select a model)",
			ConVar = "pewpew_model",
			Category = "PewPew",
			Models = PewPewModels
		})

		-- Bullets	
			local label = vgui.Create("DLabel")
			label:SetText("Left click to select, right click for info.")
			label:SizeToContents()
			
			-- Panel List 1
			local list1 = vgui.Create("DPanelList")
			list1:SetHeight( 300 )
			list1:SetAutoSize( false )
			list1:SetSpacing( 1 )
			list1:EnableHorizontal( false ) 
			list1:EnableVerticalScrollbar( true )

			-- Loop through all categories
			for key, value in pairs( pewpew.Categories ) do
				-- Create a Collapsible Category for each
				local cat = vgui.Create( "DCollapsibleCategory" )
				cat:SetSize( 146, 50 )
				cat:SetExpanded( 0 )
				cat:SetLabel( key )
				
				-- Create a list inside each collapsible category
				local list = vgui.Create("DPanelList")
				list:SetAutoSize( true )
				list:SetSpacing( 2 )
				list:EnableHorizontal( false ) 
				list:EnableVerticalScrollbar( true )
				
				-- Loop through all weapons in each category
				for key2, value2 in pairs( pewpew.Categories[key] ) do
					-- Create a button for each list
					local btn = vgui.Create("DButton")
					btn:SetSize( 48, 20 )
					btn:SetText( value2 )
					-- Set bullet, change weapon, and close menu
					btn.DoClick = function()
						RunConsoleCommand("pewpew_bulletname", value2)
					end
					btn.DoRightClick = function()
						RunConsoleCommand("PewPew_UseMenu", value2)
					end
					list:AddItem( btn )
				end
				
				cat:SetContents( list )
				list1:AddItem( cat )
			end
			
		CPanel:AddItem(label)
		CPanel:AddItem(list1)
		
		local label = vgui.Create("DLabel")
		label:SetText([[To open this weapons menu in a seperate 
		window, use the console command: 
		'PewPew_WeaponMenu'
		or
		'+PewPew_WeaponMenu']])
		label:SizeToContents()
		
		CPanel:AddItem(label)
			
		CPanel:AddControl( "Numpad", { Label = "#Fire", Command = "pewpew_fire_key", ButtonSize = 22 } )
		CPanel:AddControl( "Numpad", { Label = "#Reload", Command = "pewpew_reload_key", ButtonSize = 22 } )
	end

	-- Ghost functions (Thanks to Grocel for making the base. I changed it a bit)
	function TOOL:UpdateGhostCannon( ent, player )
		if (!ent or !ent:IsValid()) then return end
		local trace = player:GetEyeTrace()
		
		if (!trace.Hit or (trace.Entity and trace.Entity:GetClass() == "pewpew_base_cannon") or trace.Entity:IsPlayer()) then
			ent:SetNoDraw( true )
			return
		end
		
		ent:SetAngles( trace.HitNormal:Angle() + Angle(90,0,0) )
		ent:SetPos( trace.HitPos - trace.HitNormal * ent:OBBMins().z )
		
		ent:SetNoDraw( false )
	end
	
	function TOOL:Think()
		local model = self:GetCannonModel()
		if (!self.GhostEntity or !self.GhostEntity:IsValid() or self.GhostEntity:GetModel() != model) then
			local trace = self:GetOwner():GetEyeTrace()
			self:MakeGhostEntity( Model(model), trace.HitPos, trace.HitNormal:Angle() + Angle(90,0,0) )
		end
		self:UpdateGhostCannon( self.GhostEntity, self:GetOwner() )
	end
end