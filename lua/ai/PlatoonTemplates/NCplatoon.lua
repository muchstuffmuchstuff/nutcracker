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
    Name = 'NCt2t3TorpedoBomber',
    Plan = 'HuntAI',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.EXPERIMENTAL, 1, 20, 'Attack', 'GrowthFormation' },
        #{ categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.EXPERIMENTAL - categories.BOMBER - categories.TRANSPORTFOCUS, 0, 10, 'Attack', 'GrowthFormation' },
    }
}

PlatoonTemplate {
    Name = 'navalhunters',
    Plan = 'HuntAI',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * categories.ANTINAVY - categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.TRANSPORTFOCUS - categories.SCOUT , 1, 100, 'Attack', 'GrowthFormation' },
       
    }
}

PlatoonTemplate {
    Name = 't1bomberspam',
    Plan = 'HuntAI',
    GlobalSquads = {
        { categories.MOBILE * (categories.TECH1 + categories.TECH2) * categories.AIR  * categories.BOMBER - categories.TRANSPORTFOCUS - categories.ANTINAVY -categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD , 1, 2, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clenseNCt1t2',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.uea0103 + categories.uaa0103 + categories.ura0103 + categories.xsa0103 , 1, 20, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clenseNCt3',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.TECH3 * categories.AIR  * categories.BOMBER - categories.TRANSPORTFOCUS - categories.ANTINAVY -categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD - categories.daa0206 , 1, 1, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clenseNCt3_cmdsnipe',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.TECH3 * categories.AIR  * categories.BOMBER - categories.TRANSPORTFOCUS - categories.ANTINAVY -categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD - categories.daa0206 , 4, 4, 'Attack', 'none' },
        
    },
}

PlatoonTemplate {
    Name = 'clensegunshipsNCt1t2',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * (categories.TECH1 + categories.TECH2)  * categories.GROUNDATTACK  - categories.ANTINAVY - categories.BOMBER - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD - categories.daa0206, 4, 30, 'Attack', 'GrowthFormation' },
        
    },
}

PlatoonTemplate {
    Name = 'clensegunshipsNCt3',
    Plan = 'StrikeForceAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.AIR * categories.TECH3  * categories.GROUNDATTACK - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.BOMBER - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD - categories.daa0206, 4, 30, 'Attack', 'GrowthFormation' },
        
    },
}


PlatoonTemplate {
    Name = 'NCt4snipe',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
  
        { categories.AIR * categories.MOBILE * categories.ANTIAIR*(categories.TECH2 + categories.TECH3) - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT - categories.INSIGNIFICANTUNIT , 15, 15, 'Attack', 'GrowthFormation' },
    },
}




PlatoonTemplate {
    Name = 'ncguardbasegroundgunship',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.TECH3 * categories.GROUNDATTACK - categories.ANTIAIR - categories.BOMBER - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 5, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ncguardbasegroundbomber',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.BOMBER * categories.TECH3 - categories.GROUNDATTACK - categories.ANTIAIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 5, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ncguardbaseair',
    Plan = 'GuardBaseSorian2',
    GlobalSquads = {
        { categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD, 1, 10, 'attack', 'none' },
    }
}
---coinflip attack



PlatoonTemplate {
    Name = 'NClandexperimentalattack',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.LAND * categories.EXPERIMENTAL * categories.MOBILE, 1, 10, 'attack', 'AttackFormation' },
        { categories.uea0102 + categories.uaa0102 + categories.ura0102 + categories.xsa0102,  0, 30, 'guard', 'AttackFormation' },
        { categories.GROUNDATTACK * categories.AIR * (categories.TECH2 + categories.TECH3),  0, 30, 'attack', 'AttackFormation' },
        { categories.SCOUT * categories.AIR * categories.TECH3,  0, 1, 'attack', 'AttackFormation' },
      
    }
}




---sera air exp

PlatoonTemplate {
    Name = 'NCairexperimentalattack_commandfocus',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 1, 10, 'attack', 'AttackFormation' },
        { categories.SCOUT * categories.AIR * categories.TECH3,  0, 1, 'attack', 'AttackFormation' },
    }
}

