---muchstuff

---nutcracker

local BBTmplFile = '/lua/basetemplates.lua'
local BuildingTmpl = 'BuildingTemplates'
local BaseTmpl = 'BaseTemplates'
local ExBaseTmpl = 'ExpansionBaseTemplates'
local Adj2x2Tmpl = 'Adjacency2x2'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local SUtils = import('/lua/AI/sorianutilities.lua')
local categories = categories


--- upgrade quick factory



-- sub commander teleport rush -- many platoons and builders to fulfil need

BuilderGroup {
    BuilderGroupName = 'NCquantumgatecoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
       
    BuilderName = 'NC Gate Engineercoinflip',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 9999,
  
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        { MIBC, 'FactionIndex', { 2, 4 }},
        {CF,'TeleportStrategyActivated',{}},
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.GATE}},
    },
    BuilderType = 'Any',
    BuilderData = {
        Construction = {
            BuildStructures = {
                'T3QuantumGate',
            },
            Location = 'LocationType',
            AdjacencyCategory = 'ENERGYPRODUCTION',
        }
    }
},
Builder {
       
    BuilderName = 'NC Gate Engineercoinflip rambo',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 9999,
  
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        
        {CF,'RamboStrategyActivated',{}},
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.GATE}},
    },
    BuilderType = 'Any',
    BuilderData = {
        Construction = {
            BuildStructures = {
                'T3QuantumGate',
            },
            Location = 'LocationType',
            AdjacencyCategory = 'ENERGYPRODUCTION',
        }
    }
},
Builder {
       
    BuilderName = 'NC Gate Engineercoinflip rambo more',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 950,
    
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        
       
        {CF,'RamboStrategyActivated',{}},
        { EBC, 'GreaterThanEconStorageCurrent', { 125, 4000 } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},  
        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.GATE}},
    },
    BuilderType = 'Any',
    BuilderData = {
        Construction = {
            BuildStructures = {
                'T3QuantumGate',
            },
            Location = 'LocationType',
            AdjacencyCategory = 'ENERGYPRODUCTION',
        }
    }
},
}


BuilderGroup {
    BuilderGroupName = 'NCeconomicupgradesfortelecoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC T1 eco storage coinflip',
    PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
    Priority = 825,
    BuilderConditions = {
        { MIBC, 'FactionIndex', { 2, 4 }},
        {CF,'TeleportStrategyActivated',{}},
        { MIBC, 'GreaterThanGameTime', { 900 } },
        { SIBC, 'HaveLessThanUnitsWithCategory', { 15, 'ENERGYSTORAGE'}},
        { UCBC, 'AdjacencyCheck', { 'LocationType', 'ENERGYPRODUCTION TECH1', 100, 'ueb1105' } },
    },
    BuilderType = 'Any',
    BuilderData = {
        Construction = {
            AdjacencyCategory = 'ENERGYPRODUCTION TECH1',
            AdjacencyDistance = 100,
            BuildClose = false,
            BuildStructures = {
                'EnergyStorage',
            },
        }
    }
},
 
}


