-- ###################################
--
--        C   O   N   F   I   G
--
-- ###################################



-- show/hide compoent
local HUD = {
	
	Speed 			= 'mph', -- kmh or mph

	SpeedIndicator 	= true, -- Displays your speed

	Plate 			= true, -- Displays your licenseplate

	DisplayGear		= true, -- Displays your current gear
}

-- move all ui
local UI = { 

	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y =  -0.001 ,	-- Base Screen Coords 	+ 	-y

}





-- ###################################
--
--             C   O   D   E
--
-- ###################################



Citizen.CreateThread(function()
	while true do Citizen.Wait(1)


		local MyPed = GetPlayerPed(-1)

		if(IsPedInAnyVehicle(MyPed, false))then

			local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)
			local Fuel = GetVehicleFuelLevel(MyPedVeh)
			local DisplayGear = GetVehicleCurrentGear(MyPedVeh)

			if HUD.Speed == 'kmh' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
			elseif HUD.Speed == 'mph' then
				Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936
			end

			if HUD.Plate then
					drawTxt(UI.x + 0.517, 	UI.y + 1.4365, 1.0,1.0,0.4, "~w~" .. PlateVeh, 255, 255, 255, 255)
			end

			if Fuel then
					Fuel = GetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 1.525
                    drawTxt(UI.x + 0.629,     UI.y + 1.415, 1.0,1.0,0.4 , "~w~" .. math.ceil(Fuel), 255, 255, 255, 255)
                    drawTxt(UI.x + 0.639,     UI.y + 1.415, 1.0,1.0,0.4, "~w~ %", 255, 255, 255, 255)
            end

			if HUD.DisplayGear then
					drawTxt(UI.x + 0.515, 	UI.y + 1.41365, 1.0,1.0,0.4, "~w~ Gear", 255, 255, 255, 255)
					drawTxt(UI.x + 0.540, 	UI.y + 1.41365, 1.0,1.0,0.4 , "~w~" .. math.ceil(DisplayGear), 255, 255, 255, 255)
				end

			if HUD.SpeedIndicator then
				if HUD.Speed == 'kmh' then
					drawTxt(UI.x + 0.622, 	UI.y + 1.4365, 1.0,1.0,0.4 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
					drawTxt(UI.x + 0.633, 	UI.y + 1.4365, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)
				elseif HUD.Speed == 'mph' then
					drawTxt(UI.x + 0.623, 	UI.y + 1.4365, 1.0,1.0,0.4 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
					drawTxt(UI.x + 0.634, 	UI.y + 1.4365, 1.0,1.0,0.4, "~w~ mph", 255, 255, 255, 255)
				end
			end

			

		end		
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
