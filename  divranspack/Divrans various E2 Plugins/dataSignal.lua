--[[
dataSignal
Made by Divran
Thanks to Syranide for helping.

dataSignals are a combination of signals and gvars. 
Instead of using one to trigger the E2, and the other
to send the data, dataSignals can both trigger the E2 AND
send the data at the same time.

Have fun!
]]

E2Lib.RegisterExtension("datasignal", true)

---------------------------------------------
-- Lua helper functions

local signalname = ""
local data = nil
local sender = nil
local datatype = nil
local runbydatasignal = 0

local groups = {}
groups.default = {}
local queue = {}

-----------------
-- Check if the signal should be allowed
local function IsAllowed( fromscope, froment, toscope, toent )
	if (fromscope == 0) then -- If scope is 0, only send to E2s you own
		return E2Lib.isOwner( froment, toent )
	elseif (fromscope == 1) then -- If scope is 1, send to friends and E2s you own
		return (E2Lib.isOwner( froment, toent ) or E2Lib.isFriend( froment.player, toent.player ))
	elseif (fromscope == 2) then -- If scope is 2, send to everyone
		if (E2Lib.isOwner( froment, toent )) then -- If you are the owner, go ahead
			return true
		else
			return toscope == 2 -- Check if the recieving E2 allows you to send signals to it
		end
	end
	return false
end

local E2toE2

--------------
-- Queue
local QueueIndex = 1