BuilderGroup {
    BuilderGroupName = 'NCsubcommander_teleport_coinflip',
    BuildersType = 'FactoryBuilder',
Builder {
    BuilderName = 'NC lots of tele subcommanders',
    PlatoonTemplate = 'NC tele ready',

    Priority = 980,
    BuilderConditions = {
        
        { MIBC, 'FactionIndex', { 2, 4 }},
        {CF,'TeleportStrategyActivated',{}},
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},

Builder {
    BuilderName = 'NC lots of rambo subcommanders',
    PlatoonTemplate = 'NC Rambo builder',
    
    Priority = 980,
    BuilderConditions = {
        {CF,'RamboStrategyActivated',{}},
        { MIBC, 'GreaterThanGameTime', { 600 } },
 
        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},

Builder {
    BuilderName = 'NC lots of rambo subcommanders more',
    PlatoonTemplate = 'NC Rambo builder',
    DelayEqualBuildPlattons = {'Rambo', 25},
    Priority = 980,
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'Rambo' }},
        {CF,'RamboStrategyActivated',{}},
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 18000, 15000 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', { 70, categories.SUBCOMMANDER } },
        
        
    },
    BuilderType = 'Gate',
},

}




    BuilderGroup {
        BuilderGroupName = 'NC Tele SCU Strategy',
        BuildersType = 'PlatoonFormBuilder',
        Builder {
            BuilderName = 'NC Rambo land attack',
            PlatoonTemplate = 'NC RAMBO',
            Priority = 6000,
            InstanceCount = 20,
            FormRadius = 10000,
            BuilderData = {
                SearchRadius = 10000,                                             
                GetTargetsFromBase = false,                                       
                AggressiveMove = false,                                            
                AttackEnemyStrength = 50000,                                      
                IgnorePathing = true,                                              
                TargetSearchCategory = categories.STRUCTURE - categories.NAVAL,    
                TargetHug = true,                                                  
                MoveToCategories = {                                               
                    categories.STRUCTURE * categories.EXPERIMENTAL,
                    categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                    categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3,
                    categories.FACTORY * categories.TECH3,
                    categories.STRUCTURE * categories.EXPERIMENTAL,
                    categories.STRUCTURE * categories.NUKE * categories.STRUCTURE,
                    categories.ALLUNITS - categories.AIR,
                },
                WeaponTargetCategories = {                                          
                    categories.STRUCTURE * categories.EXPERIMENTAL,
                    categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                    categories.FACTORY * categories.TECH3,
                    categories.COMMAND,
                   
                  
                },
            },
            BuilderConditions = {
                
                {CF,'RamboStrategyActivated',{}},
                
              
               
              
                { UCBC, 'HaveGreaterThanArmyPoolWithCategory', { 0, categories.RAMBOPRESET} },
               
                
            },
            BuilderType = 'Any',
        },

        Builder {
            BuilderName = 'NC Teleport',
            PlatoonTemplate = 'NC subcommander huge teleport',
            Priority = 5999,
            InstanceCount = 20,
            FormRadius = 10000,
            BuilderData = {
                SearchRadius = 10000,                                             
                GetTargetsFromBase = false,                                       
                AggressiveMove = false,                                             
                AttackEnemyStrength = 50000,                                       
                IgnorePathing = true,                                               
                TargetSearchCategory = categories.ENERGYPRODUCTION,     
                TargetHug = true,                                                  
                MoveToCategories = {                                               
                categories.STRUCTURE * categories.EXPERIMENTAL,
                categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                categories.STRUCTURE * categories.MASSEXTRACTION * categories.TECH3,
                categories.FACTORY * categories.TECH3,
                categories.STRUCTURE * categories.EXPERIMENTAL,
                categories.STRUCTURE * categories.NUKE * categories.STRUCTURE,
                categories.ALLUNITS - categories.AIR,
                },
                WeaponTargetCategories = {                                          
                categories.STRUCTURE * categories.EXPERIMENTAL,
                categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                categories.FACTORY * categories.TECH3,
                categories.COMMAND,
                   
                  
                },
            },
            BuilderConditions = {
                
                {CF,'TeleportStrategyActivated',{}},
                { MIBC, 'FactionIndex', { 2, 4 }},
                {WRC,'SubCmdrHasUpgradeNC', {'Teleporter', true}},
                { EBC, 'GreaterThanEconStorageCurrent', { 500, 20000} },
              
                { UCBC, 'HaveGreaterThanArmyPoolWithCategory', { 0, categories.SUBCOMMANDER } },
               
                
            },
            BuilderType = 'Any',
        },
        
        
    }
           
        
   







---air t1 bomber spam

BuilderGroup {
    BuilderGroupName = 'NCt1bombercoinflip',
    BuildersType = 'FactoryBuilder',
Builder {
    BuilderName = 'NC t1bomber coinflip',
    PlatoonTemplate = 'T1AirBomber',
    Priority = 990,
    BuilderType = 'Air',
    InstanceCount = 5,
    BuilderConditions = {
        { CF, 'CoinFlip', {14} },
        { SBC, 'MapLessThan', { 2000, 2000 }},
        { MIBC, 'LessThanGameTime', { 1500 } },
        { SBC, 'LessThanThreatAtEnemyBase', { 'AntiAir', 85 }},
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },          
        
        
        
        { SBC, 'NoRushTimeCheck', { 600 }},
      
       
       
       
        
    },
    
},
}



----nuke rush

