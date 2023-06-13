-- QBCore Exports --
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('mk-DumpsterDepths:Server:HealthStatus', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if not Player.PlayerData.metadata['isdead'] and not Player.PlayerData.metadata['inlaststand'] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)