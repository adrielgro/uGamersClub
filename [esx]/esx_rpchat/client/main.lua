--[[

  ESX RP Chat

--]]

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^0" .. name .. " dice", {0, 153, 204}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "^0" .. name .. " dice", {0, 153, 204}, message)
  end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^6* " .. name .." ".."^6 " .. message .. " *")
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^6* " .. name .." ".."^6 " .. message .. " *")
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageRoll')
AddEventHandler('sendProximityMessageRoll', function(id, name, num)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    if num > 5 then
    TriggerEvent("chatMessage", "* ", {255,0,0}, "" .. name .. "intenta una acción y ^2 lo logra!")
    end
    if num < 5 then
    TriggerEvent("chatMessage", "* ", {255,0,0}, "" .. name .. "intenta una acción y ^1 falla!")
    end
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    if num > 5 then
    TriggerEvent("chatMessage", "* ", {255,0,0}, "" .. name .. "intenta una acción y ^2 lo logra!")
    end
    if num < 5 then
    TriggerEvent("chatMessage", "* ", {255,0,0}, "" .. name .. "intenta una acción y ^1 falla!")
    end
  end
end)
