TriggerEvent('es:addGroupCommand', 'tp', 'admin', function(source, args, user)
  TriggerClientEvent("esx:teleport", source, {
    x = tonumber(args[1]),
    y = tonumber(args[2]),
    z = tonumber(args[3])
  })
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {
  help = "Teletransportarte a una posición.",
  params = {
    {name = "X", help = "Posición X"},
    {name = "Y", help = "Posición Y"},
    {name = "Z", help = "Posición Z"}
  }
})

TriggerEvent('es:addGroupCommand', 'dartrabajo', 'mod', function(source, args, user)
  if #args ~= 3 then
    TriggerClientEvent('chatMessage', source, "AYUDA", {255, 0, 0}, "Utiliza: /dartrabajo [ID Jugador] [Trabajo] [Rango]")
  else
    local xPlayer = ESX.GetPlayerFromId(args[1])

    if xPlayer ~= nil then
      xPlayer.setJob(args[2], tonumber(args[3]))
    else
      TriggerClientEvent('chatMessage', source, "ERROR", {255, 0, 0}, "Jugador no encontrado!")
    end

  end
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {
  help = _U('setjob'),
  params = {
    {name = "id", help = _U('id_param')},
    {name = "trabajo", help = _U('setjob_param2')},
    {name = "rango", help = _U('setjob_param3')}
  }
})

TriggerEvent('es:addGroupCommand', 'repararveh', 'mod', function(source, args, user)
  TriggerClientEvent('wk:fixVehicle', source)
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {
  help = "Arreglar un vehículo"
})

TriggerEvent('es:addGroupCommand', 'refill', 'mod', function(source, args, user)

  local ped = GetPlayerPed( -1 )

  if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      if (IsPedSittingInAnyVehicle(ped)) then
          local vehicle = GetVehiclePedIsIn(ped, false)

          SetVehicleFuelLevel(vehicle, 99)
          SetVehicleEngineOn(vehicle, true, true)
      end
  end

end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {
  help = "Rellenar un vehículo de gasolina"
})

TriggerEvent('es:addGroupCommand', 'loadipl', 'admin', function(source, args, user)
  TriggerClientEvent('esx:loadIPL', -1, args[2])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('load_ipl')})

TriggerEvent('es:addGroupCommand', 'unloadipl', 'admin', function(source, args, user)
  TriggerClientEvent('esx:unloadIPL', -1, args[2])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('unload_ipl')})

TriggerEvent('es:addGroupCommand', 'playanim', 'admin', function(source, args, user)
  TriggerClientEvent('esx:playAnim', -1, args[2], args[3])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('play_anim')})

TriggerEvent('es:addGroupCommand', 'playemote', 'admin', function(source, args, user)
  TriggerClientEvent('esx:playEmote', -1, args[2])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('play_emote')})

TriggerEvent('es:addGroupCommand', 'sveh', 'admin', function(source, args, user)
  TriggerClientEvent('esx:spawnVehicle', source, args[1])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})

TriggerEvent('es:addGroupCommand', 'dv', 'admin', function(source, args, user)
  TriggerClientEvent('esx:deleteVehicle', source)
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('delete_vehicle'), params = {{name = "car", help = _U('delete_veh_param')}}})


TriggerEvent('es:addGroupCommand', 'spawnped', 'admin', function(source, args, user)
  TriggerClientEvent('esx:spawnPed', source, args[1])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('spawn_ped'), params = {{name = "name", help = _U('spawn_ped_param')}}})

TriggerEvent('es:addGroupCommand', 'spawnobject', 'admin', function(source, args, user)
  TriggerClientEvent('esx:spawnObject', source, args[1])
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('spawn_object'), params = {{name = "name"}}})

TriggerEvent('es:addGroupCommand', 'dardinero', 'admin', function(source, args, user)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(args[1])
  local amount  = tonumber(args[2])

  if amount ~= nil then
    xPlayer.addMoney(amount)
  else
    TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
  end

end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('givemoney'), params = {{name = "id", help = _U('id_param')}, {name = "amount", help = _U('money_amount')}}})

TriggerEvent('es:addGroupCommand', 'dardinerocuenta', 'admin', function(source, args, user)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(args[1])
  local account = args[2]
  local amount  = tonumber(args[3])

  if amount ~= nil then
    if xPlayer.getAccount(account) ~= nil then
      xPlayer.addAccountMoney(account, amount)
    else
      TriggerClientEvent('esx:showNotification', _source, _U('invalid_account'))
    end
  else
    TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
  end

end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('giveaccountmoney'), params = {{name = "id", help = _U('id_param')}, {name = "account", help = _U('account')}, {name = "amount", help = _U('money_amount')}}})

TriggerEvent('es:addGroupCommand', 'daritem', 'admin', function(source, args, user)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(args[1])
  local item    = args[2]
  local count   = (args[3] == nil and 1 or tonumber(args[3]))

  if count ~= nil then
    if xPlayer.getInventoryItem(item) ~= nil then
      xPlayer.addInventoryItem(item, count)
    else
      TriggerClientEvent('esx:showNotification', _source, _U('invalid_item'))
    end
  else
    TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
  end

end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('giveitem'), params = {{name = "id", help = _U('id_param')}, {name = "item", help = _U('item')}, {name = "amount", help = _U('amount')}}})

TriggerEvent('es:addGroupCommand', 'dararma', 'admin', function(source, args, user)
  if #args ~= 2 then
    TriggerClientEvent('chatMessage', source, "AYUDA", {255, 0, 0}, "Utiliza: /dartrabajo [ID Jugador] [Arma]")
  else
    local xPlayer    = ESX.GetPlayerFromId(args[1])
    local weaponName = string.upper(args[2])

    if xPlayer ~= nil then
      xPlayer.addWeapon(weaponName, 1000)
    else
      TriggerClientEvent('chatMessage', source, "ERROR", {255, 0, 0}, "Jugador no encontrado!")
    end
  end
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insfucientes.")
end, {help = _U('giveweapon'), params = {{name = "id", help = _U('id_param')}, {name = "weapon", help = _U('weapon')}}})