PlatoonTemplate {
    Name = 'NCairexperimentalattack_landfocus',
    Plan = 'StrikeForceAISorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 1, 10, 'attack', 'AttackFormation' },
        { categories.SCOUT * categories.AIR * categories.TECH3,  0, 1, 'attack', 'AttackFormation' },
    }
}

PlatoonTemplate {
    Name = 'NCairexperimentalattack_energyfocus',
    Plan = 'StrikeForceAISorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 1, 10, 'attack', 'AttackFormation' },
        { categories.SCOUT * categories.AIR * categories.TECH3,  0, 1, 'attack', 'AttackFormation' },
    }
}

PlatoonTemplate {
    Name = 'NCairexperimentalattack_mexfocus',
    Plan = 'StrikeForceAISorian', 
    GlobalSquads = {
        { categories.AIR * categories.EXPERIMENTAL, 1, 10, 'attack', 'AttackFormation' },
        { categories.SCOUT * categories.AIR * categories.TECH3,  0, 1, 'attack', 'AttackFormation' },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutflyaround',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT * categories.TECH1, 1, 5, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T3AirScoutflyaround',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT * categories.TECH3, 1, 5, 'scout', 'None' },
    }
}



PlatoonTemplate {
    Name = 'T1AirScoutFormswarm',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT * categories.TECH1, 3, 10, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T3AirScoutFormswarm',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT * categories.TECH3, 4, 10, 'scout', 'None' },
    }
}





PlatoonTemplate {
    Name = 'T1AirBomberantispam',
    FactionSquads = {
        UEF = {
         
         
            { 'uea0103', 1, 4, 'Attack', 'None' }, -- T1 Bomber
           
         
        },
        Aeon = {
          
           
            { 'uaa0103', 1, 4, 'scout', 'None' }, -- T1 Bomber
           
           
        },
        Cybran = {
          
          
            { 'ura0103', 1, 4, 'Attack', 'None' }, -- T1 Bomber
          
        
            
        },
        Seraphim = {
           
      
            { 'xsa0103', 1, 4, 'Attack', 'None' }, -- T1 Bomber
            
            
        },
    }
}


PlatoonTemplate {
    Name = 'NCfighterhuntert1',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
        { categories.uea0102 + categories.uaa0102 + categories.ura0102 + categories.xsa0102,  5, 10, 'attack', 'none' },
        
    }
}
PlatoonTemplate {
    Name = 'NCfighterhuntert1_late',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
        { categories.uea0102 + categories.uaa0102 + categories.ura0102 + categories.xsa0102,  10, 40, 'attack', 'none' },
        
    }
}
PlatoonTemplate {
    Name = 'NCfighterhuntert1_verylate',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
        { categories.uea0102 + categories.uaa0102 + categories.ura0102 + categories.xsa0102,  30, 40, 'attack', 'none' },
       
    }
}



PlatoonTemplate {
    Name = 'NCt1fighter_ratio_response',
    FactionSquads = {
        UEF = {
            { 'uea0102', 1, 3, 'Attack', 'GrowthFormation' },-- T1 Fighter
         
            
           
         
        },
        Aeon = {
            { 'uaa0102', 1, 3, 'Attack', 'GrowthFormation' },-- T1 Fighter
           
           
            
           
        },
        Cybran = {
            { 'ura0102', 1, 3, 'Attack', 'GrowthFormation' },-- T1 Fighter
          
          
           
        
            
        },
        Seraphim = {
            { 'xsa0102', 1, 3, 'Attack', 'GrowthFormation' },-- T1 Fighter
      
            
            
            
        },
    }
}



PlatoonTemplate {
    Name = 'NCGuardT4',
    Plan = 'GuardExperimentalSorian',
    GlobalSquads = {
        { categories.uea0303 + categories.uaa0303 + categories.ura0303 + categories.xsa0303,  1, 10, 'attack', 'none' },
    
       
    }
}

PlatoonTemplate {
    Name = 'NCfighterhuntert3',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
        { categories.uea0303 + categories.uaa0303 + categories.ura0303 + categories.xsa0303,  5, 10, 'attack', 'none' },
       
    }
}
PlatoonTemplate {
    Name = 'NCfighterhuntert3_late',
    Plan = 'FighterHuntNC',
    GlobalSquads = {
        { categories.uea0303 + categories.uaa0303 + categories.ura0303 + categories.xsa0303,  10, 10, 'attack', 'none' },
        
    }
}




