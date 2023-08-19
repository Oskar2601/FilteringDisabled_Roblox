--[[
	   __  __ _             
	  / _|/ _| |            
	 | |_| |_| | __ _  __ _ 
	 |  _|  _| |/ _` |/ _` |
	 | | | | | | (_| | (_| |
	 |_| |_| |_|\__,_|\__, |
	                   __/ |
	                  |___/             

	Filtering Disabler! fflag on Discord!
	
	** PLEASE NOTE **
	You must execute this for this to work: 
	
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Oskar2601/FilteringDisabled_Roblox/main/executor.lua"))
]]--

if(not game.Loaded) then game.Loaded:Wait() end

local servStorage = game:GetService("ServerStorage")
local repStorage = game:GetService("ReplicatedStorage")

local function create(parent, name, instanceType)
	local v = parent:FindFirstChild(name)
	if(v and v:IsA(instanceType)) then return v end
	v = Instance.new(instanceType, parent) v.Name = name return v
end

local protectedFolder = create(repStorage, "_PROTECTED", "Folder")
local events = create(protectedFolder, "Events", "Folder")
local controllers = create(protectedFolder, "Controllers", "Folder")
local gcFolder = create(repStorage, "GC", "Folder")
local checks = require(14499825459)

create(events, "InvokeMethod", "RemoteFunction").OnServerInvoke = function(plr, instance, method, ...)
	if(not table.find(checks.whitelistedMethods, method)) then print(instance, method) return ("[SERVER]: The '%s' method is not allowed. This is a temporary measure."):format(method) end
	if(not checks.AllowMethod(instance, method)) then
		return ("[SERVER]: You cannot modify this %s"):format(instance.ClassName)
	end
	
	local succ, err = pcall(function(...)
		local resp = instance[method](instance, ...)
		if(method == "Clone" and resp) then
			resp.Parent = repStorage.GC
		end
		return resp
	end, ...)
	return err
end

create(events, "CreateInstance", "RemoteFunction").OnServerInvoke = function(plr, instanceType, parent, ...)
	if(not checks.AllowNewInstance(instanceType, parent)) then
		return ("[SERVER]: You cannot create Instances here!")
	end
	
	local succ, err = pcall(Instance.new, instanceType, parent, ...)
	if(typeof(err) == "Instance" and not err.Parent) then err.Parent = gcFolder end
	return err
end

create(events, "ChangeProperty", "RemoteFunction").OnServerInvoke = function(plr, instance, property, value)
	if(not checks.AllowPropertyChange(instance, property, value)) then
		return ("[SERVER]: You cannot edit the property '%s' of this instance."):format(property)
	end
	
	local succ, err = pcall(function()
		instance[property] = value
	end)
	
	return err
end

create(events, "IsValidInstance", "RemoteFunction").OnServerInvoke = function(plr, instance)
	return instance and true or false
end
