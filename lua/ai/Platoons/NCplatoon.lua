#####Structure
PlatoonTemplate {
    Name = 'T2TacticalLauncherNC',
    Plan = 'TacticalAINC',
    GlobalSquads = {
        { categories.STRUCTURE * categories.TACTICALMISSILEPLATFORM, 1, 1, 'attack', 'none' },
    }
}
#####Air
PlatoonTemplate {
    Name = 'clenseNC',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER + categories.ANTIAIR) - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.EXPERIMENTAL, 1, 3, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'AntiAirT4GuardNC',
    Plan = 'GuardExperimentalSorian',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER - categories.TRANSPORTFOCUS - categories.EXPERIMENTAL, 1, 5, 'attack', 'none' },
    }
}


PlatoonTemplate {
    Name = 'NCfactorystomp',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT, 1, 2, 'attack', 'none' },
    },
}

PlatoonTemplate {
    Name = 'NCfighterhunter',
    Plan = 'FighterHuntNC', 
    GlobalSquads = {
         { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT, 1, 5, 'attack', 'none' },
    },
}

PlatoonTemplate {
    Name = 'NCfighterhunterlate',
    Plan = 'FighterHuntNC', 
    GlobalSquads = {
         { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT, 3, 5, 'attack', 'none' },
    },
}


PlatoonTemplate {
    Name = 'NCt4snipe',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
  
        { categories.AIR * categories.MOBILE * categories.ANTIAIR*(categories.TECH2 + categories.TECH3) - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT , 1, 3, 'Attack', 'GrowthFormation' },
    },
}


PlatoonTemplate {
    Name = 'NCCommanderSnipe',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
  
        { categories.AIR * categories.MOBILE * categories.BOMBER * ( categories.TECH2 + categories.TECH3) * categories.GROUNDATTACK - categories.ANTINAVY, 2, 5, 'Attack', 'GrowthFormation' },
    },
}


PlatoonTemplate {
    Name = 'AntiAirBaseGuardNC',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT, 1, 1, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'NCairexperimentalattack',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 1, 1, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ncairengihunt',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.EXPERIMENTAL, 1, 6, 'Attack', 'GrowthFormation' },
        
    },
}


PlatoonTemplate {
    Name = 'NCbuildoncebaseguard',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.TRANSPORTFOCUS - categories.EXPERIMENTAL - categories.SCOUT, 1, 1, 'attack', 'none' },
    }
}


PlatoonTemplate {
    Name = 'T3AirScoutFormswarm',
    Plan = 'ScoutingAISorian',
    GlobalSquads = {
        { categories.AIR * categories.INTELLIGENCE * categories.TECH3, 4, 4, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutFormswarm',
    Plan = 'ScoutingAISorian',
    GlobalSquads = {
        { categories.AIR * categories.INTELLIGENCE * categories.TECH3, 4, 4, 'scout', 'None' },
    }
}

####Land
PlatoonTemplate {
    Name = 'StrikeForceMediumNC',
    Plan = 'AttackForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 3, 5, 'Attack', 'none' }
    },
}

####Naval
PlatoonTemplate {
    Name = 'SeaHuntNC',
    Plan = 'NavalHuntNC',
    GlobalSquads = {
        { categories.MOBILE * categories.NAVAL - categories.EXPERIMENTAL - categories.CARRIER, 1, 5, 'Attack', 'GrowthFormation' }
    },
}

