function displayPermissionIssue ()
<<<<<<< HEAD
  TriggerClientEvent('chatMessage', source, 'SYSTEM', { 255, 0, 0 }, 'Permisos insuficientes!')
=======
  TriggerClientEvent('chatMessage', source, 'SERVIDOR', { 255, 0, 0 }, '¡Permisos insuficientes!')
>>>>>>> 5faeec19d89565ceb1a710736f43910fe50cc1bf
end

TriggerEvent('es:addGroupCommand', 'whitelist:load', 'superadmin', function (source, args, user)
  loadWhiteList()
end, function (source, args, user)
  displayPermissionIssue(source)
end, { help = _U('help_whitelist_load') })

TriggerEvent('es:addGroupCommand', 'whitelist:add', 'superadmin', function (source, args, user)
  local steamID = 'steam:' .. args[1]

  MySQL.Async.execute(
    'INSERT INTO whitelist (identifier) VALUES (@identifier)',
    { ['@identifier'] = tostring(steamID) },
    function ()
      loadWhiteList()
    end
  )
end, function (source, args, user)
  displayPermissionIssue(source)
<<<<<<< HEAD
end, { help = _U('help_whitelist_add'), params = { steam = 'SteamID', help = 'SteamID formateado a hex' }})
=======
end, { help = _U('help_whitelist_add'), params = { steam = 'SteamID', help = 'SteamID en formato HEX' }})
>>>>>>> 5faeec19d89565ceb1a710736f43910fe50cc1bf
