AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.WireDebugName = "E2 Graphics Processor"

function ENT:Initialize()	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	self.RenderTable = {}
	self.OldRenderTable = {}
	
	self.Outputs = WireLib.CreateOutputs( self, { "link [WIRELINK]" } )
	WireLib.TriggerOutput( self, "link", self )
end