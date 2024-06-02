-- Function to check the speed of the vehicle
function GetEntitySpeedKmh(entity)
    local speed = GetEntitySpeed(entity)
    return speed * 3.6 -- Convert from m/s to km/h
end

-- Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- loop

        local playerPed = PlayerPedId() -- PlayerPed
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeedKmh(vehicle)

            if speed >= 200.0 then
                local players = GetActivePlayers()

                for _, player in ipairs(players) do
                    local targetPed = GetPlayerPed(player)
                    if targetPed ~= playerPed then
                        local distance = #(GetEntityCoords(playerPed) - GetEntityCoords(targetPed))
                        if distance < 10.0 then -- Adjust this value 
                            -- Enable collision between the vehicle and the target player
                            SetEntityNoCollisionEntity(vehicle, targetPed, false)
                        else
                            -- Disable collision
                            SetEntityNoCollisionEntity(vehicle, targetPed, true)
                        end
                    end
                end
            end
        end
    end
end)