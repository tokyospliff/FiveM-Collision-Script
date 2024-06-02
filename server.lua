RegisterServerEvent('collision:checkProximity')
AddEventHandler('collision:checkProximity', function(vehicle)
    local source = source
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        if playerId ~= source then
            TriggerClientEvent('collision:setCollision', source, GetPlayerPed(playerId), true)
        end
    end
end)
