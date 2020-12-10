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
        { categories.MOBILE * categories.AIR  - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.SCOUT - categories.ANTIAIR, 10, 20, 'Attack', 'GrowthFormation' },
        
    },
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
         { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT, 1, 100, 'attack', 'none' },
    },
}

PlatoonTemplate {
    Name = 'NCfighterhunterlate',
    Plan = 'FighterHuntNC', 
    GlobalSquads = {
         { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT, 10, 10, 'attack', 'none' },
    },
}

PlatoonTemplate {
    Name = 'NCfighterhunterverylate',
    Plan = 'FighterHuntNC', 
    GlobalSquads = {
         { categories.AIR * categories.MOBILE * categories.ANTIAIR * categories.TECH3 - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT, 30, 100, 'attack', 'none' },
    },
}


PlatoonTemplate {
    Name = 'NCt4snipe',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
  
        { categories.AIR * categories.MOBILE * categories.ANTIAIR*(categories.TECH2 + categories.TECH3) - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT , 10, 15, 'Attack', 'GrowthFormation' },
    },
}


PlatoonTemplate {
    Name = 'NCCommanderSnipe',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
  
        { categories.AIR * categories.MOBILE * categories.BOMBER * ( categories.TECH2 + categories.TECH3) * categories.GROUNDATTACK - categories.ANTINAVY, 1, 5, 'Attack', 'GrowthFormation' },
    },
}


PlatoonTemplate {
    Name = 'ncguardbaseair',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT, 1, 10, 'attack', 'none' },
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
    Name = 'NCairexperimentalattack2',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 2, 2, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'NCairexperimentalattack3',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 3, 3, 'attack', 'none' },
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
        { categories.AIR * categories.INTELLIGENCE * categories.TECH3, 2, 2, 'scout', 'None' },
    }
}

####Land

PlatoonTemplate {
    Name = 'StrikeForceMediumNC',
    Plan = 'AttackForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 5, 10, 'Attack', 'GrowthFormation' }
    },
}

PlatoonTemplate {
    Name = 'StrikeForceLargeNC',
    Plan = 'AttackForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 10, 30, 'Attack', 'GrowthFormation' }
    },
}


PlatoonTemplate {
    Name = 'landbaseguardNC',
    Plan = 'GuardBaseSorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.SUBCOMMANDER - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 1, 10, 'Attack', 'none' }
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

PlatoonTemplate {
    Name = 'navalhunters',
    Plan = 'NavalHuntAI',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR - categories.ANTIAIR - categories.SCOUT - categories.TRANSPORTFOCUS - categories.EXPERIMENTAL, 1, 100, 'Attack', 'GrowthFormation' },
       
    }
}



###ENGINEER
PlatoonTemplate {
    Name = 'AnyEngineerBuilderNC',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER - categories.SUBCOMMANDER - categories.COMMAND - categories.ENGINEERSTATION , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T2T3EngineerBuilderNC',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) - categories.ENGINEERSTATION , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T3_plus_EngineerBuilderNC',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 * categories.SUBCOMMANDER * categories.COMMAND - categories.ENGINEERSTATION , 1, 1, 'support', 'None' }
    },
}