BuilderGroup {
    BuilderGroupName = 'ncNukecoinflip',
    BuildersType = 'EngineerBuilder',

Builder {
    BuilderName = 'nc T3 Nuke Engineer coinflip',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 1500,
    InstanceCount = 1,
   
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        {CF,'NukeRush',{}},
        
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
  
        
   
      
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            DesiresAssist = true,
            BuildClose = true,
          
            BuildStructures = {
                'T2EngineerSupport',
                'T2EngineerSupport',
                'T2EngineerSupport',
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},


Builder {
    BuilderName = 'NC Assist Build Nuke Missile coinflip',
    PlatoonTemplate = 'AnyEngineerassistNC',
    Priority = 1200,
    InstanceCount = 15,
    BuilderConditions = {
        {CF,'NukeRush',{}},
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, 'NUKE STRUCTURE'}},
        { EBC, 'GreaterThanEconStorageCurrent', { 50, 1000 } },
        
        
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistUntilFinished = true,
            AssistLocation = 'LocationType',
            AssisteeType = 'NonUnitBuildingStructure',
            AssistRange = 150,
            AssisteeCategory = 'STRUCTURE NUKE',
            
        },
    }
},
Builder {
    BuilderName = 'NC cmd Assist Build nuke coinflip',
    PlatoonTemplate = 'CommanderAssistSorian',
    Priority = 1001,
    

   
    BuilderConditions = {
        {CF,'NukeRush',{}},
        { MIBC, 'GreaterThanGameTime', { 600} },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE * categories.STRUCTURE}},
        
       
       
        
        
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistUntilFinished = true,
            AssistLocation = 'LocationType',
            AssisteeType = 'Engineer',
            AssistRange = 150,
            BeingBuiltCategories = {'STRUCTURE NUKE'},
            
        },
    }
},
Builder {
    BuilderName = 'NC cmd Assist Build Nuke Missile',
    PlatoonTemplate = 'CommanderAssistSorian',
    Priority = 950,

    BuilderConditions = {
        {CF,'NukeRush',{}},
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, 'NUKE STRUCTURE'}},
        { EBC, 'GreaterThanEconStorageCurrent', { 50, 1000 } },
        
        
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistUntilFinished = true,
            AssistLocation = 'LocationType',
            AssisteeType = 'NonUnitBuildingStructure',
            AssistRange = 150,
            AssisteeCategory = 'STRUCTURE NUKE',
            
        },
    }
},
}



----arty rush

BuilderGroup {
    BuilderGroupName = 'NCartycoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC arty in range coinflip',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 1500,
    
   
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        { MIBC, 'GreaterThanGameTime', { 600 } },
        
        { CF, 'CoinFlip', {4 } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
        {WRC,'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
        
   
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
        
            BuildStructures = {
                'T3Artillery',

            },
            Location = 'LocationType',
        }
    }
},
}

----air experimental



BuilderGroup {
    BuilderGroupName = 'NCairexpcoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NCairexpcoinflip',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 1500,
    
    BuilderConditions = {
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { MIBC, 'FactionIndex', {2,3, 4}},
        { MIBC, 'GreaterThanGameTime', { 500} },
        { CF, 'CoinFlip', {6 } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.AIR }},
        
        
        { SIBC, 'T4BuildingCheck', {} },
        
    
    },
    BuilderType = 'Any',
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
        
            BuildStructures = {
                'T4AirExperimental1',
            },
            Location = 'LocationType',
        }
    }
},
}


---



----land experimental



BuilderGroup {
    BuilderGroupName = 'NClandexpcoinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Land Exp1 coinflip',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 1500,
       
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'GreaterThanGameTime', { 600} },
            { CF, 'CoinFlip', {2 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
          
         
          
           
           
          
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2}},
          
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
            
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NClandfactoryrushcoinflip',
    BuildersType = 'EngineerBuilder',
    # =============================
    #     Land Factory Builders
    # =============================
    Builder {        
        BuilderName = 'NC T1 Land Factory coinflip',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1100,
    
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1200 } },
            { CF, 'CoinFlip', {7 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
           
            { SIBC, 'HaveLessThanUnitsWithCategory', { 20, categories.FACTORY * categories.LAND}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            
           
            { EBC, 'GreaterThanEconStorageCurrent', {125, 4000 } }, 
            
           
           
           
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
}

BuilderGroup {
    BuilderGroupName = 'NCTtankandartyspamcoinflip',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 spam tank coinflip',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 800,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { CF, 'CoinFlip', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            
           
			
           
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } }, 
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 spam Mortar coinflip ',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 800,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { CF, 'CoinFlip', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            
          
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } }, 
            
        },
        BuilderType = 'Land',
    },
}