PlatoonTemplate { Name = 'NCt3fighter_ratio_response',
    FactionSquads = {
        UEF = {
            { 'uea0303', 1, 3, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
           
         },
        Aeon = {
            { 'uaa0303', 1, 3, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
          
        },
        Cybran = {
            { 'ura0303', 1, 3, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
          
        },
        Seraphim = {
            { 'xsa0303', 1, 3, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
         
        },
    }
}
PlatoonTemplate { Name = 'NCt3fighter_ratio_response_exp',
    FactionSquads = {
        UEF = {
            { 'uea0303', 1, 5, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
           
         },
        Aeon = {
            { 'uaa0303', 1, 5, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
          
        },
        Cybran = {
            { 'ura0303', 1, 5, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
          
        },
        Seraphim = {
            { 'xsa0303', 1, 5, 'Attack', 'GrowthFormation' },      -- Air Superiority Fighter
         
        },
     
    }
}






PlatoonTemplate {
    Name = 'NC_T2_gunship_exp_attack',
    FactionSquads = {
        UEF = {
            { 'uea0203', 1, 3, 'Attack', 'GrowthFormation' }, -- T2 Gunship
         
        },
        Aeon = {
            { 'uaa0203', 1, 3, 'Attack', 'GrowthFormation' }, -- T2 Gunship
           
        },
        Cybran = {
            { 'ura0203', 1, 3, 'Attack', 'GrowthFormation' }, -- T2 Gunship
        
            
        },
        Seraphim = {
            { 'xsa0203', 1, 3, 'Attack', 'GrowthFormation' }, -- T2 Gunship
            
        },
    }
}



PlatoonTemplate { 
    Name = 'NC_T3_mix_exp_attack',
    FactionSquads = {
        UEF = {
            { 'uea0305', 1, 3, 'Attack', 'GrowthFormation' },      -- T2 Gunship
          
         },
        Aeon = {
            { 'xaa0305', 1, 3, 'Attack', 'GrowthFormation' },      -- T2 Gunship
            
        },
        Cybran = {
            { 'xra0305', 1, 3, 'Attack', 'GrowthFormation' },      -- T2 Gunship
            
        },
        Seraphim = {
            { 'xsa0304', 1, 2, 'Attack', 'GrowthFormation' }, -- T3 Bomber
            { 'xsa0203', 1, 2, 'Attack', 'GrowthFormation' },     -- T2 Gunship
            
        },
    }
}

--Land
PlatoonTemplate {
    Name = 'T1LandScoutNC',
    Plan = 'ScoutingAISorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.SCOUT * categories.TECH1, 1, 1, 'scout', 'none' }
    }
}




PlatoonTemplate {
    Name = 'StrikeForceSmallNC',
    Plan = 'LandAttackNC',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402, 1, 9, 'Attack', 'GrowthFormation' }
    },
}




PlatoonTemplate {
    Name = 'landbaseguardNC',
    Plan = 'GuardBaseSorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.ANTIAIR - categories.SUBCOMMANDER - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402 - categories.SCOUT, 1, 8, 'Attack', 'none' }
    },
}
PlatoonTemplate {
    Name = 'landbaseguardNCt3',
    Plan = 'GuardBaseSorian',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.TECH3 - categories.ANTIAIR - categories.SUBCOMMANDER - categories.EXPERIMENTAL - categories.ENGINEER - categories.xsl0402 - categories.SCOUT, 1, 8, 'Attack', 'none' }
    },
}




---Naval
PlatoonTemplate {
    Name = 'SeaHuntNC',
    Plan = 'NavalHuntNC',
    GlobalSquads = {
        { categories.MOBILE * categories.NAVAL - categories.EXPERIMENTAL - categories.CARRIER, 1, 5, 'Attack', 'GrowthFormation' }
    },
}



PlatoonTemplate {
    Name = 'T2SeaCruiser',
    FactionSquads = {
        UEF = {
            { 'ues0202', 1, 1, 'support', 'None' }
        },
        Aeon = {
            { 'uas0202', 1, 1, 'support', 'None' }
        },
        Cybran = {
            { 'urs0202', 1, 1, 'support', 'None' }
        },
        Seraphim = {
            { 'xss0202', 1, 1, 'support', 'none' }
        },
      
    }
}



---ENGINEER

PlatoonTemplate {
    Name = 'PresetAssistNC',
    Plan = 'SorianManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.ENGINEERPRESET + categories.RASPRESET , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T3EngineerAssistNC',
    Plan = 'SorianManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 + categories.RASPRESET - categories.SUBCOMMANDER - categories.RAMBOPRESET, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T3EngineerBuilderNC',
    Plan = 'EngineerBuildAISorian',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 + categories.RASPRESET - categories.SUBCOMMANDER - categories.RAMBOPRESET, 1, 1, 'support', 'None' }
    },
}



