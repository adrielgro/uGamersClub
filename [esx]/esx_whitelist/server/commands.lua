function displayPermissionIssue ()
  TriggerClientEvent('chatMessage', source, 'SERVIDOR', { 255, 0, 0 }, '¡Permisos insuficientes!')
end

TriggerEvent('es:addGroupCommand', 'whitelist:load', 'admin', function (source, args, user)
  loadWhiteList()
end, function (source, args, user)
  displayPermissionIssue(source)
end, { help = _U('help_whitelist_load') })

TriggerEvent('es:addGroupCommand', 'whitelist:add', 'admin', function (source, args, user)
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
end, { help = _U('help_whitelist_add'), params = { steam = 'SteamID', help = 'SteamID en formato HEX' }})
