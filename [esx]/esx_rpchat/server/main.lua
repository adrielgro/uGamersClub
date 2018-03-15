--[[

  ESX RP Chat

--]]

function getIdentity(source, callback)
  local identifier = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = identifier},
  function(result)
    if result[1]['firstname'] ~= nil then
      local data = {
        identifier    = result[1]['identifier'],
        firstname     = result[1]['firstname'],
        lastname      = result[1]['lastname'],
        dateofbirth   = result[1]['dateofbirth'],
        sex           = result[1]['sex'],
        height        = result[1]['height']
      }
      callback(data)
    else
      local data = {
        identifier    = '',
        firstname     = '',
        lastname      = '',
        dateofbirth   = '',
        sex           = '',
        height        = ''
      }
      callback(data)
    end
  end)
end

AddEventHandler('chatMessage', function(source, name, message)
  getIdentity(source, function(data)
    if string.sub(message, 1, string.len("/")) ~= "/" then
      TriggerClientEvent("sendProximityMessage", -1, source, data.firstname, message)
    end
  end)
  CancelEvent()
end)

TriggerEvent('es:addCommand', 'me', function(source, args, user)
    --table.remove(args, 1)
    getIdentity(source, function(data)
      TriggerClientEvent("sendProximityMessageMe", -1, source, data.firstname, table.concat(args, " "))
    end)
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
    --table.remove(args, 1)
    getIdentity(source, function(data)
      TriggerClientEvent("sendProximityMessageDo", -1, source, data.firstname, table.concat(args, " "))
    end)
end)

TriggerEvent('es:addCommand', 'twt', function(source, args, user)
  --table.remove(args, 1)
  TriggerClientEvent('chatMessage', -1, "^0[^4Twitter^0] (^5@" .. GetPlayerName(source) .. "^0)", {30, 144, 255}, table.concat(args, " "))
end, {help = 'Enviar tweet. [IC]'})

TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
  --table.remove(args, 1)
  TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source), {128, 128, 128}, table.concat(args, " "))
end, {help = 'Envíe un mensaje de fuera del jugador a todo el servidor.'})

TriggerEvent('es:addCommand', 'ad', function(source, args, user)
  TriggerClientEvent('chatMessage', -1, "^1[ANUNCIO]: " .. data.firstname, {255,215,0}, table.concat(args, " "))
end, {help = 'Mandar un anuncio IC.'})

TriggerEvent('es:addCommand', 'intentar', function(source, args, user)
  num = math.random(0, 10)
  TriggerClientEvent("sendProximityMessageRoll", -1, source, data.firstname, num, table.concat(args, " "))
end, {help = 'Intentar realizar una acción que depende de la suerte.'})

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
