-- Green Laser

local BULLET = {}

-- General Information
BULLET.Name = "Green Star Wars Laser"
BULLET.Category = "Lasers"
BULLET.Author = "Divran"
BULLET.Description = "The green Star Wars laser."
BULLET.AdminOnly = false
BULLET.SuperAdminOnly = false

-- Appearance
BULLET.Model = "models/PenisColada/greenlaser.mdl"
BULLET.Material = nil
BULLET.Color = nil
BULLET.Trail = nil

-- Effects / Sounds
BULLET.FireSound = {"starwars/green.wav"}
BULLET.ExplosionSound = nil
BULLET.FireEffect = nil
BULLET.ExplosionEffect = nil

-- Movement
BULLET.Speed = 95
BULLET.PitchChange = 0.01
BULLET.RecoilForce = 0
BULLET.Spread = 0.3

-- Damage
BULLET.DamageType = "PointDamage"
BULLET.Damage = 225
BULLET.Radius = nil
BULLET.RangeDamageMul = nil
BULLET.NumberOfSlices = nil
BULLET.PlayerDamage = 95
BULLET.PlayerDamageRadius = 60

-- Reloading/Ammo
BULLET.Reloadtime = 0.25
BULLET.Ammo = 5
BULLET.AmmoReloadtime = 1.5

-- Custom Functions 
-- (If you set the override var to true, the cannon/bullet will run these instead. Use these functions to do stuff which is not possible with the above variables)

-- Wire Input
BULLET.WireInputOverride = false
function BULLET:WireInput( inputname, value )
	-- Nothing
end

-- Fire (Is called before the cannon is about to fire)
BULLET.FireOverride = false
function BULLET:Fire( self )
	-- Nothing
end

-- Initialize (Is called when the bullet initializes)
BULLET.InitializeOverride = false
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

-- This is called when the bullet collides (Advanced users only. It only works if you first override initialize and change it to vphysics)
BULLET.PhysicsCollideOverride = false
function BULLET:PhysicsCollideFunc(CollisionData, PhysObj)
	-- Nothing
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