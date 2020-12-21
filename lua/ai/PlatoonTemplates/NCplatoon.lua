---Structure

PlatoonTemplate {
    Name = 'T3NukeNC',
    Plan = 'NukeNC',
    GlobalSquads = {
        { categories.NUKE * categories.STRUCTURE * categories.TECH3, 1, 1, 'attack', 'none' },
    }
} 

PlatoonTemplate {
    Name = 'T2TacticalLauncherNC',
    Plan = 'TacticalAINC',
    GlobalSquads = {
        { categories.STRUCTURE * categories.TACTICALMISSILEPLATFORM, 1, 1, 'attack', 'none' },
    }
}
---Air

PlatoonTemplate {
    Name = 'navalhunters',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.TRANSPORTFOCUS - categories.SCOUT , 1, 100, 'Attack', 'GrowthFormation' },
       
    }
}

PlatoonTemplate {
    Name = 'clenseNCt1t2',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * (categories.TECH1 + categories.TECH2) * categories.AIR  * categories.BOMBER - categories.TRANSPORTFOCUS - categories.ANTINAVY -categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD , 1, 2, 'Attack', 'GrowthFormation' },
        
    },
}
PlatoonTemplate {
    Name = 'clenseNCt3',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.TECH3 * categories.AIR  * categories.BOMBER - categories.TRANSPORTFOCUS - categories.ANTINAVY -categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD , 1, 2, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clensegunshipsNCt1t2',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * (categories.TECH1 + categories.TECH2)  * categories.GROUNDATTACK  - categories.ANTINAVY - categories.BOMBER - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 10, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clensegunshipsNCt3',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * categories.TECH3  * categories.GROUNDATTACK - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.BOMBER - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 10, 'Attack', 'GrowthFormation' },
        
    },
}



PlatoonTemplate {
    Name = 'NCfactorystomp',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 2, 'attack', 'none' },
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
  
        { categories.AIR * categories.MOBILE * categories.ANTIAIR*(categories.TECH2 + categories.TECH3) - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT , 10, 15, 'Attack', 'GrowthFormation' },
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
    Name = 'ncguardbasegroundgunship',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.TECH3 - categories.GROUNDATTACK - categories.ANTIAIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 5, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ncguardbasegroundbomber',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.BOMBER * categories.TECH3 - categories.ANTIAIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 5, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ncguardbaseair',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 10, 'attack', 'none' },
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
        { categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.EXPERIMENTAL - categories.INSIGNIFICANTUNIT - categories.POD, 1, 4, 'Attack', 'GrowthFormation' },
        
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

--Land

PlatoonTemplate {
    Name = 'StrikeForceSmallNC',
    Plan = 'AttackForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 1, 5, 'Attack', 'GrowthFormation' }
    },
}

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

PlatoonTemplate {
    Name = 'NClandexperimentalattack',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.EXPERIMENTAL * categories.LAND * categories.MOBILE - categories.url0401, 1, 1, 'attack', 'none' }
    }
}

PlatoonTemplate {
    Name = 'NClandexperimentalattack2',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.EXPERIMENTAL * categories.LAND * categories.MOBILE - categories.url0401, 2,2 , 'attack', 'none' }
    }
}

PlatoonTemplate {
    Name = 'NClandexperimentalattack3',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.EXPERIMENTAL * categories.LAND * categories.MOBILE - categories.url0401, 3, 3, 'attack', 'none' }
    }
}


---Naval
PlatoonTemplate {
    Name = 'SeaHuntNC',
    Plan = 'NavalHuntNC',
    GlobalSquads = {
        { categories.MOBILE * categories.NAVAL - categories.EXPERIMENTAL - categories.CARRIER, 1, 5, 'Attack', 'GrowthFormation' }
    },
}





---ENGINEER
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
    Name = 'T2T3EngineerBuilderNC_FIREBASE',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) - categories.ENGINEERSTATION - categories.SUBCOMMANDER - categories.COMMAND , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T3_plus_EngineerBuilderNC',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 * categories.SUBCOMMANDER * categories.COMMAND - categories.ENGINEERSTATION , 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'NC RAS',
    FactionSquads = {
        UEF = {
            { 'uel0301_RAS', 1, 1, 'Attack', 'None' }
        },
        Aeon = {
            { 'ual0301_RAS', 1, 1, 'Attack', 'None' }
        },
        Cybran = {
            { 'url0301_RAS', 1, 1, 'Attack', 'None' }
        },
      
    }
}