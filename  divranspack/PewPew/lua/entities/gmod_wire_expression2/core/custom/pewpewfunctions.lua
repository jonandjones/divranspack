-- Returns 1 if the entity is a PewPew Cannon
e2function number entity:pewIsCannon()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() == "pewpew_base_cannon") then return 1 end
	return 0
end

-- Returns the health of the entity
e2function number entity:pewHealth()
	if (!validPhysics(this)) then return 0 end
	return pewpew:GetHealth( this ) or 0
end

-- Returns the max health of the entity
e2function number entity:pewMaxHealth()
	if (!validPhysics(this)) then return 0 end
	local mass = this:GetPhysicsObject():GetMass()
	local boxsize = this:OBBMaxs() - this:OBBMins()
	local hp = (mass / 5 + boxsize:Length())
	return hp or 0
end

-- Returns the health of the core or the entity's core
e2function number entity:pewCoreHealth()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() == "pewpew_core" and this.pewpewCoreHealth) then 
		return this.pewpewCoreHealth 
	elseif (this.Core and validPhysics(this.Core) and this.Core.pewpewCoreHealth) then
		return this.Core.pewpewCoreHealth
	end
	return 0
end

-- Returns the maximum health of the core or the entity's core
e2function number entity:pewCoreMaxHealth()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() == "pewpew_core" and this.pewpewCoreMaxHealth) then 
		return this.pewpewCoreMaxHealth 
	elseif (this.Core and validPhysics(this.Core) and this.Core.pewpewCoreMaxHealth) then
		return this.Core.pewpewCoreMaxHealth
	end
	return 0
end

-- Returns the name of the bullet of the cannon
e2function string entity:pewBulletName()
	if (!validPhysics(this)) then return "" end
	if (this:GetClass() != "pewpew_base_cannon") then return "" end
	return this.Bullet.Name or ""
end

-- Returns the damage
e2function number entity:pewDamage()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Damage or 0
end

-- Returns the amount of ammo
e2function number entity:pewAmmo()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Ammo or 0
end

-- Returns the max ammo
e2function number entity:pewMaxAmmo()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Ammo or 0
end

-- Returns the damage radius
e2function number entity:pewDamageRadius()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Radius or 0
end

-- Returns the reload time
e2function number entity:pewReloadTime()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Reloadtime or 0
end

-- Returns the ammo reload time
e2function number entity:pewAmmoReloadTime()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.AmmoReloadtime or 0
end

-- Returns the spread
e2function number entity:pewSpread()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Spread or 0
end

-- Returns the damage vs players
e2function number entity:pewPlayerDamage()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.PlayerDamage or 0
end

-- Returns the radius vs players
e2function number entity:pewPlayerDamageRadius()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.PlayerDamageRadius or 0
end

-- Returns the speed of the bullet
e2function number entity:pewSpeed()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.Speed or 0
end

-- Returns the pitch change (aka how fast it drops toward the ground)
e2function number entity:pewPitchChange()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.PitchChange or 0
end

-- Returns the recoil force
e2function number entity:pewRecoilForce()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	return this.Bullet.RecoilForce or 0
end


-- Returns the damage type
e2function string entity:pewDamageType()
	if (!validPhysics(this)) then return "" end
	if (this:GetClass() != "pewpew_base_cannon") then return "" end
	return this.Bullet.DamageType or ""
end

-- Returns the author of the bullet
e2function string entity:pewAuthor()
	if (!validPhysics(this)) then return "" end
	if (this:GetClass() != "pewpew_base_cannon") then return "" end
	return this.Bullet.Author or ""
end

-- Returns the description of the bullet
e2function string entity:pewDescription()
	if (!validPhysics(this)) then return "" end
	if (this:GetClass() != "pewpew_base_cannon") then return "" end
	return this.Bullet.Description or ""
end

-- Returns 1 if the cannon can fire and 0 if not
e2function number entity:pewCanFire()
	if (!validPhysics(this)) then return 0 end
	if (this:GetClass() != "pewpew_base_cannon") then return 0 end
	local ret = 0
	if (this.CanFire) then
		ret = 1
	end
	return ret
end