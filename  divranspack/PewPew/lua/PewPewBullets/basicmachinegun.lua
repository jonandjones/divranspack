-- Basic Machinegun

local BULLET = {}

-- General Information
BULLET.Name = "Basic Machinegun"

-- Appearance
BULLET.Model = "models/combatmodels/tankshell_25mm.mdl"

-- Effects / Sounds
BULLET.FireSound = "arty/20mmauto.wav"
BULLET.ExplosionSound = nil
BULLET.FireEffect = "muzzleflash"
BULLET.ExplosionEffect = "mghit"

-- Movement
BULLET.Speed = 65
BULLET.PitchChange = 0.15
BULLET.RecoilForce = 2
BULLET.Spread = 0.3

-- Damage
BULLET.DamageType = "PointDamage" -- Look in gcombat_damagecontrol.lua for available damage types
BULLET.Damage = 8
BULLET.Radius = nil
BULLET.RangeDamageMul = nil
BULLET.PlayerDamageRadius = 60
BULLET.PlayerDamage = 6

-- Other
BULLET.Reloadtime = 0.06

-- Custom Functions 
-- (If you set the override var to true, the cannon will run these instead. Use these functions to do stuff which is not possible with the above variables)

-- Fire (Is called before the cannon is about to fire)
BULLET.FireOverride = false
function BULLET:Fire( self )
	-- Nothing
end

-- Initialize (Is called when the entity initializes)
BULLET.InitOverride = false
function BULLET:InitializeFunc( self )   
	-- Nothing
end

-- Think (Is called a lot of times :p)
BULLET.ThinkOverride = false
function BULLET:ThinkFunc( self )
	-- Nothing
end

-- Explode (Is called when the bullet explodes) Note: this will not run if you override the think function (unless you call it from there as well)
BULLET.ExplodeOverride = false
function BULLET:Explode( self, trace )
	-- Nothing
end

pewpew:AddBullet( BULLET )