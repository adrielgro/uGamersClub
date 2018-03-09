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








--[[------------------------------------------------------------------------
	Vehicle Saving and Loading 
------------------------------------------------------------------------]]--
local vehicles = {}
local vehicleCount = 0

RegisterNetEvent( 'wk:RecieveSavedVehicles' )
AddEventHandler( 'wk:RecieveSavedVehicles', function( dataTable )
    vehicles = dataTable
    vehicleCount = getTableLength( dataTable )
end )

function CreateVehicleOptions( index )
	local spawnCar = {
		[ "menuName" ] = "Spawn Car", 
		[ "data" ] = {
			[ "action" ] = "spawnsavedveh " .. index
		}
	}

	local overwriteSave = {
		[ "menuName" ] = "Overwrite With Current", 
		[ "data" ] = {
			[ "action" ] = "vehiclesave " .. index
		}
	}

	local renameCar = {
		[ "menuName" ] = "Rename Save", 
		[ "data" ] = {
			[ "action" ] = "vehiclesave " .. index .. " r"
		}
	}

	local deleteCar = {
		[ "menuName" ] = "Delete", 
		[ "data" ] = {
			[ "action" ] = "deletesavedveh " .. index
		}
	}

	local options = { spawnCar, overwriteSave, renameCar, deleteCar }

	return options 
end 

RegisterNUICallback( "loadsavedvehs", function( data, cb ) 
    local validOptions = {}
 
    for k, v in pairs( vehicles ) do
    	local vehicleOptions = CreateVehicleOptions( k )

        table.insert( validOptions, 1, {
            [ "menuName" ] = v[ "saveName" ],
            [ "data" ] = {
                [ "sub" ] = k -- [ "action" ] = "spawnsavedveh " .. k
            },
            [ "submenu" ] = vehicleOptions
        } )
    end

    table.insert( validOptions, {
    	[ "menuName" ] = "Create New Vehicle Save", 
    	[ "data" ] = {
    		[ "action" ] = "vehiclesave"
    	}
    } )
 
 	end 
end )








