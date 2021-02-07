--[[ Forza Horizon 4 Speedometer for FiveM ]]--
--[[ Author: Akkariin | Github: https://github.com/kasuganosoras/fh4speed ]]--
--[[ If you like this script, please give me a like on the fivem forum, thanks ]]--

local isHide = false

local carRPM, carSpeed, carGear, carIL, carAcceleration, carHandbrake, carBrakeABS, carLS_r, carLS_o, carLS_h

RegisterCommand("fh4speed", function(_, args)	
	ToggleDisplay()
end, false)

RegisterKeyMapping('fh4speed', 'Enable or disable speedometer', 'keyboard', 'f10')

Citizen.CreateThread(function()
	while true do
		Wait(50)

		playerPed = GetPlayerPed(-1)
		
		if playerPed and IsPedInAnyVehicle(playerPed) and not isHide then
			
			playerCar = GetVehiclePedIsIn(playerPed, false)
			
			if playerCar and GetPedInVehicleSeat(playerCar, -1) == playerPed then
				local NcarRPM                      = GetVehicleCurrentRpm(playerCar)
				local NcarSpeed                    = GetEntitySpeed(playerCar)
				local NcarGear                     = GetVehicleCurrentGear(playerCar)
				local NcarIL                       = GetVehicleIndicatorLights(playerCar)
				local NcarAcceleration             = IsControlPressed(0, 71)
				local NcarHandbrake                = GetVehicleHandbrake(playerCar)
				local NcarBrakeABS                 = (GetVehicleWheelSpeed(playerCar, 0) <= 0.0) and (NcarSpeed > 0.0)
				local NcarLS_r, NcarLS_o, NcarLS_h = GetVehicleLightsState(playerCar)
				
				local shouldUpdate = false
				
				if NcarRPM ~= carRPM or NcarSpeed ~= carSpeed or NcarGear ~= carGear or NcarIL ~= carIL or NcarAcceleration ~= carAcceleration 
					or NcarHandbrake ~= carHandbrake or NcarBrakeABS ~= carBrakeABS or NcarLS_r ~= carLS_r or NcarLS_o ~= carLS_o or NcarLS_h ~= carLS_h then
					shouldUpdate = true
				end
				
				if shouldUpdate then
					carRPM          = NcarRPM
					carGear         = NcarGear
					carSpeed        = NcarSpeed
					carIL           = NcarIL
					carAcceleration = NcarAcceleration
					carHandbrake    = NcarHandbrake
					carBrakeABS     = NcarBrakeABS
					carLS_r         = NcarLS_r
					carLS_o         = NcarLS_o
					carLS_h         = NcarLS_h
					SendNUIMessage({
						ShowHud                = true,
						CurrentCarRPM          = carRPM,
						CurrentCarGear         = carGear,
						CurrentCarSpeed        = carSpeed,
						CurrentCarKmh          = math.ceil(carSpeed * 3.6),
						CurrentCarMph          = math.ceil(carSpeed * 2.236936),
						CurrentCarIL           = carIL,
						CurrentCarAcceleration = carAcceleration,
						CurrentCarHandbrake    = carHandbrake,
						CurrentCarABS          = GetVehicleWheelBrakePressure(playerCar, 0) > 0 and not carBrakeABS,
						CurrentCarLS_r         = carLS_r,
						CurrentCarLS_o         = carLS_o,
						CurrentCarLS_h         = carLS_h,
						PlayerID               = GetPlayerServerId(GetPlayerIndex())
					})
				else
					Wait(100)
				end
			else
				SendNUIMessage({HideHud = true})
			end
		else
			SendNUIMessage({HideHud = true})
			Wait(100)
		end
	end
end)

function ToggleDisplay()
	if isHide then
		isHide = false
	else
		SendNUIMessage({HideHud = true})
		isHide = true
	end
end
