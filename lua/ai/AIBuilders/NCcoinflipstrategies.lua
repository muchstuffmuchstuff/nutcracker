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
BuilderGroup {
    BuilderGroupName = 'NC_coinflip_factoryupgrade',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC land factory coinflip upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1100,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { CF, 'CoinFlip', {9} },
      
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.ENGINEER} },   
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
                
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.LAND * categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Land t2 to t3 coinflip',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1100,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { CF, 'CoinFlip', {9} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.ENGINEER} },
               
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.LAND * categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air factory coinflip upgrade',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1100,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { CF, 'CoinFlip', {10} },
      
          
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
                
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.AIR * categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3 coinflip',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1100,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { CF, 'CoinFlip', {10} },
         
               
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.AIR * categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
}


-- sub commander teleport rush -- many platoons and builders to fulfil need

BuilderGroup {
    BuilderGroupName = 'NCquantumgatecoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
       
    BuilderName = 'NC Gate Engineercoinflip',
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1050,
  
    BuilderConditions = {
        { MIBC, 'FactionIndex', { 2, 4 }},
        { CF, 'CoinFlip', {11111} },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'GATE TECH3 STRUCTURE'}},
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
        { UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'GATE TECH3 STRUCTURE' }},
     
        
     
        
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
        { CF, 'CoinFlip', {11111} },
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
    Builder {
        BuilderName = 'NC T3 energy for tele coinflip',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1000,
       
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'FactionIndex', { 2, 4 }},
            { CF, 'CoinFlip', {11111} },
            { MIBC, 'GreaterThanGameTime', { 600} },
         -- relative income
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * categories.TECH3 * categories.ENERGYPRODUCTION } },
            { SIBC, 'LessThanEconEfficiencyOverTime', { 2.0, 2.0 }},
                     
			
        },
        BuilderData = {
            DesiresAssist = true,
          
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',

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
        { CF, 'CoinFlip', {11111} },
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.05 }},
        
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},

}




    BuilderGroup {
        BuilderGroupName = 'NC Tele SCU Strategy',
        BuildersType = 'StrategyBuilder',
    
        
        
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
    InstanceCount = 50,
    BuilderConditions = {
        { CF, 'CoinFlip', {14} },
        { SBC, 'MapLessThan', { 2000, 2000 }},
        { MIBC, 'LessThanGameTime', { 1500 } },
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },          
        
        
        
        { SBC, 'NoRushTimeCheck', { 600 }},
      
       
       
       
        
    },
    
},
}

BuilderGroup {
    BuilderGroupName = 'NCt1bomberunitsbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC t1bomber coinflip behavior',
        PlatoonTemplate = 't1bomberspam',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10000,
            FormRadius = 500,
            InstanceCount = 1000,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
                { CF, 'CoinFlip', {14} },
                { MIBC, 'LessThanGameTime', { 1500 } },
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * (categories.TECH1 + categories.TECH2) * categories.BOMBER   * categories.MOBILE - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102} },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                    'MASSEXTRACTION',
                                   
    
                    
                    
                },
            },
        },
    }  

----nuke rush

