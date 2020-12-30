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


-- sub commander teleport rush -- many platoons and builders to fulfil need

BuilderGroup {
    BuilderGroupName = 'NCquantumgatecoinflip',
    BuildersType = 'EngineerBuilder',
Builder {
       
    BuilderName = 'NC Gate Engineercoinflip',
    PlatoonTemplate = 'T3EngineerBuilder',
    Priority = 1050,
    DelayEqualBuildPlattons = {'Factories', 5},
    BuilderConditions = {
        { MIBC, 'FactionIndex', { 2, 4 }},
        { CF, 'StrategyRandomizer', {1} },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'GATE TECH3 STRUCTURE'}},
        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
        { UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'GATE TECH3 STRUCTURE' }},
     
        { IBC, 'BrainNotLowPowerMode', {} },
     
        
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
        PlatoonTemplate = 'T3EngineerBuilder',
        Priority = 1050,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            
            { CF, 'StrategyRandomizer', {111} },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'GATE TECH3 STRUCTURE'}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 2, 'GATE TECH3 STRUCTURE' }},
         
            { IBC, 'BrainNotLowPowerMode', {} },
         
            
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
        { CF, 'StrategyRandomizer', {1} },
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
            { CF, 'StrategyRandomizer', {1} },
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
        { CF, 'StrategyRandomizer', {1} },
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

    Builder {
        BuilderName = 'NC ramboattack',
        PlatoonTemplate = 'NC Rambo',
            PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
            PlatoonAddBehaviors = { 'AirLandToggleSorian' },
            Priority = 10000,
            InstanceCount = 60,
            BuilderConditions = { 
                { CF, 'StrategyRandomizer', {111} },
                            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.SUBCOMMANDER } },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                TargetSearchCategory = categories.MOBILE * categories.LAND - categories.SCOUT,
                MoveToCategories = {                                               
                    categories.MOBILE * categories.LAND,
                },
              
                SearchRadius = 6000,           
                ThreatSupport = 40,
                PrioritizedCategories = {
    
    
                'EXPERIMENTAL LAND',
                    'ALLUNITS',
                },
            },    
          
            BuilderType = 'Any',
        },
    }


    BuilderGroup {
        BuilderGroupName = 'NC Tele SCU Strategy',
        BuildersType = 'PlatoonFormBuilder',
    
            Builder {
                BuilderName = 'NC Teleport',
                PlatoonTemplate = 'NC tele ready',
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
                    { MIBC, 'FactionIndex', { 2, 4 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
                    -- Have we the eco to build it ?
                    { EBC, 'GreaterThanEconTrend', { 0, 1000 } }, -- relative income (wee need 10000 energy for a teleport. x3 SACU's
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
    Priority = 100,
    BuilderType = 'Air',
    InstanceCount = 30,
    BuilderConditions = {
        { CF, 'StrategyRandomizer', {5} },
        { SBC, 'MapLessThan', { 2000, 2000 }},
                    { MIBC, 'LessThanGameTime', { 1500 } },
        
        
        { IBC, 'BrainNotLowPowerMode', {} },
        { SBC, 'NoRushTimeCheck', { 600 }},
        
       { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.0 }},
       
       
        
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
        { IBC, 'BrainNotLowPowerMode', {} },
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
       
        
        { IBC, 'BrainNotLowPowerMode', {} },
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
     

    
        { IBC, 'BrainNotLowPowerMode', {} },
      
        
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
        { IBC, 'BrainNotLowPowerMode', {} },
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
            { MIBC, 'FactionIndex', {1,2, 3, 4}},
         
          
           
           
          
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
            { IBC, 'BrainNotLowPowerMode', {} },
           
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
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
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
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.01 }},
            
        },
        BuilderType = 'Land',
    },
}
  