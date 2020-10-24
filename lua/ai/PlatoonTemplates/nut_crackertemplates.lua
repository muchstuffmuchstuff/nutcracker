--[[
    File    :   /lua/AI/PlattonTemplates/nut_crackertemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]

PlatoonTemplate {
    Name = 'T4ExperimentalAirNC',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL * categories.MOBILE - categories.SATELLITE, 7, 10, 'attack', 'GrowthFormation' },
    }
}

PlatoonTemplate {
    Name = 'T3AirScoutFormNC',
    Plan = 'ScoutingAISorian',
    GlobalSquads = {
        { categories.AIR * categories.INTELLIGENCE * categories.TECH3, 5, 5, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'AntiAirT4GuardNC',
    Plan = 'GuardExperimentalSorian',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR * ( categories.TECH1 + categories.TECH2 + categories.TECH3 ) - categories.BOMBER - categories.TRANSPORTFOCUS - categories.EXPERIMENTAL, 40, 50, 'attack', 'none' },
    }
}
