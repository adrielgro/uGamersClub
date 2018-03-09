--[[--------------------------------------------------------------------------
	*
	* Mello Trainer
	* (C) Michael Goodwin 2017
	* http://github.com/thestonedturtle/mellotrainer/releases
	*
	* This menu used the Scorpion Trainer as a framework to build off of.
	* https://github.com/pongo1231/ScorpionTrainer
	* (C) Emre Cürgül 2017
	* 
	* A lot of useful functionality has been converted from the lambda menu.
	* https://lambda.menu
	* (C) Oui 2017
	*
	* Additional Contributors:
	* WolfKnight (https://forum.fivem.net/u/WolfKnight)
	*
---------------------------------------------------------------------------]]
--Not Needed? 
--require("map.lua") -- Require map.lua so we can call the toggleMapBlips function.

-- Variables used for this part of the trainer.
local playerdb = {}

-- Creates an empty table of tables to hold the blip/ped information for users.
for i=0, maxPlayers, 1 do
	playerdb[i] = {}
end




--[[
  _   _   _    _   _____      _____           _   _   _                      _          
 | \ | | | |  | | |_   _|    / ____|         | | | | | |                    | |         
 |  \| | | |  | |   | |     | |        __ _  | | | | | |__     __ _    ___  | | __  ___ 
 | . ` | | |  | |   | |     | |       / _` | | | | | | '_ \   / _` |  / __| | |/ / / __|
 | |\  | | |__| |  _| |_    | |____  | (_| | | | | | | |_) | | (_| | | (__  |   <  \__ \
 |_| \_|  \____/  |_____|    \_____|  \__,_| |_| |_| |_.__/   \__,_|  \___| |_|\_\ |___/
--]]



RegisterNUICallback("settingtoggle", function(data, cb)
	local action = data.action
	local newstate = data.newstate
	local text,text2

	if(newstate) then
		text = "~g~ON"
		text2 = "~r~OFF"
	else
		text = "~r~OFF"
		text2 = "~g~ON"
	end


	--Hud Toggle
	if(action == "hud")then
		featureHideHud = newstate
		DisplayHud(not featureHideHud)
		drawNotification("Hud Display: "..tostring(text2))

	-- Radr Toggle
	elseif(action == "radar")then
		featureHideMap = newstate
		DisplayRadar(not featureHideMap)
		drawNotification("Radar Display: "..tostring(text2))

	-- Large Map Toggle
	elseif(action == "enlarge")then
		featureBigHud = newstate
		SetRadarBigmapEnabled(featureBigHud, false)
		drawNotification("Large Map: "..tostring(text))	



	-- Street Name Toggle
	elseif(action == "streets")then
		featureAreaStreetNames = newstate
		drawNotification("Street Names: "..tostring(text2))

	-- Map Location Blips
	elseif(action == "mapblips")then
		featureMapBlips = newstate
		toggleMapBlips(featureMapBlips) -- In maps.lua
		drawNotification("Map Blips: "..tostring(text))

	-- Radio Always Off
	elseif(action=="radiooff")then
		featureRadioAlwaysOff = newstate
		drawNotification("Radio Always Off: "..text)

	-- Mobile Radio 
	elseif(action=="mobileradio")then
		featurePlayerRadio = newstate
		SetMobileRadioEnabledDuringGameplay(featurePlayerRadio);
		SetUserRadioControlEnabled(not featureRadioAlwaysOff)
		drawNotification("Player Radio: "..text)

	elseif(action=="skipradio")then
		SkipRadioForward();
	end
	--elseif(action == )then
end)



--[[
  ______                        _     _                       
 |  ____|                      | |   (_)                      
 | |__   _   _   _ __     ___  | |_   _    ___    _ __    ___ 
 |  __| | | | | | '_ \   / __| | __| | |  / _ \  | '_ \  / __|
 | |    | |_| | | | | | | (__  | |_  | | | (_) | | | | | \__ \
 |_|    \__,_| |_| |_|  \___|  \__| |_|  \___/  |_| |_| |___/
--]]



-- Toggle Radio Control
function toggleRadio(playerPed)
	if(IsPedInAnyVehicle(playerPed, false))then
		local veh = GetVehiclePedIsUsing(playerPed)
		SetVehicleRadioEnabled(veh, not featureRadioAlwaysOff)
	end

	SetUserRadioControlEnabled(not featureRadioAlwaysOff)
end

--[[
  _______   _                                 _ 
 |__   __| | |                               | |
    | |    | |__    _ __    ___    __ _    __| |
    | |    | '_ \  | '__|  / _ \  / _` |  / _` |
    | |    | | | | | |    |  __/ | (_| | | (_| |
    |_|    |_| |_| |_|     \___|  \__,_|  \__,_|
--]]



Citizen.CreateThread(function()
	while true do
		Wait(0)

		-- Street Names
		if(featureAreaStreetNames) then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(9)
		end


		-- Toggle minimap on keypress
		if IsControlJustPressed(0, 20) and not IsPauseMenuActive() and not blockinput then
			featureBigHud = not featureBigHud
			SetRadarBigmapEnabled( featureBigHud, false)
		end

	end
end)



-- Update vehicle whenever you entere a new vehicle
RegisterNetEvent('mellotrainer:playerEnteredVehicle')
AddEventHandler('mellotrainer:playerEnteredVehicle', function(veh)
	local playerPed = GetPlayerPed(-1)
	toggleRadio(playerPed)
	UpdateVehicleFeatureVariables(veh)
end)



-- Turn off Radio.
Citizen.CreateThread(function()
	local radioToggle = false
	while true do
		Wait(100)
		local playerPed = GetPlayerPed(-1)

		-- Radio Always Off
		if(featureRadioAlwaysOff)then
			if(featurePlayerRadio)then
				SetMobileRadioEnabledDuringGameplay(false);
				featurePlayerRadio = false;
			end

			if(not radioToggle)then
				toggleRadio(playerPed)
			end
			radioToggle = true
		else
			if(radioToggle)then
				toggleRadio(playerPed)
				radioToggle = false
			end
		end
	end
end)


-- Local Blip/Head Storage for removing on disconnect
local playersDB = {}
for i=0, maxPlayers, 1 do
	playersDB[i] = {}
end

--[[----------------------------------------------------------------------
	*
	* Head Display Stuff
	*
------------------------------------------------------------------------]]


-- Remove Head Display from entity
function clearPlayerHead(id)
	if(playersDB[id].headId ~= nil and IsMpGamerTagActive(playersDB[id].headId))then
		RemoveMpGamerTag(playersDB[id].headId)
	end
end

-- Create Head Display for entity
function createPlayerHead(id,ped)
	if(featurePlayerHeadDisplay)then
		headId = CreateMpGamerTag(ped, GetPlayerName(id), false, false, "", false )
		wantedLvl = GetPlayerWantedLevel(id)

		-- Wanted Levels
		if wantedLvl > 0 then
			SetMpGamerTagWantedLevel(headId, wantedLvl)
			SetMpGamerTagVisibility(headId, 7, true)
		else
			SetMpGamerTagWantedLevel(headId, 0)
			SetMpGamerTagVisibility(headId, 7, false)
		end

		-- Speaking Icon
		if NetworkIsPlayerTalking(id)then
			SetMpGamerTagVisibility(headId, 9, true)
		else
			SetMpGamerTagVisibility(headId, 9, false)
		end
		playersDB[id].headId = headId
		playersDB[id].wantedLvl = wantedLvl
	else
		if(playersDB[id].headId ~= nil and IsMpGamerTagActive(playersDB[id].headId))then
			RemoveMpGamerTag(playersDB[id].headId)
		end

		playersDB[id].headId = nil
		playersDB[id].wantedLvl = nil
	end
end



--[[----------------------------------------------------------------------
	*
	* Blip Display Stuff
	*
------------------------------------------------------------------------]]



-- Faster Method to remove Blips/Names from players who disconnect.
RegisterNetEvent( 'mellotrainer:playerLeft' )
AddEventHandler( 'mellotrainer:playerLeft', function( person )
	Citizen.Trace(person.source)
	clearPlayerBlip(person.source)
	clearPlayerHead(person.source)
	playersDB[person.source] = "skip"

	-- 30 second skip period to ensure the name/blip don't reappear for a disconnected player.
	Wait(30000) 
	-- After 30 seconds if the source is still active it will recreate blips assuming its a new person.
	playersDB[person.source] = {} 
end )



		end
	end
end)