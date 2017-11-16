ESX 				= nil
local defaultsecs   = 300
local maxsecs 		= 1000

-----------------------------

--ESX base
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local xPlayers 		= ESX.GetPlayers()

AddEventHandler('chatMessage', function(source, n, message)
	cm = stringsplit(message, " ")
	local xPlayer = ESX.GetPlayerFromId(source)
		if cm[1] == "/unjail" then
			if xPlayer.job.name == 'police' then
				CancelEvent()
				local tPID = tonumber(cm[2])
				if GetPlayerName(tPID) ~= nil then
					print("released ".. GetPlayerName(tPID).. " by ".. GetPlayerName(source))
					TriggerClientEvent("UnJP", tPID)
				end
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
					TriggerClientEvent("JP3", tPID, jT)
					TriggerClientEvent('chatMessage', -1, 'JUDGE', { 0, 0, 0 }, GetPlayerName(tPID) ..' is in prison for '.. jT ..' secs')
				end
			else
				TriggerClientEvent('chatMessage', -1, 'SYSTEM', { 0, 0, 0 }, "You do not have the right to put people in jail!")
			end
		end
end)

RegisterServerEvent('jail:new')
local _source = source
AddEventHandler('jail:new', function(jailtime)

    TriggerClientEvent('chatMessage', source, "[PLAYER JAILED]")
     MySQL.Async.execute(
    'INSERT INTO user (jailtime) VALUES (@jailtime,)',
    {
      ['@jailtime'] = jailtime
    })

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