-- check the speed of the vehicle
function GetEntitySpeedKmh(entity)
    local speed = GetEntitySpeed(entity)
    return speed * 3.6 -- Convert from m/s to km/h
end

-- Main thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- loop

        local playerPed = PlayerPedId() -- playerped
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeedKmh(vehicle)

            if speed >= 200.0 then
                TriggerServerEvent('collision:checkProximity', vehicle)
            end
        end
    end
end)

RegisterNetEvent('collision:setCollision')
AddEventHandler('collision:setCollision', function(targetPed, enable)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    SetEntityNoCollisionEntity(vehicle, targetPed, not enable)
end)
