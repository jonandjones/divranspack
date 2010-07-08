local ID

local function Update( self, this )
	self.data.EGP[this] = true
end

-------------
-- Save
-------------

__e2setcost(20)

e2function void wirelink:egpSaveFrame( string index )
	if (!EGP:ValidEGP( this )) then return end
	if (!index or index == "") then return end
	EGP:SaveFrame( self.player, this, index )
	Update(self,this)
end

e2function void wirelink:egpSaveFrame( index )
	if (!EGP:ValidEGP( this )) then return end
	if (!index) then return end
	EGP:SaveFrame( self.player, this, tostring(index) )
	Update(self,this)
end

-------------
-- Load
-------------

__e2setcost(30)

e2function void wirelink:egpLoadFrame( string index )
	if (!EGP:IsAllowed( self, this )) then return end
	if (!index or index == "") then return end
	EGP:LoadFrame( self.player, this, index )
	Update(self,this)
end

e2function void wirelink:egpLoadFrame( number index )
	if (!EGP:IsAllowed( self, this )) then return end
	if (!index) then return end
	EGP:LoadFrame( self.player, this, tostring(index) )
	Update(self,this)
end

__e2setcost(15)

--------------------------------------------------------
-- Box
--------------------------------------------------------
e2function void wirelink:egpBox( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Box"], { index = index, w = size[1], h = size[2], x = pos[1], y = pos[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Text
--------------------------------------------------------
e2function void wirelink:egpText( number index, string text, vector2 pos )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Text"], { index = index, text = text, x = pos[1], y = pos[2] }, self.player )
	if (bool) then Update(self,this) end
end

__e2setcost(10)

----------------------------
-- Set Text
----------------------------
e2function void wirelink:egpSetText( number index, string text )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { text = text }, self.player )) then Update(self,this) end
	end
end

----------------------------
-- Alignment
----------------------------
e2function void wirelink:egpAlign( number index, number halign )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { halign = math.Clamp(halign,0,2) }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpAlign( number index, number halign, number valign )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { valign = math.Clamp(valign,0,2), halign = math.Clamp(halign,0,2) }, self.player )) then Update(self,this) end
	end
end

