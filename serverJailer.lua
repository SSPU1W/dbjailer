ESX 				= nil
local defaultsecs   = 300
local maxsecs 		= 1000

-----------------------------

--ESX base
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local xPlayers 		= ESX.GetPlayers()

AddEventHandler('chatMessage', function(source, n, message)
	cm = stringsplit(message, " ")
	local xPlayer 		= ESX.GetPlayerFromId(source)
		
		if cm[1] == "/unjail" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				if GetPlayerName(tPID) ~= nil then
					print("released ".. GetPlayerName(tPID).. " by ".. GetPlayerName(source))
					TriggerClientEvent("UnJP", tPID)
				end
				TriggerEvent('JailRelease', tPID)
			else
				TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 0 }, "You do not have the right to put people in jail!")
			end
		elseif cm[1] == "/jail1" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				local jT = defaultsecs
					if cm[3] ~= nil then
						jT = tonumber(cm[3])				
					end
				if jT > maxsecs then
					jT = maxsecs
				end
				if GetPlayerName(tPID) ~= nil then
					print("Put in Prison: ".. GetPlayerName(tPID).. " for ".. jT .." secs- entry done by ".. GetPlayerName(source))
					local identifier = GetPlayerIdentifiers(tPID)[1]
					local name = GetPlayerName(source)
					local id = GetPlayerIdentifiers(source)[1]
					MySQL.Async.execute("INSERT INTO jail (identifier,J_Time,J_Cell,Jailer,Jailer_ID) VALUES (@Identifier,@J_Time,@J_Cell,@JAILER,@JID)", {['@identifier'] = identifier, ['@J_Time'] = jT, ['@J_Cell'] = "JP1", ['@JAILER'] = name, ['@JID'] = id})
					TriggerClientEvent("JP1", tPID, jT)
					TriggerClientEvent('chatMessage', -1, 'JUDGE', { 0, 0, 0 }, GetPlayerName(tPID) ..' is in prison for '.. jT ..' secs')
				end
			else
				TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 0 }, "You do not have the right to put people in jail!")
			end
		elseif cm[1] == "/jail2" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				local jT = defaultsecs
					if cm[3] ~= nil then
						jT = tonumber(cm[3])				
					end
				if jT > maxsecs then
					jT = maxsecs
				end
				if GetPlayerName(tPID) ~= nil then
					print("Put in Prison: ".. GetPlayerName(tPID).. " for ".. jT .." secs - entry done by ".. GetPlayerName(source))
					local identifier = GetPlayerIdentifiers(tPID)[1]
					local name = GetPlayerName(source)
					local id = GetPlayerIdentifiers(source)[1]
					MySQL.Async.execute("INSERT INTO jail (identifier,J_Time,J_Cell,Jailer,Jailer_ID) VALUES (@Identifier,@J_Time,@J_Cell,@JAILER,@JID)", {['@identifier'] = identifier, ['@J_Time'] = jT, ['@J_Cell'] = "JP2", ['@JAILER'] = name, ['@JID'] = id})
					TriggerClientEvent("JP2", tPID, jT)
					TriggerClientEvent('chatMessage', -1, 'JUDGE', { 0, 0, 0 }, GetPlayerName(tPID) ..' is in prison for '.. jT ..' secs')
				end
			else
				TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 0 }, "You do not have the right to put people in jail!")
			end
		elseif cm[1] == "/jail3" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				local jT = defaultsecs
					if cm[3] ~= nil then
						jT = tonumber(cm[3])				
					end
				if jT > maxsecs then
					jT = maxsecs
				end
				if GetPlayerName(tPID) ~= nil then
					print("Put in Prison: ".. GetPlayerName(tPID).. " for ".. jT .." secs - entry done by ".. GetPlayerName(source))
					local identifier = GetPlayerIdentifiers(tPID)[1]
					local name = GetPlayerName(source)
					local id = GetPlayerIdentifiers(source)[1]
					MySQL.Async.execute("INSERT INTO jail (identifier,J_Time,J_Cell,Jailer,Jailer_ID) VALUES (@Identifier,@J_Time,@J_Cell,@JAILER,@JID)", {['@identifier'] = identifier, ['@J_Time'] = jT, ['@J_Cell'] = "JP3", ['@JAILER'] = name, ['@JID'] = id})
					TriggerClientEvent("JP3", tPID, jT)
					TriggerClientEvent('chatMessage', -1, 'JUDGE', { 0, 0, 0 }, GetPlayerName(tPID) ..' is in prison for '.. jT ..' secs')
				end
			else
				TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 0 }, "You do not have the right to put people in jail!")
			end
		end
end)

RegisterServerEvent("JailCheck")
AddEventHandler("JailCheck", function()
	local player = source
print("SOURCE = "..source)
--print("PLAYER = "..player)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
			if gotInfo[1].identifier == GetPlayerIdentifiers(player)[1] then
				TriggerClientEvent(gotInfo[1].J_Cell, player, gotInfo[1].J_Time)
			end
		else
		end
	end)
end)

RegisterServerEvent("JailUpdate")
AddEventHandler("JailUpdate", function(newTime)
	local player = source
print("SOURCE="..source)
        player = source
print("TIME REMAINING="..newTime)
	local identifier = GetPlayerIdentifiers(player)[1]
	MySQL.Async.execute("UPDATE jail SET J_Time=@TIME WHERE identifier=@identifier", {["@TIME"] = newTime, ['@identifier'] = identifier})
        if newTime == 0 then
            local player = source
	    local identifier = GetPlayerIdentifiers(player)[1]
	    local newID = "RELEASED=" .. identifier
	    MySQL.Async.execute("UPDATE jail SET J_Time=@Time WHERE identifier=@identifier", {["@Time"] = 0, ['@identifier'] = identifier})
	    MySQL.Async.execute("UPDATE jail SET identifier=@ID WHERE identifier=@identifier", {["@ID"] = newID, ['@identifier'] = identifier})
        end
end)

RegisterServerEvent("JailRelease")
AddEventHandler("JailRelease", function(source)
print("PLAYER "..source.."IS NOW RELEASED")
	local player = source
	local identifier = GetPlayerIdentifiers(player)[1]
	local newID = "RELEASED=" .. identifier
	MySQL.Async.execute("UPDATE jail SET J_Time=@Time WHERE identifier=@identifier", {["@Time"] = 0, ['@identifier'] = identifier})
	MySQL.Async.execute("UPDATE jail SET identifier=@ID WHERE identifier=@identifier", {["@ID"] = newID, ['@identifier'] = identifier})
end)
RegisterServerEvent("JailReleaseTime")
AddEventHandler("JailRelease", function()
print("PLAYER "..source.."IS NOW RELEASED")
	local player = source
	local identifier = GetPlayerIdentifiers(player)[1]
	local newID = "RELEASED=" .. identifier
	MySQL.Async.execute("UPDATE jail SET J_Time=@Time WHERE identifier=@identifier", {["@Time"] = 0, ['@identifier'] = identifier})
	MySQL.Async.execute("UPDATE jail SET identifier=@ID WHERE identifier=@identifier", {["@ID"] = newID, ['@identifier'] = identifier})
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end