BuilderGroup {
    BuilderGroupName = 'ncNukecoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'nc T3 Nuke Engineer coinflip3',
    PlatoonTemplate = 'CommandBuilderNC',
    Priority = 1500,
    InstanceCount = 1,
   
    BuilderConditions = {
        { UCBC, 'CmdrHasUpgrade', { 'AdvancedEngineering', true }},
                { UCBC, 'CmdrHasUpgrade', { 'T3Engineering', true }},
        { CF, 'CoinFlip', {47 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
        
   
      
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            DesiresAssist = true,
            BuildClose = false,
          
            BuildStructures = {
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},
Builder {
    BuilderName = 'nc T3 Nuke Engineer coinflip3 2nd option',
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1500,
    InstanceCount = 1,
   
    BuilderConditions = {
        
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
        { CF, 'CoinFlip', {47 } },
        
   
      
        
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
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},
Builder {
    BuilderName = 'NC Assist Build t3 coinflip',
    PlatoonTemplate = 'T3EngineerAssist',
    Priority = 1200,
    

    InstanceCount = 8,
    BuilderConditions = {
        { CF, 'CoinFlip', {47} },
        { MIBC, 'GreaterThanGameTime', { 700 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
        { EBC, 'GreaterThanEconStorageCurrent', { 50, 1000 } },
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
       
        
        
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
    BuilderName = 'NC Assist Build Nuke Missile coinflip',
    PlatoonTemplate = 'AnyEngineerassistNC',
    Priority = 1200,
    InstanceCount = 15,
    BuilderConditions = {
        { CF, 'CoinFlip', {47 } },
        { MIBC, 'GreaterThanGameTime', { 700 } },
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
        { CF, 'CoinFlip', {47 } },
        { MIBC, 'GreaterThanGameTime', { 700} },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
        
       
       
        
        
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
        { CF, 'CoinFlip', {47 } },
        { MIBC, 'GreaterThanGameTime', { 700 } },
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
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1500,
    DelayEqualBuildPlattons = {'Artyrush', 400},
   
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 1000 } },
        { UCBC, 'CheckBuildPlattonDelay', { 'Artyrush' }},
        { CF, 'CoinFlip', {4 } },
        {WRC,'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 * categories.ARTILLERY } },
        
     

    
        
      
        
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
    BuilderGroupName = 'NCairexpcoinflipbehavior',
    BuildersType = 'PlatoonFormBuilder',
Builder {
    BuilderName = 'nc T4 Exp Air attack coinflip',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack',

    Priority = 1500,
    InstanceCount = 1,
    FormRadius = 250,
    AggressiveMove = true,
    SearchRadius = 80000,
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderType = 'Any',
    BuilderConditions = {
        { CF, 'CoinFlip', {6 } },
        { SBC, 'MapGreaterThan', { 1000, 1000 }},
        { MIBC, 'GreaterThanGameTime', { 1200} },
       
       
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { MIBC, 'FactionIndex', {2, 3, 4}},
        
        { SBC, 'NoRushTimeCheck', { 0 }},
    },
    BuilderData = {
        
        ThreatWeights = {
            TargetThreatType = 'Commander',
        },
        UseMoveOrder = true,
        PrioritizedCategories = { 'COMMAND' }, 
    },
},
}

BuilderGroup {
    BuilderGroupName = 'NCairexpcoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NCairexpcoinflip',
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1500,
    
    BuilderConditions = {
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { MIBC, 'FactionIndex', {2, 4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },
        { CF, 'CoinFlip', {6 } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.AIR }},
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.TECH2 * categories.ENERGYPRODUCTION} },
        
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
    BuilderGroupName = 'NClandexpcoinflipbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'nc T4 Exp Land attack coinflip',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NClandexperimentalattack',
    
        Priority = 1500,
        InstanceCount = 1,
        FormRadius = 250,
        AggressiveMove = false,
        SearchRadius = 80000,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { CF, 'CoinFlip', {2 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL LAND' } },
			
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'COMMAND','ENERGYPRODUCTION' }, 
        },
    },
}

BuilderGroup {
    BuilderGroupName = 'NClandexpcoinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Land Exp1 coinflip',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1500,
       
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { CF, 'CoinFlip', {2 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
          
         
          
           
           
          
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2}},
          
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.LAND }},
         
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
            
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.1} },
            
           
           
           
            
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
        InstanceCount = 200,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { CF, 'CoinFlip', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            
           
			
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 spam Mortar coinflip ',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 800,
        InstanceCount = 200,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { CF, 'CoinFlip', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            
          
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.01 }},
            
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
        BuilderConditions = {
            { CF, 'CoinFlip', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 800} },
            
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * (categories.TECH3 + categories.TECH2) } },

           
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 6,
            Construction = {
                BuildClose = true,
                #T4 = true,
                AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4SatelliteExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC Satelite Assist t2 coinflip',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1200,
    
        BuilderConditions = {
            { CF, 'CoinFlip', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
       --- 
       { EBC, 'GreaterThanEconStorageCurrent', { 500, 7000 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'Nc Satelite Assist t3 coinflip',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1200,
    
        BuilderConditions = {
            { CF, 'CoinFlip', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 7000 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
    
}

BuilderGroup {
    BuilderGroupName = 'ncdukehukemcoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'nc T3 Nuke dukenukem',
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1100,
    DelayEqualBuildPlattons = {'dukenukem', 120},
    InstanceCount = 1,
    
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { CF, 'DukeNukemEnabled', {} },
        { UCBC, 'CheckBuildPlattonDelay', { 'dukenukem' }},
        { EBC, 'GreaterThanEconStorageCurrent', { 1000, 7000 } },
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3) } },
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
            AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
            BuildStructures = {
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},
Builder {
    BuilderName = 'NC Assist Build duke nukem',
    PlatoonTemplate = 'T3EngineerAssist',
    Priority = 1301,
    

    InstanceCount = 1,
    BuilderConditions = {
        { CF, 'DukeNukemEnabled', {} },
        { MIBC, 'GreaterThanGameTime', { 1000 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
        { EBC, 'GreaterThanEconStorageCurrent', { 1000, 7000 } },
       
        
        
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Engineer',
            AssistRange = 150,
            BeingBuiltCategories = {'STRUCTURE NUKE'},
            Time = 320,
        },
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
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13 } },
            { MIBC, 'GreaterThanGameTime', { 1000} },
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
        Priority = 850,
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
		    { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 15000 } },
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
        BuilderName = 'NC T2 Engineer coinflip paragon',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1100,
        InstanceCount = 6,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 15000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer coinflip paragon',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1100,
        InstanceCount = 6,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 15000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
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
    DelayEqualBuildPlattons = {'MobileExperimental_rapid', 500},
    BuilderConditions = {
        { MIBC, 'FactionIndex', {2}},
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { CF, 'CoinFlip', {15} },
        { MIBC, 'GreaterThanGameTime', { 1500 } },
        { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_rapid' }},
  
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
Builder {
    BuilderName = 'NC t3 assist rapid arty - coinflip',
    PlatoonTemplate = 'T3EngineerAssist',
    Priority = 1201,
    InstanceCount = 20,
    BuilderConditions = {
        { MIBC, 'FactionIndex', {2}},
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
        { CF, 'CoinFlip', {15} },
     
   --
        { EBC, 'GreaterThanEconStorageCurrent', { 3000, 15000 } },
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Engineer',
            AssistRange = 250,
            BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
            Time = 300,
        },
    }
},
Builder {
    BuilderName = 'NC t2 assist arty - coinflip',
    PlatoonTemplate = 'T2EngineerAssist',
    Priority = 1201,
    InstanceCount = 20,
    BuilderConditions = {
        { MIBC, 'FactionIndex', {2}},
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
     
   --
        { EBC, 'GreaterThanEconStorageCurrent', { 3000, 15000 } },
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Engineer',
            AssistRange = 250,
            BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
            Time = 300,
        },
    }
},
Builder {
    BuilderName = 'NC t1 assist arty - coinflip',
    PlatoonTemplate = 'EngineerAssist',
    Priority = 1201,
    InstanceCount = 10,
    BuilderConditions = {
        { MIBC, 'FactionIndex', {2}},
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
     
   --
        { EBC, 'GreaterThanEconStorageCurrent', { 3000, 15000 } },
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Engineer',
            AssistRange = 250,
            BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
            Time = 300,
        },
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
        BuilderConditions = {
     
            { CF, 'SeaMonsterActivated', {} },
            {CF, 'NoDukeNukem',{}},

            { MIBC, 'FactionIndex', {2}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL  }},
            { SIBC, 'HaveLessThanUnitsWithCategory', { 4, categories.EXPERIMENTAL * categories.NAVAL } },
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 5000 } },
  
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
            
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 5000 } },
  
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
        BuilderName = 'NC T2 Engineer Assist Experimental Mobile Naval',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 1200,
        InstanceCount = 10,
        BuilderConditions = {
            { CF, 'SeaMonsterActivated', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.NAVAL * categories.MOBILE}},
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE NAVAL'},
                Time = 300,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Experimental Mobile Naval',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1200,
        InstanceCount = 10,
        BuilderConditions = {
            { CF, 'SeaMonsterActivated', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.NAVAL * categories.MOBILE}},
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE NAVAL'},
                Time = 300,
            },
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
        BuilderConditions = {
            { CF, 'SeaMonsterActivated', {} },
            { MIBC, 'FactionIndex', {1,2}},
            { SBC, 'NoRushTimeCheck', { 0 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL NAVAL' } },
        },
        FormRadius = 250,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 300,
          
            },
            PrioritizedCategories = { 'STRUCTURE' }, 
        },
    
}

BuilderGroup {
    BuilderGroupName = 'NCTransportFactorycoinflip',
    BuildersType = 'FactoryBuilder',
Builder {
    BuilderName = 'NC T2 Air Transport coinflip',
    PlatoonTemplate = 'T2AirTransport',
    Priority = 1000,
    BuilderConditions = {
        { CF, 'CoinFlip', {3} },
        { MIBC, 'GreaterThanGameTime', { 500 } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'TRANSPORTFOCUS' } },
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },

        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },

        { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
       
    },
    BuilderType = 'Air',
},
Builder {
    BuilderName = 'NC T3 Air Transport coinflip',
    PlatoonTemplate = 'T3AirTransport',
    Priority = 1000,
    BuilderConditions = {
        { MIBC, 'FactionIndex', {1}},
        { CF, 'CoinFlip', {3} },
        { MIBC, 'GreaterThanGameTime', { 500 } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'TRANSPORTFOCUS' } },
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },

        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
  
        { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
       
    },
    BuilderType = 'Air',
},
}