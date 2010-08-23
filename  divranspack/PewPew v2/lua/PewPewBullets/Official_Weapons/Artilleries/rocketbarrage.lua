-- Basic Missile

local BULLET = {}

-- General Information
BULLET.Name = "Rocket Barrage"
BULLET.Author = "Divran"
BULLET.Description = "Fires dozens of rockets in an arc which cover a large area."
BULLET.AdminOnly = false
BULLET.SuperAdminOnly = false

-- Appearance
BULLET.Model = "models/aamissile.mdl"
BULLET.Material = "phoenix_storms/gear"
BULLET.Color = nil
BULLET.Trail = nil

-- Effects / Sounds
BULLET.FireSound = {"arty/rocket.wav"}
BULLET.ExplosionSound = {"weapons/explode3.wav","weapons/explode4.wav","weapons/explode5.wav"}
BULLET.FireEffect = nil
BULLET.ExplosionEffect = "v2splode"

-- Movement
BULLET.Speed = 60
BULLET.Gravity = 0.2
BULLET.RecoilForce = 0
BULLET.Spread = 2
BULLET.AffectedBySBGravity = true

-- Damage
BULLET.DamageType = "BlastDamage"
BULLET.Damage = 150
BULLET.Radius = 250
BULLET.RangeDamageMul = 0.5
BULLET.NumberOfSlices = nil
BULLET.SliceDistance = nil
BULLET.PlayerDamage = 150
BULLET.PlayerDamageRadius = 300

-- Reloading/Ammo
BULLET.Reloadtime = 0.2
BULLET.Ammo = 16
BULLET.AmmoReloadtime = 8

BULLET.EnergyPerShot = 220

pewpew:AddWeapon( BULLET )