----------------------------
-- Font
----------------------------
e2function void wirelink:egpFont( number index, string font )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		local fontid = 0
		for k,v in ipairs( EGP.ValidFonts ) do
			if (v:lower() == font:lower()) then
				fontid = k
			end
		end
		if (EGP:EditObject( v, { fontid = fontid }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpFont( number index, string font, number size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		local fontid = 0
		for k,v in ipairs( EGP.ValidFonts ) do
			if (v:lower() == font:lower()) then
				fontid = k
			end
		end
		if (EGP:EditObject( v, { fontid = fontid, size = size }, self.player )) then Update(self,this) end
	end
end


__e2setcost(15)

--------------------------------------------------------
-- BoxOutline
--------------------------------------------------------
e2function void wirelink:egpBoxOutline( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["BoxOutline"], { index = index, w = size[1], h = size[2], x = pos[1], y = pos[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Poly
--------------------------------------------------------

__e2setcost(20)

e2function void wirelink:egpPoly( number index, ... )
	if (!EGP:IsAllowed( self, this )) then return end
	if (!EGP:ValidEGP( this )) then return end
	local args = {...}
	if (#args<3) then return end -- No less than 3
	if (#args>17) then return end -- No more than 17
	
	 -- Each arg must be a vec2 or vec4
	for k,v in ipairs( args ) do 
		if (typeids[k] != "xv2" and typeids[k] != "xv4") then return end 
	end
	
	local vertices = {}
	for k,v in ipairs( args ) do
		if (typeids[k] == "xv2") then
			table.insert( vertices, { x = v[1], y = v[2] } )
		else
			table.insert( vertices, { x = v[1], y = v[2], u = v[3], v = v[4] } )
		end
	end
	
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Poly"], { index = index, vertices = vertices }, self.player )
	if (bool) then Update(self,this) end
end

e2function void wirelink:egpPoly( number index, array args )
	if (!EGP:IsAllowed( self, this )) then return end
	if (!EGP:ValidEGP( this )) then return end
	if (#args<3) then return end -- No less than 3
	if (#args>17) then return end -- No more than 17
	
	-- Each arg must be a vec2 or vec4
	for k,v in ipairs( args ) do 
		if ((type(v) != "table" or #v != 2) and (type(v) != "table" or #v != 4)) then return end 
	end
	
	local vertices = {}
	for k,v in ipairs( args ) do
		if (#v == 2) then
			table.insert( vertices, { x = v[1], y = v[2] } )
		else
			table.insert( vertices, { x = v[1], y = v[2], u = v[3], v = v[4] } )
		end
	end
	
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Poly"], { index = index, vertices = vertices }, self.player )
	if (bool) then Update(self,this) end
end

__e2setcost(15)

--------------------------------------------------------
-- Line
--------------------------------------------------------
e2function void wirelink:egpLine( number index, vector2 pos1, vector2 pos2 )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Line"], { index = index, x = pos1[1], y = pos1[2], x2 = pos2[1], y2 = pos2[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Circle
--------------------------------------------------------
e2function void wirelink:egpCircle( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Circle"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Circle Outline
--------------------------------------------------------
e2function void wirelink:egpCircleOutline( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["CircleOutline"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Triangle
--------------------------------------------------------
e2function void wirelink:egpTriangle( number index, vector2 vert1, vector2 vert2, vector2 vert3 )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Triangle"], { index = index, x = vert1[1], y = vert1[2], x2 = vert2[1], y2 = vert2[2], x3 = vert3[1], y3 = vert3[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- Triangle Outline
--------------------------------------------------------
e2function void wirelink:egpTriangleOutline( number index, vector2 vert1, vector2 vert2, vector2 vert3 )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["TriangleOutline"], { index = index, x = vert1[1], y = vert1[2], x2 = vert2[1], y2 = vert2[2], x3 = vert3[1], y3 = vert3[2] }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- PacMan Circle
--------------------------------------------------------
e2function void wirelink:egpWedge( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["WEdge"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2] }, self.player )
	if (bool) then Update(self,this) end
end

e2function void wirelink:egpWedge( number index, vector2 pos, vector2 size, number angle, number mouthsize )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Wedge"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2], size = mouthsize, angle = angle }, self.player )
	if (bool) then Update(self,this) end
end

--------------------------------------------------------
-- PacMan Circle Outline
--------------------------------------------------------
e2function void wirelink:egpWedgeOutline( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["WedgeOutline"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2] }, self.player )
	if (bool) then Update(self,this) end
end

e2function void wirelink:egpWedgeOutline( number index, vector2 pos, vector2 size, number angle, number mouthsize )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["WedgeOutline"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2], size = mouthsize, angle = angle }, self.player )
	if (bool) then Update(self,this) end
end

--[[
--------------------------------------------------------
-- Camera
--------------------------------------------------------
e2function void wirelink:egpCamera( number index, vector2 pos, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Camera"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2] }, self.player )
	if (bool) then Update(self,this) end
end

e2function void wirelink:egpAngle( number index, angle ang )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { camang = Angle(ang[1],ang[2],ang[3]) }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpPos( number index, vector pos )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { campos = Vector(pos[1],pos[2],pos[3]) }, self.player )) then Update(self,this) end
	end
end


--------------------------------------------------------
-- Avatar Image
--------------------------------------------------------
e2function void wirelink:egpAvatar( number index, vector2 pos, vector2 size, entity ply )
	if (!EGP:IsAllowed( self, this )) then return end
	if (!ply or !ply:IsValid() or !ply:IsPlayer()) then return end
	local bool, obj = EGP:CreateObject( this, EGP.Objects.Names["Avatar"], { index = index, x = pos[1], y = pos[2], w = size[1], h = size[2], ply = ply }, self.player )
	if (bool) then Update(self,this) end
end
]]
	
--------------------------------------------------------
-- Set functions
--------------------------------------------------------

__e2setcost(10)

----------------------------
-- Size
----------------------------
e2function void wirelink:egpSize( number index, vector2 size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { w = size[1], h = size[2] }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpSize( number index, number size )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { size = size }, self.player )) then Update(self,this) end
	end
end

----------------------------
-- Position
----------------------------
e2function void wirelink:egpPos( number index, vector2 pos )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { x = pos[1], y = pos[2] }, self.player )) then Update(self,this) end
	end
end

----------------------------
-- Angle
----------------------------

e2function void wirelink:egpAngle( number index, number angle )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { angle = angle }, self.player )) then Update(self,this) end
	end
end

-------------
-- Position & Angle
-------------

e2function void wirelink:egpAngle( number index, vector2 worldpos, vector2 axispos, number angle )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.x and v.y and v.angle) then
			
			local vec, ang = LocalToWorld(Vector(axispos[1],axispos[2],0), Angle(0,0,0), Vector(worldpos[1],worldpos[2],0), Angle(0,angle,0))
			
			local x = vec.x
			local y = vec.y
			
			angle = -ang.yaw
			
			if (EGP:EditObject( v, { x = x, y = y, angle = angle }, self.player )) then Update(self,this) end
		end
	end
end

----------------------------
-- Color
----------------------------
e2function void wirelink:egpColor( number index, vector4 color )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { r = color[1], g = color[2], b = color[3], a = color[4] }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpColor( number index, vector color )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { r = color[1], g = color[2], b = color[3] }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpColor( number index, r,g,b,a )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { r = r, g = g, b = b, a = a }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpAlpha( number index, number a )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { a = a }, self.player )) then Update(self,this) end
	end
end


----------------------------
-- Material
----------------------------
e2function void wirelink:egpMaterial( number index, string material )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (EGP:EditObject( v, { material = material }, self.player )) then Update(self,this) end
	end
end

e2function void wirelink:egpMaterialFromScreen( number index, entity gpu )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool and gpu and gpu:IsValid()) then
		if (EGP:EditObject( v, { material = gpu }, self.player )) then Update(self,this) end
	end
end

----------------------------
-- Parenting
----------------------------
e2function void wirelink:egpParent( number index, number parentindex )
	if (!EGP:IsAllowed( self, this )) then return end
	if (EGP:SetParent( this, index, parentindex )) then Update( self, this ) end
end

e2function void wirelink:egpUnParent( number index )
	if (!EGP:IsAllowed( self, this )) then return end
	if (EGP:UnParent( this, index )) then Update( self, this ) end
end

e2function number wirelink:egpParent( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.parent) then
			return v.parent
		end
	end
	return 0
end
	
--------------------------------------------------------
-- Clear & Remove
--------------------------------------------------------
e2function void wirelink:egpClear()
	if (!EGP:IsAllowed( self, this )) then return end
	if (EGP:ValidEGP( this )) then
		this.RenderTable = {}
		Update(self,this)
	end
end

e2function void wirelink:egpRemove( number index )
	if (!EGP:IsAllowed( self, this )) then return end
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		table.remove( this.RenderTable, k )
		Update(self,this)
	end
end

--------------------------------------------------------
-- Get functions
--------------------------------------------------------

__e2setcost(5)

e2function vector2 wirelink:egpPos( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.x and v.y) then
			return {v.x, v.y}
		end
	end
	return {-1,-1}
end

e2function vector2 wirelink:egpSize( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.w and v.h) then
			return {v.w, v.h}
		end
	end
	return {-1,-1}
end

e2function number wirelink:egpSize( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.size) then
			return v.size
		end
	end
	return -1
end

e2function vector4 wirelink:egpColor4( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.r and v.g and v.b and v.a) then
			return {v.r,v.g,v.b,v.a}
		end
	end
	return {-1,-1,-1,-1}
end

e2function vector wirelink:egpColor( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.r and v.g and v.b) then
			return {v.r,v.g,v.b}
		end
	end
	return {-1,-1,-1}
end

e2function number wirelink:egpAlpha( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.a) then
			return v.a
		end
	end
	return -1
end

e2function number wirelink:egpAngle( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.angle) then
			return v.angle
		end
	end
	return -1
end

e2function string wirelink:egpMaterial( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.material) then
			return v.material
		end
	end
	return ""
end

__e2setcost(10)

e2function array wirelink:egpVertices( number index )
	local bool, k, v = EGP:HasObject( this, index )
	if (bool) then
		if (v.vertices) then
			local ret = {}
			for k2,v2 in ipairs( v.vertices ) do
				table.insert( ret, {v2.x,v2.y} )
			end
			return ret
		elseif (v.x and v.y and v.x2 and v.y2) then
			return {{v.x,v.y},{v.x2,v.y2}}
		elseif (v.x and v.y and v.x2 and v.y2 and v.x3 and v.y3) then
			return {{v.x,v.y},{v.x2,v.y2},{v.x3,v.y3}}
		end
	end
	return {}
end


--------------------------------------------------------
-- Additional Functions
--------------------------------------------------------

__e2setcost(20)

e2function vector2 wirelink:egpCursor( entity ply )
	if (!EGP:ValidEGP( this )) then return {-1,-1} end
	if (!ply or !ply:IsValid() or !ply:IsPlayer()) then return {-1,-1} end
	
	local monitor = WireGPU_Monitors[this:GetModel()]
	local ang = this:LocalToWorldAngles(monitor.rot)
	local pos = this:LocalToWorld(monitor.offset)
	local h = 512
	local w = h/monitor.RatioX
	local x = -w/2
	local y = -h/2

	local trace = ply:GetEyeTraceNoCursor()
	local ent = trace.Entity

	local cx = -1
	local cy = -1
	
	if (!EGP:ValidEGP( ent )) then return {-1,-1} end
	
	if (ent == this) then
		local dist = trace.Normal:Dot(trace.HitNormal)*trace.Fraction*-16384
		dist = math.max(dist, trace.Fraction*16384-ent:BoundingRadius())
		local cpos = WorldToLocal(trace.HitPos, Angle(), pos, ang)
		cx = (0.5+cpos.x/(monitor.RS*w)) * 512
		cy = (0.5-cpos.y/(monitor.RS*h)) * 512	
	end
	
	return {cx,cy}
end

--------------------------------------------------------
-- Useful functions
--------------------------------------------------------

e2function number wirelink:egpNumObjects()
	if (!EGP:ValidEGP( this )) then return -1 end
	return #this.RenderTable
end

e2function number egpMaxObjects()
	return EGP.ConVars.MaxObjects:GetInt()
end

e2function number egpMaxEdits()
	return EGP.ConVars.MaxPerInterval:GetInt()
end

e2function number egpInterval()
	return EGP.ConVars.Interval:GetFloat() * 1000
end

e2function number egpCanEdit()
	return (EGP:CheckInterval( self.player, true ) and 1 or 0)
end

--------------------------------------------------------
-- Callbacks
--------------------------------------------------------

__e2setcost(nil)

registerCallback("postexecute",function(self)
	for k,v in pairs( self.data.EGP ) do
		if (k and k:IsValid()) then
			if (v == true) then
				EGP:Transmit( k, self )
				self.data.EGP[k] = nil
			end
		else
			self.data.EGP[k] = nil
		end
	end	
end)

registerCallback("construct",function(self)
	self.data.EGP = {}
end)