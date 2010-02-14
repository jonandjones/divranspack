-- Helicopter Bomb

local BULLET = {}

-- General Information
BULLET.Name = "Helicopter Bomb"
BULLET.Category = "Explosives"
BULLET.Author = "Divran"
BULLET.Description = "Drops a bomb very much like the one the attack helicopter drops in HL2."
BULLET.AdminOnly = false
BULLET.SuperAdminOnly = false

-- Appearance
BULLET.Model = "models/Combine_Helicopter/helicopter_bomb01.mdl"
BULLET.Material = nil
BULLET.Color = nil
BULLET.Trail = nil

-- Effects / Sounds
BULLET.FireSound = {"npc/attack_helicopter/aheli_mine_drop1.wav"}
BULLET.ExplosionSound = {"weapons/explode3.wav","weapons/explode4.wav","weapons/explode5.wav"}
BULLET.FireEffect = nil
BULLET.ExplosionEffect = "big_splosion"

-- Movement
BULLET.Speed = nil
BULLET.PitchChange = nil
BULLET.RecoilForce = nil
BULLET.Spread = nil

-- Damage
BULLET.DamageType = "BlastDamage"
BULLET.Damage = 600
BULLET.Radius = 800
BULLET.RangeDamageMul = 0.6
BULLET.NumberOfSlices = nil
BULLET.PlayerDamage = 500
BULLET.PlayerDamageRadius = 500

-- Reloading/Ammo
BULLET.Reloadtime = 3
BULLET.Ammo = 0
BULLET.AmmoReloadtime = 0

-- Custom Functions 
-- (If you set the override var to true, the cannon/bullet will run these instead. Use these functions to do stuff which is not possible with the above variables)

-- Fire (Is called before the cannon is about to fire)
BULLET.FireOverride = false
function BULLET:Fire( self )
	-- Nothing
end

-- Initialize (Is called when the entity initializes)
BULLET.InitializeOverride = true
function BULLET:InitializeFunc(self)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	
	constraint.NoCollide(self.Entity, self.Cannon.Entity, 0, 0)
	
	self.Entity:NextThink(CurTime())
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:SetVelocity(self.Cannon:GetVelocity())
	end
	
	self.Entity.BombSound = CreateSound(self.Entity,Sound("npc/attack_helicopter/aheli_mine_seek_loop1.wav"))
	self.Entity.BombSound:Play()
	self.Timer = CurTime() + 50
	self.Collided = 0
end

-- Think (Is called a lot of times :p)
BULLET.ThinkOverride = true
function BULLET:ThinkFunc( self )
	if (CurTime() > self.Timer) then
		if (pewpew.pewpewDamage) then
			util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), self.Bullet.Damage, self.Bullet.Radius)
		end
		pewpew:BlastDamage(self:GetPos(), self.Bullet.Radius, self.Bullet.Damage, self.Bullet.RangeDamageMul)
		
		if (self.Bullet.ExplosionEffect) then
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			effectdata:SetStart(self:GetPos())
			effectdata:SetNormal(self.Entity:GetUp())
			util.Effect(self.Bullet.ExplosionEffect, effectdata)
		end
		
		-- Sounds
		if (self.Bullet.ExplosionSound) then
			local soundpath = ""
			if (table.Count(self.Bullet.ExplosionSound) > 1) then
				soundpath = table.Random(self.Bullet.ExplosionSound)
			else
				soundpath = self.Bullet.ExplosionSound[1]
			end
			WorldSound( soundpath, self.Entity:GetPos(),100,100)
		end
		
		self.Entity.BombSound:Stop()
		self:Remove()
	end
end

-- Explode (Is called when the bullet explodes) Note: this will not run if you override the think function (unless you call it from there as well)
BULLET.ExplodeOverride = false
function BULLET:Explode( self, trace )
	
end

-- This is called when the bullet collides (Advanced users only. It only works if you first override initialize and change it to vphysics)
BULLET.PhysicsCollideOverride = true
function BULLET:PhysicsCollideFunc(CollisionData, PhysObj)
	if (CollisionData.HitEntity:IsWorld() and self.Collided == 0) then
		self.Timer = CurTime() + 8
		self.Collided = 1
	end
	if (!CollisionData.HitEntity:IsWorld() and (self.Collided == 0 or self.Collided == 1)) then
		self.Timer = CurTime() + 0.1
		self.Collided = 2
	end
end

-- Client side overrides:

BULLET.CLInitializeOverride = false
function BULLET:CLInitializeFunc()
	-- Nothing
end

BULLET.CLThinkOverride = false
function BULLET:CLThinkFunc()
	-- Nothing
end

BULLET.CLDrawOverride = false
function BULLET:CLDrawFunc()
	-- Nothing
end

pewpew:AddBullet( BULLET )