BuilderGroup {
    BuilderGroupName = 'NC Satelite coinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'Nc Satelite speedbuild on coinflip',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 1100,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { CF, 'CoinFlip', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 600} },
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.EXPERIMENTAL } },

        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 6,
            Construction = {
                BuildClose = true,
                #T4 = true,
                AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T4SatelliteExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    
    
}

BuilderGroup {
    BuilderGroupName = 'ncdukehukemcoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'nc T3 Nuke dukenukem',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 1100,
    
    InstanceCount = 1,
    
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
  
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { CF, 'DukeNukemEnabled', {} },
        
        { EBC, 'GreaterThanEconStorageCurrent', { 1000, 7000 } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
            AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
            BuildStructures = {
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},

}

BuilderGroup {
    BuilderGroupName = 'NCparagoncoinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Econ coinflip',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1100,
		InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13 } },
            { MIBC, 'GreaterThanGameTime', { 600} },
		    { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
   
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
            Construction = {
                BuildClose = false,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4EconExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC Econ coinflip backups builds',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1,
		InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13}},
            { MIBC, 'GreaterThanGameTime', { 600} },
		    { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
            Construction = {
                BuildClose = false,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4EconExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
  
    
}


  
BuilderGroup {
    BuilderGroupName = 'NCcoinrapidfire',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC coinflip rapid fire',
    PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
    Priority = 1050,
    DelayEqualBuildPlattons = {'biglyspendly', 60},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
        { MIBC, 'FactionIndex', {2}},
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { CF, 'CoinFlip', {15} },
        { MIBC, 'GreaterThanGameTime', { 600 } },
        
  
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.ARTILLERY - categories.TECH2}},
        { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
        { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
   
       
 


    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
            #T4 = true,
        
            BuildStructures = {
                'T3RapidArtillery',
'T3ShieldDefense',

            },
            Location = 'LocationType',
        }
    }
},

}

BuilderGroup {
    BuilderGroupName = 'NCMobileNavalExperimentalcoinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Aeon T4 Sea Exp1 Engineer',
        PlatoonTemplate = 'T3EngineerBuilder',
        Priority = 1200,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
     
            { CF, 'SeaMonsterActivated', {} },
            {CF, 'NoDukeNukem',{}},

            { MIBC, 'FactionIndex', {2}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL  }},
            { SIBC, 'HaveLessThanUnitsWithCategory', { 4, categories.EXPERIMENTAL * categories.NAVAL } },
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
  
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
                #T4 = true,
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T4SeaExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC uef T4 Sea Exp1 Engineer',
        PlatoonTemplate = 'T3EngineerBuilder',
        Priority = 1200,
        BuilderConditions = {
            
            { CF, 'SeaMonsterActivated', {} },
            {CF, 'NoDukeNukem',{}},
            { MIBC, 'FactionIndex', {1}},
            { SIBC, 'HaveLessThanUnitsWithCategory', { 4, categories.EXPERIMENTAL * categories.NAVAL } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL  }},
           
            { MIBC, 'FactionIndex', {1}},
            
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
  
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
                #T4 = true,
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T4SeaExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
   
   
}

BuilderGroup {
    BuilderGroupName = 'NCMobileNavalExperimentalbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T4 Exp Sea',
        PlatoonTemplate = 'T4ExperimentalSeaSorian',
        #PlatoonAddBehaviors = { 'TempestBehaviorSorian' },
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        #PlatoonAIPlan = 'AttackForceAI',
        Priority = 1300,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { CF, 'SeaMonsterActivated', {} },
            { MIBC, 'FactionIndex', {1,2}},
            { SBC, 'NoRushTimeCheck', { 0 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL NAVAL' } },
        },
        FormRadius = 250,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 300,
          
            },
            PrioritizedCategories = { 'STRUCTURE' }, 
        },
    
}

