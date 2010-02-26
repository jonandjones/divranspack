-- Basic Cannon

local BULLET = {}

-- General Information
BULLET.Name = "105mm Cannon"
BULLET.Category = "Cannons"
BULLET.Author = "Divran"
BULLET.Description = "Slow rate of fire, high damage."
BULLET.AdminOnly = false
BULLET.SuperAdminOnly = false

-- Appearance
BULLET.Model = "models/combatmodels/tankshell.mdl"
BULLET.Material = nil
BULLET.Color = nil
BULLET.Trail = nil

-- Effects / Sounds
BULLET.FireSound = {"arty/105mm.wav"}
BULLET.ExplosionSound = {"weapons/explode1.wav","weapons/explode2.wav"}
BULLET.FireEffect = "cannon_flare"
BULLET.ExplosionEffect = "big_splosion"

-- Movement
BULLET.Speed = 145
BULLET.Gravity = 0.1
BULLET.RecoilForce = 500
BULLET.Spread = 0

-- Damage
BULLET.DamageType = "BlastDamage" -- Look in gcombat_damagecontrol.lua for available damage types
BULLET.Damage = 800
BULLET.Radius = 800
BULLET.RangeDamageMul = 0.8
BULLET.NumberOfSlices = nil
BULLET.SliceDistance = nil
BULLET.PlayerDamage = 400
BULLET.PlayerDamageRadius = 800

-- Reloading/Ammo
BULLET.Reloadtime = 8
BULLET.Ammo = 0
BULLET.AmmoReloadtime = 0

pewpew:AddBullet( BULLET )