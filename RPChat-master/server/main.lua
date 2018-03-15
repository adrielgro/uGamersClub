  AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
      getIdentity(source, function(data)
        local name = GetPlayerName(source)
        TriggerClientEvent("sendProximityMessage", -1, source, name, message)
      end)
    end
    CancelEvent()
  end)

  RegisterCommand('me', function(source, args, user)
      local name = GetPlayerName(source)
      TriggerClientEvent("sendProximityMessageMe", -1, source, "* " .. name, table.concat(args, " "))
  end, false)

  RegisterCommand('do', function(source, args, user)
      local name = GetPlayerName(source)
      TriggerClientEvent("sendProximityMessageDo", -1, source, name, table.concat(args, " "))
  end, false)

  RegisterCommand('roll', function(source, args, user)
    local name = GetPlayerName(source)
    num = math.random(0, 10)
    TriggerClientEvent("sendProximityMessageRoll", -1, source, name, num, table.concat(args, " "))
  end, false)

  RegisterCommand('twt', function(source, args, user)
  	TriggerClientEvent('chatMessage', -1, "^0[^4Twitter^0] (^5@" .. GetPlayerName(source) .. "^0)", {30, 144, 255}, table.concat(args, " "))
  end, false)

  RegisterCommand('ooc', function(source, args, user)
  	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source), {128, 128, 128}, table.concat(args, " "))
  end, false)

  RegisterCommand('ad', function(source, args, user)
  	TriggerClientEvent('chatMessage', -1, "^1[ANUNCIO]: " .. GetPlayerName(source), {255,215,0}, table.concat(args, " "))
  end, false)

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
