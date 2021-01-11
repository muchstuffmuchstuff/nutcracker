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
            { CF, 'StrategyRandomizer', {9} },
      
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.ENGINEER} },   
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
                
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
            { CF, 'StrategyRandomizer', {9} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.ENGINEER} },
               
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
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
            { CF, 'StrategyRandomizer', {10} },
      
          
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
                
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
            { CF, 'StrategyRandomizer', {10} },
         
               
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY * (categories.TECH2 + categories.TECH3)} },
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
    DelayEqualBuildPlattons = {'Factories', 5},
    BuilderConditions = {
        { MIBC, 'FactionIndex', { 2, 4 }},
        { CF, 'StrategyRandomizer', {22222} },
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
    Builder {
       
        BuilderName = 'NC Gate Engineercoinflip rambo',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1050,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            
            { CF, 'StrategyRandomizer', {111} },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'GATE TECH3 STRUCTURE'}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 2, 'GATE TECH3 STRUCTURE' }},
         
            
         
            
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
        { CF, 'StrategyRandomizer', {22222} },
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
        DelayEqualBuildPlattons = {'Energy', 3},
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'FactionIndex', { 2, 4 }},
            { CF, 'StrategyRandomizer', {22222} },
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
        { CF, 'StrategyRandomizer', {222222} },
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.05 }},
        
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},
Builder {
    BuilderName = 'NC lots of rambo subcommanders',
    PlatoonTemplate = 'NC rambo preset',
    
    Priority = 980,
    BuilderConditions = {
      
        { CF, 'StrategyRandomizer', {111} },
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.05 }},
        
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 60, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},
}

BuilderGroup {
    BuilderGroupName = 'NC rambo behavior',
    BuildersType = 'PlatoonFormBuilder',

}


    BuilderGroup {
        BuilderGroupName = 'NC Tele SCU Strategy',
        BuildersType = 'PlatoonFormBuilder',
    
            Builder {
                BuilderName = 'NC Teleport',
                PlatoonTemplate = 'NC subcommander huge teleport',
                Priority = 2000,
                InstanceCount = 20,
                FormRadius = 250,
                BuilderData = {
                    SearchRadius = 10000,                                               -- Searchradius for new target.
                    GetTargetsFromBase = false,                                         -- Get targets from base position (true) or platoon position (false)
                    AggressiveMove = false,                                             -- If true, the unit will attack everything while moving to the target.
                    AttackEnemyStrength = 50000,                                        -- Compare platoon to enemy strenght. 100 will attack equal, 50 weaker and 150 stronger enemies.
                    IgnorePathing = true,                                               -- If true, the platoon will not use AI pathmarkers and move directly to the target
                    TargetSearchCategory = categories.STRUCTURE - categories.NAVAL,     -- Only find targets matching these categories.
                    MoveToCategories = {                                                -- Move to targets
                        categories.STRUCTURE * categories.EXPERIMENTAL * categories.ECONOMIC,
                        categories.STRUCTURE * categories.EXPERIMENTAL * categories.SHIELD,
                        categories.STRUCTURE * categories.ENERGYPRODUCTION * categories.TECH3,
                        categories.STRUCTURE * categories.EXPERIMENTAL,
                        categories.FACTORY * categories.TECH3,
                        categories.ALLUNITS - categories.AIR,
                    },
                },
                BuilderConditions = {
                    { CF, 'StrategyRandomizer', {222222} },
                    { MIBC, 'FactionIndex', { 2, 4 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
                    -- Have we the eco to build it ?
                    { EBC, 'GreaterThanEconStorageCurrent', { 1, 50000 } },
                    -- When do we want to build this ?
                    { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SUBCOMMANDER} },
                 
                    -- Respect UnitCap
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
    InstanceCount = 50,
    BuilderConditions = {
        { CF, 'StrategyRandomizer', {1} },
        { SBC, 'MapLessThan', { 2000, 2000 }},
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },          
        
        
        
        { SBC, 'NoRushTimeCheck', { 600 }},
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.5} },
       
       
       
        
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
                { CF, 'StrategyRandomizer', {1} },
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * (categories.TECH1 + categories.TECH2) * categories.BOMBER   * categories.MOBILE - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102} },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                    'EXPERIMENTAL LAND',
                    'MOBILE LAND',
                                   
    
                    
                    
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
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 999,
    InstanceCount = 1,
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { CF, 'StrategyRandomizer', {3 } },
   
        { EBC, 'GreaterThanEconStorageRatio', { 0.00, 1.0}},
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
            AdjacencyCategory = 'SHIELD STRUCTURE',
            BuildStructures = {
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},
Builder {
    BuilderName = 'NC Assist Build t3 coinflip',
    PlatoonTemplate = 'T3EngineerAssist',
    Priority = 1001,
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },

    InstanceCount = 1,
    BuilderConditions = {
        { CF, 'StrategyRandomizer', {3 } },
        { MIBC, 'GreaterThanGameTime', { 1000 } },
        { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05}},
       
        
        
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

----arty rush

BuilderGroup {
    BuilderGroupName = 'NCartycoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC arty in range coinflip',
    PlatoonTemplate = 'T3EngineerBuilderSorian',
    Priority = 1500,
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    {  DelayEqualBuildPlattons = 'Artillery', 40},
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 1000 } },
        { CF, 'StrategyRandomizer', {4 } },
        {WRC,'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
        
        { EBC, 'GreaterThanEconStorageRatio', { 0.0, 1.0}},
     

    
        
      
        
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
        { CF, 'StrategyRandomizer', {6 } },
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
    Priority = 995,
    DelayEqualBuildPlattons = {'MobileExperimental', 50},
    BuilderConditions = {
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { MIBC, 'FactionIndex', {2, 4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },
        { CF, 'StrategyRandomizer', {6 } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
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
            { CF, 'StrategyRandomizer', {2 } },
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
        Priority = 950,
        DelayEqualBuildPlattons = {'MobileExperimental', 30},
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { CF, 'StrategyRandomizer', {2 } },
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
            { CF, 'StrategyRandomizer', {7 } },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
           
            { SIBC, 'HaveLessThanUnitsWithCategory', { 15, categories.FACTORY * categories.LAND}},
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
            { CF, 'StrategyRandomizer', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
           
			
           
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
            { CF, 'StrategyRandomizer', {7 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
          
			
            
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
            { CF, 'StrategyRandomizer', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 1000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },

           
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
            { CF, 'StrategyRandomizer', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
       --- 
       { EBC, 'GreaterThanEconStorageCurrent', { 5000, 7000 } },
            
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
            { CF, 'StrategyRandomizer', {11 } },
            { MIBC, 'FactionIndex', {1}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 7000 } },
            
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
    InstanceCount = 1,
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { CF, 'StrategyRandomizer', {12 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 1000, 7000 } },
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2 } },
        
    },
    BuilderType = 'Any',
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
            AdjacencyCategory = 'SHIELD STRUCTURE',
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
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },

    InstanceCount = 1,
    BuilderConditions = {
        { CF, 'StrategyRandomizer', {12 } },
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


  