Citizen.CreateThread(function()
	while true do
		Wait(1)
		playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed) then -- Check to see if the player is in a car.
		
			if playerPed and not isHide then
				
				playerCar = GetVehiclePedIsIn(playerPed, false)
				
				if playerCar and GetPedInVehicleSeat(playerCar, -1) == playerPed then
					
					carRPM                    = GetVehicleCurrentRpm(playerCar)
					carSpeed                  = GetEntitySpeed(playerCar)
					carGear                   = GetVehicleCurrentGear(playerCar)
					carIL                     = GetVehicleIndicatorLights(playerCar)
					carHandbrake              = GetVehicleHandbrake(playerCar)
					carBrakePressure          = GetVehicleWheelBrakePressure(playerCar, 0)
					carLS_r, carLS_o, carLS_h = GetVehicleLightsState(playerCar)
					
					SendNUIMessage({
						ShowHud             = true,
						CurrentCarRPM       = carRPM,
						CurrentCarGear      = carGear,
						CurrentCarSpeed     = carSpeed,
						CurrentCarKmh       = math.ceil(carSpeed * 3.6),
						CurrentCarMph       = math.ceil(carSpeed * 2.236936),
						CurrentCarIL        = carIL,
						CurrentCarHandbrake = carHandbrake,
						CurrentCarBrake     = carBrakePressure,
						CurrentCarLS_r      = carLS_r,
						CurrentCarLS_o      = carLS_o,
						CurrentCarLS_h      = carLS_h,
						PlayerID            = GetPlayerServerId(GetPlayerIndex())
					})
					
				else
					SendNUIMessage({HideHud = true})
				end
			end
		end
	end
end)