PlatoonTemplate {
    Name = 'AnyEngineerassistNC',
    Plan = 'SorianManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.ENGINEER + categories.RASPRESET - categories.SUBCOMMANDER - categories.COMMAND - categories.ENGINEERSTATION - categories.RAMBOPRESET , 1, 1, 'support', 'None' }
    },
}



PlatoonTemplate {
    Name = 'NCT3Engineertagteam',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 + categories.RASPRESET - categories.SUBCOMMANDER - categories.COMMAND - categories.ENGINEERSTATION - categories.RAMBOPRESET , 1, 2, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'NCT2T3Engineertagteam',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) + categories.RASPRESET - categories.SUBCOMMANDER - categories.COMMAND - categories.ENGINEERSTATION - categories.RAMBOPRESET, 1, 2, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'CommandBuilderNC',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.COMMAND , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'AnyEngineerBuilderNC',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER  + categories.RASPRESET - categories.SUBCOMMANDER - categories.COMMAND - categories.ENGINEERSTATION - categories.RAMBOPRESET , 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'T2T3EngineerBuilderNC',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) - categories.ENGINEERSTATION - categories.RAMBOPRESET , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T2T3EngineerBuilderNC_FIREBASE',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) + categories.RASPRESET - categories.ENGINEERSTATION - categories.SUBCOMMANDER - categories.COMMAND - categories.RAMBOPRESET , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T3_plus_EngineerBuilderNC',
    Plan = 'EngineerBuildAI',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 + categories.RASPRESET - categories.SUBCOMMANDER + categories.COMMAND - categories.ENGINEERSTATION - categories.RAMBOPRESET , 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'UpgradeNC',
    Plan = 'EnhanceAISorian',
    GlobalSquads = {
        { categories.SUBCOMMANDER, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'NCengineer_startup',
    FactionSquads = {
        UEF = {
            { 'uel0105', 1, 5, 'support', 'None' }
        },
        Aeon = {
            { 'ual0105', 1, 5, 'support', 'None' }
        },
        Cybran = {
            { 'url0105', 1, 5, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0105', 1, 5, 'support', 'none' }
        },
      
    }
}

PlatoonTemplate {
    Name = 'NCengineer_secondbatch',
    FactionSquads = {
        UEF = {
            { 'uel0105', 1, 7, 'support', 'None' }
        },
        Aeon = {
            { 'ual0105', 1, 7, 'support', 'None' }
        },
        Cybran = {
            { 'url0105', 1, 7, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0105', 1, 7, 'support', 'none' }
        },
      
    }
}

PlatoonTemplate {
    Name = 'NCengineer2_startup',
    FactionSquads = {
        UEF = {
            { 'uel0208', 1, 5, 'support', 'None' }
        },
        Aeon = {
            { 'ual0208', 1, 5, 'support', 'None' }
        },
        Cybran = {
            { 'url0208', 1, 5, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0208', 1, 5, 'support', 'none' }
        },
      
    }
}

PlatoonTemplate {
    Name = 'NCengineer3_startup',
    FactionSquads = {
        UEF = {
            { 'uel0309', 1, 5, 'support', 'None' }
        },
        Aeon = {
            { 'ual0309', 1, 5, 'support', 'None' }
        },
        Cybran = {
            { 'url0309', 1, 5, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0309', 1, 5, 'support', 'none' }
        },
      
    }
}

PlatoonTemplate {
    Name = 'T1startonetimeonly',
    FactionSquads = {
        UEF = {
            { 'uel0105', 1, 7, 'support', 'None' }
        },
        Aeon = {
            { 'ual0105', 1, 7, 'support', 'None' }
        },
        Cybran = {
            { 'url0105', 1, 7, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0105', 1, 7, 'support', 'none' }
        },
      
    }
}





    PlatoonTemplate {
        Name = 'NC subcommander huge teleport',
        Plan = 'SACUTeleportAINC',
        GlobalSquads = {
            { categories.SUBCOMMANDER, 3, 3, 'Attack', 'None' }
        },        
    }
    PlatoonTemplate {
        Name = 'NC tele ready',
        FactionSquads = {
         
        
            Aeon = {
                { 'ual0301', 1, 1, 'Attack', 'None' }
            },
            Seraphim = {
                { 'xsl0301', 1, 1, 'Attack', 'None' }
            },
            
          
        }
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

    PlatoonTemplate {
        Name = 'NC RAMBO',
        Plan = 'LandAttackAINC',
        GlobalSquads = {
            { categories.RAMBOPRESET , 1, 1, 'Attack', 'none' }
        },
    }
    PlatoonTemplate {
        Name = 'NC Rambo builder',
        FactionSquads = {
            UEF = {
                { 'uel0301_RAMBO', 1, 1, 'Attack', 'None' }
            },
            Aeon = {
                { 'ual0301_RAMBO', 1, 1, 'Attack', 'None' }
            },
            Cybran = {
                { 'url0301_RAMBO', 1, 1, 'Attack', 'None' }
            },
            Seraphim = {
                { 'xsl0301_RAMBO', 1, 1, 'Attack', 'none' }
            },
          
        }
    }






---subcommander template for tele


----land FACTION TEMPLATES

PlatoonTemplate {
    Name = 'NC t1aphib',
    Plan = 'HuntAISorian', 
    GlobalSquads = {
        { categories.ual0201 + categories.xsl0103, 1, 5,'attack', 'AttackFormation' }, 
         
    },
}

PlatoonTemplate {
    Name = 'NC t1aphibhuntai',
    Plan = 'HuntAI', 
    GlobalSquads = {
        { categories.ual0201 + categories.xsl0103, 1, 5,'attack', 'AttackFormation' }, 
         
    },
}



PlatoonTemplate {
    Name = 'T1aphib',
    FactionSquads = {
       
        
        Aeon = {
            { 'ual0201', 1, 1, 'attack', 'none' }
        },
      
        Seraphim = {
            { 'xsl0103', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'NC t2aphib',
    Plan = 'HuntAISorian', 
    GlobalSquads = {
        { categories.uel0203 + categories.xal0203 + categories.url0203 + categories.xsl0203, 1, 5,'attack', 'AttackFormation' }, 
         
    },
}


PlatoonTemplate {
    Name = 'T2aphib',
    FactionSquads = {
        UEF = {
            { 'uel0203', 1, 1, 'attack', 'none' }
        },
        Aeon = {
            { 'xal0203', 1, 1, 'attack', 'none' }
        },
        Cybran = {
            { 'url0203', 1, 1, 'attack', 'none' }
        },
        Seraphim = {
            { 'xsl0203', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'NC t3aphib',
    Plan = 'HuntAISorian', 
    GlobalSquads = {
        { categories.xel0305 + categories.xrl0305 + categories.xsl0303, 1, 10,'attack', 'AttackFormation' }, 
         
    },
}

PlatoonTemplate {
    Name = 'T3aphib',
    FactionSquads = {
        UEF = {
            { 'xel0305', 1, 1, 'attack', 'none' }
        },
      
        Cybran = {
            { 'xrl0305', 1, 1, 'attack', 'none' }
        },
        Seraphim = {
            { 'xsl0303', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'NC t1massattack',
    Plan = 'StrikeForceAISorian', 
    GlobalSquads = { 
        {categories.LAND * categories.MOBILE * categories.BOT * categories.TECH1, 1, 3, 'attack', 'AttackFormation' } 
    },
}



PlatoonTemplate {
    Name = 'T1massattack',
    FactionSquads = {
       
        
        UEF = {
            { 'uel0106', 1, 4, 'attack', 'none' } --t1 light bot
            
        },
        Aeon = {
            { 'ual0106', 1, 4, 'attack', 'none' } --t1 light bot
           
        },
        Cybran = {
            { 'url0106', 1, 4, 'attack', 'none' } --t1 light bot
           
        },
      
        Seraphim = {
            { 'xsl0101', 1, 4, 'attack', 'none' } --t1 combat scout
            
        },
    }
}

PlatoonTemplate {
    Name = 'NC t1spammage',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.uel0201 + categories.ual0201 + categories.url0107 + categories.xsl0201 , 5, 5, 'attack', 'AttackFormation' },
        { categories.uel0103 + categories.ual0103 + categories.url0103 + categories.xsl0103 , 4, 4, 'Artillery', 'AttackFormation' },
        { categories.ANTIAIR * categories.MOBILE * categories.LAND - categories.EXPERIMENTAL,0,4, 'guard','AttackFormation'},
    }
}
PlatoonTemplate {
    Name = 'NC t1spammagesmall',
    Plan = 'HuntAI',    
    GlobalSquads = {
        { categories.uel0201 + categories.ual0201 + categories.url0107 + categories.xsl0201 , 3, 3, 'attack', 'AttackFormation' },
        { categories.uel0103 + categories.ual0103 + categories.url0103 + categories.xsl0103 , 2, 2, 'Artillery', 'AttackFormation' },
        { categories.ANTIAIR * categories.MOBILE * categories.LAND - categories.EXPERIMENTAL,0,4, 'guard','AttackFormation'},
    }
}

PlatoonTemplate {
    Name = 'T1spammage',
    FactionSquads = {
       
        
        UEF = {
            { 'uel0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'uel0103', 1, 1, 'attack', 'none' },--t1 arty
            { 'uel0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'uel0103', 1, 2, 'attack', 'none' }, --t1 arty
           
        },
        Aeon = {
            { 'ual0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'ual0103', 1, 1, 'attack', 'none' }, --t1 arty
            { 'ual0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'ual0103', 1, 2, 'attack', 'none' }, --t1 arty
           
        },
        Cybran = {
            { 'url0107', 1, 2, 'attack', 'none' }, --t1 tank
            { 'url0103', 1, 1, 'attack', 'none' }, --t1 arty
            { 'url0107', 1, 2, 'attack', 'none' }, --t1 tank
            { 'url0103', 1, 2, 'attack', 'none' }, --t1 arty
           
        },
      
        Seraphim = {
            { 'xsl0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'xsl0103', 1, 1, 'attack', 'none' }, --t1 arty
            { 'xsl0201', 1, 2, 'attack', 'none' }, --t1 tank
            { 'xsl0103', 1, 2, 'attack', 'none' }, --t1 arty
        },
    }
}

PlatoonTemplate {
    Name = 'NC antiairland',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.ANTIAIR - categories.EXPERIMENTAL , 1, 4, 'guard', 'none' },
        
    },
}

PlatoonTemplate {
    Name = 'T1antiairland',
    FactionSquads = {
       
        
        UEF = {
            { 'uel0104', 1, 3, 'attack', 'none' }, --t1 anti air mobile
      
           
        },
        Aeon = {
            { 'ual0104', 1, 3, 'attack', 'none' }, --t1 anti air mobile
         
           
        },
        Cybran = {
            { 'url0104', 1, 3, 'attack', 'none' }, --t1 anti air mobile
         
           
        },
      
        Seraphim = {
            { 'xsl0104', 1, 3, 'attack', 'none' }, --t1 anti air mobile
           
        },
    }
}





PlatoonTemplate {
    Name = 'NC t2 ground attack',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.uel0202 + categories.ual0202 + categories.url0202 + categories.xsl0202 , 5, 5, 'attack', 'AttackFormation' },
        { categories.uel0307 + categories.ual0307 , 0, 1, 'support', 'AttackFormation' },
        { categories.uel0111 + categories.ual0111 + categories.url0111 + categories.xsl0111 + categories.drl0204 , 0, 6, 'Artillery', 'AttackFormation' },
        { categories.ANTIAIR * categories.MOBILE * categories.LAND - categories.EXPERIMENTAL,0,4, 'guard','AttackFormation'},
       
    },
}


PlatoonTemplate {
    Name = 'T2attackgroup',
    FactionSquads = {
        UEF = {
            { 'uel0202', 1, 2, 'attack', 'none' }, --t2 tank
            { 'uel0307', 1, 1, 'attack', 'none' }, --t2 mobile shield
            { 'uel0202', 1, 3, 'attack', 'none' }, --t2 tank
            { 'uel0202', 1, 2, 'attack', 'none' }, --t2 tank
        },
        Aeon = {
            { 'ual0202', 1, 4, 'attack', 'none' }, --t2 heavy tank
            { 'ual0307', 1, 1, 'attack', 'none' }, --t2 mobile shield
           
            { 'ual0202', 1, 3, 'attack', 'none' }, --t2 heavy tank
        },
        Cybran = {
            { 'url0202', 1, 2, 'attack', 'none' }, --t2 tank
            { 'drl0204', 1, 3, 'attack', 'none' }, --t2 rocketbot
           
            { 'url0202', 1, 2, 'attack', 'none' }, --t2 tank

        },
        Seraphim = {
            { 'xsl0202', 1, 4, 'attack', 'none' }, --t2 assault bot
           
            { 'xsl0202', 1, 3, 'attack', 'none' }, --t2 assault bot
        },
    }
}

PlatoonTemplate {
    Name = 'T2mobileturtlecracker',
    FactionSquads = {
        UEF = {
            { 'uel0111', 1, 3, 'attack', 'none' }, 
        
        },
        Aeon = {
            { 'ual0111', 1, 3, 'attack', 'none' }, 
        
        },
        Cybran = {
            { 'url0111', 1, 3, 'attack', 'none' }, 
     

        },
        Seraphim = {
            { 'xsl0111', 1, 3, 'attack', 'none' },
        
        },
    }
}


PlatoonTemplate {
    Name = 'T2antiairland',
    FactionSquads = {
        UEF = {
            { 'uel0205', 1, 3, 'attack', 'none' }, --t2 anti air mobile
        
        },
        Aeon = {
            { 'ual0205', 1, 3, 'attack', 'none' }, --t2 anti air mobile
        
        },
        Cybran = {
            { 'url0205', 1, 3, 'attack', 'none' }, --t2 anti air mobile
     

        },
        Seraphim = {
            { 'xsl0205', 1, 3, 'attack', 'none' }, --t2 anti air mobile
        
        },
    }
}
PlatoonTemplate {
    Name = 'NC t3 ground attack',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.uel0303 + categories.xel0305 + categories.ual0303 + categories.xal0305 + categories.xrl0305 + categories.xsl0303 + categories.xsl0305 , 6, 6, 'attack', 'AttackFormation' },
        { categories.xel0306 + categories.uel0304 + categories.ual0304 + categories.url0304 + categories.xsl0304 , 3, 6, 'artillery', 'AttackFormation' },
        { categories.xsl0307 , 0, 1, 'support', 'AttackFormation' },
        { categories.ANTIAIR * categories.MOBILE * categories.LAND - categories.EXPERIMENTAL,0,4, 'guard','AttackFormation'},
    }
}

PlatoonTemplate {
    Name = 'T3attackgroup',
    FactionSquads = {
        UEF = {
            { 'uel0303', 1, 3, 'attack', 'none' }, --t3 heavy assault bot
          
            { 'xel0305', 1, 2, 'attack', 'none' }, --t3 armored assault bot
            { 'uel0304', 1, 2, 'attack', 'none' }, --t3 mobile arty
            { 'xel0305', 1, 2, 'attack', 'none' }, --t3 armored assault bot
        },
        Aeon = {
            { 'ual0303', 1, 1, 'attack', 'none' }, --t3 heavy bot
            { 'xal0305', 1, 2, 'attack', 'none' }, --t3 sniper bot
            { 'ual0304', 1, 1, 'attack', 'none' }, --t3 mobile arty
            { 'ual0303', 1, 1, 'attack', 'none' }, --t3 heavy bot
            { 'xal0305', 1, 2, 'attack', 'none' }, --t3 sniper bot
           
        },
      
        Cybran = {
            { 'xrl0305', 1, 3, 'attack', 'none' }, ---t3 brick
            { 'url0304', 1, 2, 'attack', 'none' }, ---t3 mobile arty
            { 'xrl0305', 1, 3, 'attack', 'none' }, ---t3 brick
        },
        Seraphim = {
            { 'xsl0303', 1, 2, 'attack', 'none' }, --t3 siege tank
            { 'xsl0304', 1, 2, 'attack', 'none' }, --t3 mobile arty
            { 'xsl0307', 1, 1, 'attack', 'none' }, --t3 mobile shield
            { 'xsl0305', 1, 3, 'attack', 'none' }, --t3 sniper bot
            { 'xsl0303', 1, 1, 'attack', 'none' }, --t3 siege tank
             
        },
    }
}



PlatoonTemplate {
    Name = 'T3antiairland',
    FactionSquads = {
        UEF = {
            { 'delk002', 1, 3, 'attack', 'none' }, --t3 anti air mobile
     
        },
        Aeon = {
            { 'dalk003', 1, 3, 'attack', 'none' }, --t3 anti air mobile
       
           
        },
      
        Cybran = {
            { 'drlk001', 1, 3, 'attack', 'none' }, --t3 anti air mobile
          
        },
        Seraphim = {
            { 'dslk004', 1, 3, 'attack', 'none' }, --t3 anti air mobile
       
             
        },
    }
}

PlatoonTemplate {
    Name = 'NCtorpbomber',
    FactionSquads = {
        UEF = {
            { 'uea0204', 1, 3, 'attack', 'none' }, --t3 anti air mobile
     
        },
        Aeon = {
            { 'xaa0306', 1, 3, 'attack', 'none' }, --t3 anti air mobile
       
           
        },
      
      
        Seraphim = {
            { 'xsa0204', 1, 3, 'attack', 'none' }, --t3 anti air mobile
       
             
        },
    }
}



PlatoonTemplate {
    Name = 'T3mobileturtlecracker',
    FactionSquads = {
        UEF = {
            { 'xel0306', 1, 2, 'attack', 'none' }, 
            { 'uel0304', 1, 2, 'attack', 'none' }, 
        
        },
        Aeon = {
            { 'xal0305', 1, 4, 'attack', 'none' }, 
            { 'dal0310', 1, 4, 'attack', 'none' }, 
              
        },
        Cybran = {
            { 'url0304', 1, 4, 'attack', 'none' }, 
            
        
        },
        Seraphim = {
            { 'xsl0304', 1, 4, 'attack', 'none' }, 
            
        
        },
    } 
}



PlatoonTemplate {
    Name = 'NC Orbital',
    Plan = 'SatelliteAISorian',
    GlobalSquads = {
        { categories.SATELLITE, 1, 1, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'nc land anti air',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.LAND * categories.MOBILE * categories.ANTIAIR - categories.TECH1 - categories.INSIGNIFICANTUNIT - categories.EXPERIMENTAL , 1, 5, 'attack', 'AttackFormation' },
      
    }
}



PlatoonTemplate {
    Name = 'NC all in',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.LAND * categories.MOBILE - categories.uel0304 - categories.url0304 - categories.xsl0304 - categories.INSIGNIFICANTUNIT - categories.EXPERIMENTAL - categories.ENGINEER - categories.COMMAND - categories.SCOUT, 6, 6, 'attack', 'AttackFormation' },
      
    }
}

PlatoonTemplate {
    Name = 'NC arty attack mobile',
    Plan = 'HuntAISorian',    
    GlobalSquads = {
        { categories.uel0304 + categories.url0304 + categories.xsl0304 , 5, 5, 'attack', 'none' },
      
    }
}

PlatoonTemplate { Name = 'T3AirScoutNC',
    FactionSquads = {
        UEF = {
            { 'uea0302', 1, 2, 'Attack', 'GrowthFormation' },      -- t3air scout
           
         },
        Aeon = {
            { 'uaa0302', 1, 2, 'Attack', 'GrowthFormation' },       -- t3air scout
          
        },
        Cybran = {
            { 'ura0302', 1, 2, 'Attack', 'GrowthFormation' },       -- t3air scout
          
        },
        Seraphim = {
            { 'xsa0302', 1, 2, 'Attack', 'GrowthFormation' },       -- t3air scout
         
        },
    }
}
