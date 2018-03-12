TriggerEvent("es:addGroup", "mod", "user", function(group) end)

-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "admin",
	noclip = "admin",
	crash = "superadmin",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "admin",
	slay = "admin",
	kick = "mod",
	ban = "admin"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile("es_admin2", "data/bans.txt") or ""
	if banned then
		local b = stringsplit(banned, "\n")
		for k,v in ipairs(b) do
			bannedTable[v] = true
		end
	end

	if GetConvar("es_admin2_globalbans", "0") == "1" then
		PerformHttpRequest("http://essentialmode.com/bans.txt", function(err, rText, headers)
			local b = stringsplit(rText, "\n")
			for k,v in pairs(b)do
				bannedTable[v] = true
			end
		end)
	end
end

function isBanned(id)
	return bannedTable[id]
end

function banUser(id)
	banned = banned .. id .. "\n"
	SaveResourceFile("es_admin2", "data/bans.txt", banned, -1)
	bannedTable[id] = true
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if isBanned(v) then
			set(GetConvar("es_admin_banreason", "You're banned from this server"))
			CancelEvent()
			break
		end
	end
end)

RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chatMessage', Source, "SYSTEM", {255, 0, 0}, "No tienes permiso para usar esto.")
			end
		end)
	end)
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				print('Available?: ' .. tostring(available))
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Has sido expulsado!') end

						if type == "ban" then
							for k,v in ipairs(GetPlayerIdentifiers(id))do
								banUser(v)
							end
							DropPlayer(id, GetConvar("es_admin_banreason", "¡Tu fuiste expulsado permanentemente de este servidor! Para apelar visite uGamers.club"))
						end
					else
						if not available then
							TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "Tu grupo no puede usar este comando.")
						else
							TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "Permiso denegado.")
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "mod", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Jugador no encontrado")
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "El grupo ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 ha sido establecido a ^2^*" .. GROUP)
							end)
						else
							TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Grupo no encontrado")
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Jugador no encontrado")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP))
							end
						end)
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Jugador no encontrado")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Jugador no encontrado")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			end
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Necesitas ser superadmin para poder hacer esto")
			end
		end)
	end)
end)

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'setadmin' then
		if #args ~= 2 then
				RconPrint("USA: setadmin [user-id] [permission-level]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Jugador no encontrado\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
			RconPrint(response)

			if(true)then
				print(args[1] .. " " .. args[2])
				TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
				TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2])
			end
		end)

		CancelEvent()
	elseif commandName == 'setgroup' then
		if #args ~= 2 then
				RconPrint("USA: setgroup [user-id] [group]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Jugador no encontrado\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:getAllGroups", function(groups)

			if(groups[args[2]])then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "group", args[2], function(response, success)

					if(true)then
						TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'group', tonumber(args[2]), true)
						TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Group of ^2^*" .. GetPlayerName(tonumber(args[1])) .. "^r^0 has been set to ^2^*" .. args[2])
					end
				end)
			else
				RconPrint("Este grupo no existe.\n")
			end
		end)

		CancelEvent()
	elseif commandName == 'giverole' then
		if #args < 2 then
				RconPrint("USA: giverole [user-id] [role]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Jugador no encontrado\n")
			CancelEvent()
			return
		end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.giveRole(table.concat(args, " "))
				TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "Te han dado un rol: ^2" .. table.concat(args, " "))
			end)

		CancelEvent()
	elseif commandName == 'removerole' then
		if #args < 2 then
				RconPrint("USA: removerole [user-id] [role]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Jugador no encontrado\n")
			CancelEvent()
			return
		end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.removeRole(table.concat(args, " "))
				TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "Se eliminó un rol: ^2" .. table.concat(args, " "))
			end)

		CancelEvent()
	elseif commandName == 'setmoney' then
			if #args ~= 2 then
					RconPrint("USA: setmoney [user-id] [dinero]\n")
					CancelEvent()
					return
			end

			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Jugador no encontrado\n")
				CancelEvent()
				return
			end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				if(user)then
					user.setMoney(tonumber(args[2]))

					RconPrint("Money set")
					TriggerClientEvent('chatMessage', tonumber(args[1]), "CONSOLE", {0, 0, 0}, "Tu dinero se ha modificado: ^2^*$" .. tonumber(args[2]))
				end
			end)

			CancelEvent()
		end
end)

-- Default commands
TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Nivel: ^*^2 " .. tostring(user.get('permission_level')))
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Grupo: ^*^2 " .. user.getGroup())
end, {help = "Muestra qué nivel de administrador eres y en qué grupo te encuentras"})

-- Default commands
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	--table.remove(args, 1) --Remover el argumento 1
	TriggerClientEvent('chatMessage', source, "REPORTE", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chatMessage', k, "REPORTE", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))
				end
			end)
		end
	end)
end, {help = "Report a player or an issue", params = {{name = "report", help = "Lo que deseas reportar"}}})

-- Append a message
function appendNewPos(msg)
	local file = io.open('resources/[essential]/es_admin2/positions.txt', "a")
	newFile = msg
	file:write(newFile)
	file:flush()
	file:close()
end

-- Do them hashes
function doHashes()
  lines = {}
  for line in io.lines("resources/[essential]/es_admin2/input.txt") do
  	lines[#lines + 1] = line
  end

  return lines
end


RegisterServerEvent('es_admin:givePos')
AddEventHandler('es_admin:givePos', function(str)
	appendNewPos(str)
end)

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicked: Has sido kickeado del servidor."
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "El jugador ^2" .. GetPlayerName(player) .. "^0 ha sido expulsado(^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "El ID del jugador"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. table.concat(args, " "))
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos insuficientes!")
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "El mensaje para anunciar"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "descongelado"
				if(frozen[player])then
					state = "congelado"
				end

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "Has sido " .. state .. " por ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "El jugador ^2" .. GetPlayerName(player) .. "^0 ha sido " .. state)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "El ID del jugador"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have brought by ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been brought")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Teleport a user to you", params = {{name = "userid", help = "El ID del jugador"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "Has sido golpeado por ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "El jugador ^2" .. GetPlayerName(player) .. "^0 ha sido golpeado")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Slap a user", params = {{name = "userid", help = "El ID del jugador"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'ira', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					--TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been teleported to by ^2" .. GetPlayerName(source))
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Te has teletransportado a ^2" .. GetPlayerName(player) .. "")
				end
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Teleport to a user", params = {{name = "userid", help = "El ID del jugador"}}})

-- Kill yourself
TriggerEvent('es:addCommand', 'die', function(source, args, user)
	TriggerClientEvent('es_admin:kill', source)
	TriggerClientEvent('chatMessage', source, "", {0,0,0}, "^1^*Te mataste.")
end, {help = "Suicide"})

-- Killing
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "Has sido asesinado por ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "El jugador ^2" .. GetPlayerName(player) .. "^0 ha sido asesinado.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Slay a user", params = {{name = "userid", help = "El ID del jugador"}}})

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "El jugador ^2" .. GetPlayerName(player) .. "^0 ha sido crasheado.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "ID del Jugador Incorrecto!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Crashear un usuario", params = {{name = "userid", help = "El ID del jugador"}}})

-- Position
TriggerEvent('es:addGroupCommand', 'pos', "superadmin", function(source, args, user)
	TriggerClientEvent('es_admin:givePosition', source)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Permisos Insuficientes!")
end, {help = "Obtener la posición actual"})

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

loadBans()
