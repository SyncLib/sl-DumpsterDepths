-- QBCore Exports / Variables --
local QBCore = exports['qb-core']:GetCoreObject()
local insideDumpster = false
local Timer = 0
local isLocked = false

RegisterNetEvent('mk-DumpsterDepths:Client:HideInDumpster', function(source)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Stash', 0.25)

    isLocked = math.random(1, 3)

    QBCore.Functions.Progressbar('opening_lid', 'Opening lid', Config.Progressbar.OpenLid.Length * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 17,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())

        QBCore.Functions.TriggerCallback('mk-DumpsterDepths:Server:HealthStatus', function(Health)
            if Health then
                local Player = PlayerPedId()
                local Position = GetEntityCoords(Player)

                for i = 1, #Config.DumpsterProps do
                    local Dumpster = GetClosestObjectOfType(Position.x, Position.y, Position.z, 1.0, Config.DumpsterProps[i], false, false, false)
                    local DumpsterPos = GetEntityCoords(Dumpster)
                    local Distance = #(Position - DumpsterPos)

                    if Distance < Config.InteractionDistance then
                        if isLocked == Config.LockedValue then
                            QBCore.Functions.Notify('Dumpster Locked', 'error')
                            isLocked = false
                        else
                            AttachEntityToEntity(Player, Dumpster, -1, 0.0, -0.2, 2.0, 0.0, 0.0, 0.0, true, true, true, false, 2, true)
                            QBCore.Functions.PlayAnim('timetable@floyd@cryingonbed@base', 'base', false, 1000)
                            SetEntityVisible(Player, false, 0)
                            insideDumpster = true
                            isLocked = false
                            exports['qb-core']:DrawText('[E] Exit Dumpster', 'left')

                            CreateThread(function()
                                while insideDumpster do
                                    Wait(0)
                                    if IsControlJustReleased(0, 38) then
                                        Timer = 0
                                        insideDumpster = false
                                        ClearPedTasks(Player)
                                        DetachEntity(Player, true, true)
                                        SetEntityCoords(Player, GetOffsetFromEntityInWorldCoords(Player, 0.0, -0.7, -0.75))
                                        SetEntityVisible(Player, true, 0)
                                        exports['qb-core']:HideText()
                                    end
                                end
                            end)

                            CreateThread(function()
                                while Timer < Config.ElapsedTime and insideDumpster do
                                    Wait(1000)
                                    Timer = Timer + 1
                                end

                                if Timer >= Config.ElapsedTime then
                                    Timer = 0
                                    insideDumpster = false
                                    ClearPedTasks(Player)
                                    DetachEntity(Player, true, true)
                                    SetEntityCoords(Player, GetOffsetFromEntityInWorldCoords(Player, 0.0, -0.7, -0.75))
                                    SetEntityVisible(Player, true, 0)
                                    exports['qb-core']:HideText()
                                    QBCore.Functions.Notify('Rats kicked you out', 'error')
                                end
                            end)
                        end
                    end
                end
            else
                QBCore.Functions.Notify('Player Injured', 'error')
            end
        end)
    end, function()
        ClearPedTasks(PlayerPedId())
    end)
end)

-- Dumpster Props Target (qb-target) --
exports['qb-target']:AddTargetModel(Config.DumpsterProps, {
    options = {
        {
            type = 'client',
            event = 'mk-DumpsterDepths:Client:HideInDumpster',
            icon = Config.DumpsterIcon,
            label = Config.DumpsterLabel,
        },
    },
    distance = Config.InteractionDistance,
})