Config = {}

-- Dumpster Props --
Config.DumpsterProps = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_4b',
}

-- Miscellaneous --
Config.DumpsterIcon = 'fas fa-dumpster' -- Icon Target used for the Dumpster's
Config.DumpsterLabel = 'Hide in dumpster' -- Label Target used for the Dumpster's

Config.ElapsedTime = math.random(15, 30) -- Time (in seconds) when players are kicked out

Config.LockedValue = 3 -- If math.random is equal to 3 it will be locked

Config.InteractionDistance = 2 -- Distance at which players can interact with the dumpsters
Config.InteractionSound = 'rappel' -- Sound played when interacting with the dumpsters

Config.Progressbar = { -- Progress Bar Lengths (seconds)
    OpenLid = {
        Length = math.random(5, 9),
    },
}