local function CheckQueue( ent )
	if (#queue == 0) then return end
	if (runbydatasignal == 1) then return end
	runbydatasignal = 1

	while true do
		if (QueueIndex > #queue) then break end
		if (queue[QueueIndex] == nil) then break end
		local s = queue[QueueIndex]
			if (s.to and s.to:IsValid()) then
				signalname = s.name
				data = s.var
				datatype = s.vartype
				sender = s.from
				s.to:Execute()
				
				if (s.from and s.from:IsValid()) then
					s.from.context.prf = s.from.context.prf + 80 -- Add 80 to ops
				end
			end
		QueueIndex = QueueIndex + 1 
	end

	data = nil
	datatype = nil
	sender = 0
	signalname = ""
	
	runbydatasignal = 0
	QueueIndex = 1
	queue = {}
end

registerCallback("postexecute",function(self)
	CheckQueue(self.entity)
end)

------------
-- Sending from one E2 to another

function E2toE2( signalname, from, to, var, vartype ) -- For sending from an E2 to another E2
	if (!from or !from:IsValid() or from:GetClass() != "gmod_wire_expression2") then return 0 end -- Failed
	if (!to or !to:IsValid() or to:GetClass() != "gmod_wire_expression2") then return 0 end -- Failed
	if (!from.context or !to.context) then return 0 end -- OSHI-
	if (!IsAllowed( from.context.datasignal.scope, from, to.context.datasignal.scope, to )) then return 0 end -- Not allowed.
	if (!var or !vartype) then return 0 end -- Failed
	
	queue[#queue+1] = { name = signalname, from = from, to = to, var = var, vartype = vartype } -- Add to queue

	return 1 -- Transfer successful
end

---------------------
-- Send from one E2 to an entire group of E2s
local function E2toGroup( signalname, from, groupname, scope, var, vartype ) -- For sending from an E2 to an entire group. Returns 0 if ANY of the sends failed
	if (groupname == nil) then groupname = from.context.datasignal.group end
	if (scope == nil) then scope = from.context.datasignal.scope end
	
	local ret = 1
	if (groups[groupname]) then
		for k,v in pairs( groups[groupname] ) do
			local toent = Entity(k) -- Get the entity
			if (toent != from) then
				local tempret = E2toE2( signalname, from, toent, var, vartype ) -- Send the signal
				if (tempret == 0) then -- Did the send fail?
					ret = 0
				end
			end
		end
	else
		return 0
	end
	return ret
end

local function ChangeGroup( self, groupname )
	if (self.datasignal.group == groupname) then return end -- Nothing changed!

	-- Remove the E2 from the previous group
	groups[self.datasignal.group][self.entity:EntIndex()] = nil
	
	if (self.datasignal.group != "default") then -- Do not remove the default group
		-- If there are no more E2s in this group, remove it
		if (table.Count(groups[self.datasignal.group]) == 0) then
			groups[self.datasignal.group] = nil
		end
	end
	
	-- Set the group
	self.datasignal.group = groupname
	
	-- If that group does not exist, create it
	if (!groups[groupname]) then
		groups[groupname] = {}
	end
	
	-- Add the E2 to that group
	groups[groupname][self.entity:EntIndex()] = true
end

-- Get a table of E2s which the signal would have been sent to if it was sent
local function GetE2s( froment, groupname, scope )
	local ret = {}
	
	if (groups[groupname]) then
		for k,v in pairs( groups[groupname] ) do
			local ent = Entity(k)
			if (IsAllowed( scope, froment, ent.context.datasignal.scope, ent )) then
				table.insert( ret, ent )
			end
		end
	end
	
	return ret
end

-- Upperfirst, used by the E2 functions below
local function upperfirst( word )
	return word:Left(1):upper() .. word:Right(-2):lower()
end

---------------------------------------------
-- E2 functions

-- Add support for EVERY SINGLE type. Yeah!!
for k,v in pairs( wire_expression_types ) do
	if (k == "NORMAL") then k = "NUMBER" end
	k = string.lower(k)
	
	__e2setcost(10)

	-- Send a signal directly to another E2
	registerFunction("dsSendDirect","se"..v[1],"n",function(self,args)
		local op1, op2, op3 = args[2], args[3], args[4]
		local rv1, rv2, rv3 = op1[1](self, op1),op2[1](self, op2),op3[1](self,op3)
		return E2toE2( rv1, self.entity, rv2, rv3, k )
	end)
	
	__e2setcost(20)
	
	-- Send a ds to the E2s group in the E2s scope
	registerFunction("dsSend","s"..v[1],"n",function(self,args)
		local op1, op2 = args[2], args[3]
		local rv1, rv2 = op1[1](self, op1),op2[1](self, op2)
		return E2toGroup( rv1, self.entity, nil, nil, rv2, k )
	end)
	
	-- Send a ds to the E2s group in scope <rv2>
	registerFunction("dsSend","sn" .. v[1], "n", function(self,args)
		local op1, op2, op3 = args[2], args[3], args[4]
		local rv1, rv2, rv3 = op1[1](self, op1),op2[1](self, op2),op3[1](self,op3)
		return E2toGroup( rv1, self.entity, nil, rv2, rv3, k )
	end)
	
	-- Send a ds to the group <rv2> in the E2s scope
	registerFunction("dsSend","ss"..v[1],"n",function(self,args)
		local op1, op2, op3 = args[2], args[3], args[4]
		local rv1, rv2, rv3 = op1[1](self, op1),op2[1](self, op2),op3[1](self,op3)
		return E2toGroup( rv1, self.entity, rv2, nil, rv3, k )
	end)
	
	-- Send a ds to the group <rv2> in scope <rv3>
	registerFunction("dsSend","ssn"..v[1],"n",function(self,args)
		local op1, op2, op3, op4 = args[2], args[3], args[4], args[5]
		local rv1, rv2, rv3, rv4 = op1[1](self, op1),op2[1](self, op2),op3[1](self,op3),op4[1](self,op4)
		return E2toGroup( rv1, self.entity, rv2, rv3, rv4, k )
	end)
	
	__e2setcost(5)
	
	-- Get variable
	registerFunction("dsGet" .. upperfirst( k ), "", v[1], function(self,args)
		if (datatype != k) then return v[2] end -- If the type is not that type, return the type's default value
		return data
	end)
	
end

__e2setcost(5)

-- Set group
e2function void dsSetGroup( string groupname )
	ChangeGroup( self, groupname )
end

-- Get group
e2function string dsGetGroup()
	return self.datasignal.group
end

-- 0 = only you, 1 = only pp friends, 2 = everyone
e2function void dsSetScope( number scope )
	self.datasignal.scope = math.Clamp(math.Round(scope),0,2)
end

-- Get current scope
e2function number dsGetScope()
	return self.datasignal.scope
end

e2function void dsSetGroup( string groupname, number scope )
	-- group:
	ChangeGroup( self, groupname )
	-- scope:
	self.datasignal.scope = math.Clamp(math.Round(scope),0,2)
end

----------------
-- Get functions

__e2setcost(2)

-- Check if the current execution was caused by ANY datasignal
e2function number dsClk()
	return runbydatasignal
end

-- Check if the current execution was caused by a datasignal named <name>
e2function number dsClk( string name )
	if (signalname == name) then return 1 else return 0 end
end

-- Returns the name of the current signal
e2function string dsClkName()
	return signalname
end

-- Get the type of the current data
e2function string dsGetType()
	return datatype or ""
end

-- Get the which E2 sent the data
e2function entity dsGetSender()
	if (!sender or !sender:IsValid()) then return nil end
	return sender
end

-- Get all E2s which would have recieved a signal if you had sent it to the E2s group and scope
e2function array dsProbe()
	return GetE2s( self.entity, self.datasignal.group, self.datasignal.scope )
end

-- Get all E2s which would have recieved a signal if you had sent it to this group and the E2s scope
e2function array dsProbe( string groupname )
	return GetE2s( self.entity, groupname, self.datasignal.scope )
end

-- Get all E2s which would have recieved a signal if you had sent it to this group
e2function array dsProbe( string groupname, number scope )
	return GetE2s( self.entity, groupname, math.Clamp(math.Round(scope),0,2) )
end

__e2setcost(nil)

---------------------------------------------
-- When an E2 is removed, clear it from the groups table
registerCallback("destruct",function(self)
	if (groups[self.datasignal.group]) then
		groups[self.datasignal.group][self.entity:EntIndex()] = nil
		if (self.datasignal.group != "default") then
			if (table.Count(groups[self.datasignal.group]) == 0) then
				groups[self.datasignal.group] = nil
			end
		end
	end
end)

-- When an E2 is spawned, set its group and scope to the defaults
registerCallback("construct",function(self)
	self.datasignal = {}
	self.datasignal.group = "default"
	self.datasignal.scope = 0
	groups.default[self.entity:EntIndex()] = true
end)