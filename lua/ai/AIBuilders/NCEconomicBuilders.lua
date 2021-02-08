#***************************************************************************
#*
#**  File     :  /lua/ai/AIEconomicBuilders.lua
#**
#**  Summary  : Default economic builders for skirmish
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local BBTmplFile = '/lua/basetemplates.lua'
local BuildingTmpl = 'BuildingTemplates'
local BaseTmpl = 'BaseTemplates'
local ExBaseTmpl = 'ExpansionBaseTemplates'
local Adj2x2Tmpl = 'Adjacency2x2'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')
local MaxCapMexNC = 0.05


BuilderGroup {
    BuilderGroupName = 'NCt1masscontinuation',
    BuildersType = 'EngineerBuilder',
 
    
    Builder {
        BuilderName = 'NC mass continuation 250 ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        
        Priority = 902,
        InstanceCount = 3,
        
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            RequireTransport = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC mass continuation 500 ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        
        Priority = 901,
        InstanceCount = 3,
        
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            RequireTransport = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC mass continuation 750 ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        InstanceCount = 2,
      
        
        BuilderConditions = {
          
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 750, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            RequireTransport = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCEngineerEnergyBuilders',
    BuildersType = 'EngineerBuilder',

    Builder {
        BuilderName = 'NC T1 Power Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1050,
      
        InstanceCount = 1,
        
        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 200} },

			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3'}},
        
		
			
        },
 
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Power Engineer 2',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1050,
      
        InstanceCount = 2,
        
        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 250} },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3'}},
        
		
			
        },
 
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Power Engineer 3',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1050,
      
        InstanceCount = 2,
        
        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 350} },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3'}},
        
		
			
        },
 
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                },
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCEngineerEnergyBuildersExpansions',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1 Power Engineer Expansions',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
                { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'ENERGYPRODUCTION' } },
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 1, 'ENGINEER TECH2, ENGINEER TECH3' } },
                { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
				{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2'}},
				{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 0.5 }},
				{ SIBC, 'LessThanEconEfficiencyOverTime', { 2.0, 1.3 }},
				{ SIBC, 'LessThanEconEfficiency', { 2.0, 1.25 }},
            },
        InstanceCount = 1,
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 Power Engineer Expansions',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
            { EBC, 'LessThanEnergyTrend', { 200.0 } },
            },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',
                },
                Location = 'LocationType',
            }
        }
    },
   
}






BuilderGroup {
    BuilderGroupName = 'NCT1EngineerBuilders',
    BuildersType = 'EngineerBuilder',
    # =====================================
    #     T1 Engineer Resource Builders
    # =====================================
    Builder {
        BuilderName = 'NC T1 Hydrocarbon Engineer - init',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 0, #1002, #980
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENGINEER * ( categories.TECH2 + categories.TECH3 ) } },
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.MASSEXTRACTION } },
                { SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'HYDROCARBON'}},
				{ SBC, 'CanBuildOnHydroLessThanDistance', { 'LocationType', 200, -500, 0, 0, 'AntiSurface', 1 }},
                #{ SBC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 200}},
            },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Hydrocarbon Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 980,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENGINEER * ( categories.TECH2 + categories.TECH3 ) } },
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.MASSEXTRACTION } },
                #{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'HYDROCARBON'}},
				{ SBC, 'CanBuildOnHydroLessThanDistance', { 'LocationType', 200, -500, 0, 0, 'AntiSurface', 1 }},
                #{ SBC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 200}},
            },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
  
   
    Builder {
        BuilderName = 'NC T1 Engineer Reclaim Old Pgens',
        PlatoonTemplate = 'EngineerBuilderSorian',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 900,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.TECH3 * categories.ENERGYPRODUCTION}},
				{ UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.TECH1 * categories.ENERGYPRODUCTION * categories.DRAGBUILD }},
            },
        BuilderData = {
			Location = 'LocationType',
			Reclaim = {'STRUCTURE ENERGYPRODUCTION TECH1 DRAGBUILD'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T1 Engineer Find Unfinished',
        PlatoonTemplate = 'EngineerBuilderSorian',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 1800,
        InstanceCount = 1,
       
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
                { SBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC', 'STRUCTURE ECONOMIC', 'STRUCTURE'},
                time = 60,
            },
        },
        BuilderType = 'Any',
    },
   
    Builder {
        BuilderName = 'NC T1 Engineer Repair',
        PlatoonTemplate = 'EngineerRepairSorian',
        PlatoonAIPlan = 'RepairAI',
        Priority = 900,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
                { SBC, 'DamagedStructuresInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
   
    Builder {
        BuilderName = 'NC T1 Mass Adjacency Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 925,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
            { MABC, 'MarkerLessThanDistance',  { 'Mass', 250, -3, 0, 0}},
            #-
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { UCBC, 'AdjacencyCheck', { 'LocationType', 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3', 250, 'ueb1106' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'MASSEXTRACTION TECH3, MASSEXTRACTION TECH2',
                AdjacencyDistance = 250,
                BuildClose = false,
                ThreatMin = -3,
                ThreatMax = 0,
                ThreatRings = 0,
                BuildStructures = {
                    'MassStorage',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Energy Storage Engineer',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 825,
        DelayEqualBuildPlattons = {'Energy_storage', 15},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Energy_storage' }},
            { SIBC, 'HaveLessThanUnitsWithCategory', { 7, 'ENERGYSTORAGE'}},
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
        BuilderName = 'NC T1 Energy Storage seraphim',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 725,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4} },
            { CF, 'CoinFlip', {11111} },
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { SIBC, 'HaveLessThanUnitsWithCategory', { 10, 'ENERGYSTORAGE'}},
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
    
    # =========================
    #     T1 ENGINEER ASSIST
    # =========================
    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist Factory',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 200,
    #    BuilderConditions = {
    #   --
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' } },
    #        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
    #    },
    #    InstanceCount = 5,
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            PermanentAssist = false,
                
    #            AssisteeType = 'Factory',
    #            time = 60,
    #        },
    #    }
    #},
    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist FactoryLowerPri',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 500,
    #    InstanceCount = 50,
    #    BuilderConditions = {
    #   --
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' } },
    #        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
    #    },
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            PermanentAssist = false,
             
    #            AssisteeType = 'Factory',
    #            time = 60,
    #        },
    #    }
    #},
    Builder {
        BuilderName = 'NC T1 Engineer Assist Engineer',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 500,
        InstanceCount = 50,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ALLUNITS' } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
              
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
 
    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist Mass Upgrade',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 850,
    #    BuilderConditions = {
    #   --
    #        { UCBC, 'BuildingGreaterAtLocation', { 'LocationType', 0, 'MASSEXTRACTION TECH2'}},
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 5, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' } },
    #        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
    #        { SIBC, 'LessThanEconEfficiencyOverTime', { 1.5, 2.0 }},
    #    },
    #    InstanceCount = 2,            
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssisteeType = 'Structure',
    #            AssistLocation = 'LocationType',
    #            BeingBuiltCategories = {'MASSEXTRACTION TECH2'},
    #            time = 60,
    #        },
    #    }
    #},
    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist Power',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 900,
    #    BuilderConditions = {
    #        { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION' }},
    #        { EBC, 'LessThanEconStorageRatio', { 5.0, 1.00 } },
    #    },
    #    InstanceCount = 2,
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            PermanentAssist = false,
    #            BeingBuiltCategories = {'ENERGYPRODUCTION TECH3', 'ENERGYPRODUCTION TECH2', 'ENERGYPRODUCTION'},
    #            AssisteeType = 'Engineer',
    #            time = 60,
    #        },
    #    }
    #},
    
    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist T2 Factory Upgrade',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 875,
    #    BuilderConditions = {
    #   --
    #        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENGINEER TECH1'}},
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH2' }},
    #        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
    #    },
    #    InstanceCount = 4,
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            PermanentAssist = false,
    #            BeingBuiltCategories = {'FACTORY TECH2'},
    #            AssisteeType = 'Factory',
    #            time = 60,
    #        },
    #    }
    #},

    Builder {
        BuilderName = 'NC T1 Engineer Reclaim',
        PlatoonTemplate = 'EngineerBuilderSorian',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 1,
        InstanceCount = 10,
        BuilderConditions = {
                { SBC, 'ReclaimablesInArea', { 'LocationType', 0, 'AntiSurface', 0 }},
            },
        BuilderData = {
            LocationType = 'LocationType',
            ReclaimTime = 500,
            ThreatRings = 0,
            ThreatType = 'AntiSurface',
            ThreatValue = 0,
        },
        BuilderType = 'Any',
    },

    #Builder {
    #    BuilderName = 'NC T1 Engineer Assist T3 Factory Upgrade',
    #    PlatoonTemplate = 'EngineerAssist',
    #    Priority = 900,
    #    BuilderConditions = {
    #   --
    #        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENGINEER TECH1'}},
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' }},
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'TECH3 FACTORY' } },
    #        { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
    #    },
    #    InstanceCount = 8,
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            PermanentAssist = false,
    #            BeingBuiltCategories = {'FACTORY TECH3'},
    #            AssisteeType = 'Factory',
    #            time = 60,
    #        },
    #    }
    #},    
}

BuilderGroup {
    BuilderGroupName = 'NCT2EngineerBuilders',
    BuildersType = 'EngineerBuilder',
    # =====================================
    #     T2 Engineer Resource Builders
    # =====================================
    Builder {
        BuilderName = 'NC T2 Mass Adjacency Engineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 875,
        BuilderConditions = {
			#{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 1, 'ENGINEER TECH1' }},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
            { MABC, 'MarkerLessThanDistance',  { 'Mass', 250, -3, 0, 0}},
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { UCBC, 'AdjacencyCheck', { 'LocationType', 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3', 250, 'ueb1106' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3',
                AdjacencyDistance = 250,
                BuildClose = false,
                ThreatMin = -3,
                ThreatMax = 0,
                ThreatRings = 0,
                BuildStructures = {
                    'MassStorage',
                }
            }
        }
    },
    
 
    Builder {
        BuilderName = 'NC T2 Engineer Reclaim Old Pgens',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 900,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.TECH3 * categories.ENERGYPRODUCTION}},
				{ UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.TECH1 * categories.ENERGYPRODUCTION * categories.DRAGBUILD }},
            },
        BuilderData = {
			Location = 'LocationType',
			Reclaim = {'STRUCTURE ENERGYPRODUCTION TECH1 DRAGBUILD'},
        },
        BuilderType = 'Any',
    },
   
   
    Builder {
        BuilderName = 'NC T2 Engineer Repair',
        PlatoonTemplate = 'T2EngineerRepairSorian',
        PlatoonAIPlan = 'RepairAI',
        Priority = 925,
        InstanceCount = 1,
        BuilderConditions = {
                { SBC, 'DamagedStructuresInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
 

    # =========================
    #     T2 ENGINEER ASSIST
    # =========================
    Builder {
        BuilderName = 'NC T2 Engineer Assist Energy',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 900,
        InstanceCount = 3,
        BuilderConditions = {
       --
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { EBC, 'LessThanEconStorageRatio', { 5.0, 1.00 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = { 'ENERGYPRODUCTION TECH3', 'ENERGYPRODUCTION TECH2' },
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T2 Engineer Assist Factory',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 500,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderConditions = {
       --
            #{ UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' } },
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
           
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                #BeingBuiltCategories = { 'MOBILE'},
                AssisteeType = 'Factory',
                time = 60,
            },
        }
    },
   
    Builder {
        BuilderName = 'NC T2 Engineer Assist Engineer',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 500,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderConditions = {
       --
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ALLUNITS' } },
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
           
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = { 'ALLUNITS' },
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T2 Engineer Assist T3 Factory Upgrade',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 975,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENGINEER TECH1'}},
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' }},
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
           
       --
        },
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = {'FACTORY TECH3'},
                AssisteeType = 'Factory',
                time = 60,
            },
        }
    },
    
}

BuilderGroup {
    BuilderGroupName = 'NCT3EngineerBuilders',
    BuildersType = 'EngineerBuilder',
    # =========================
    #     T3 ENGINEER BUILD
    # =========================
  

  
  
    Builder {
        BuilderName = 'NC T3 Engineer Repair',
        PlatoonTemplate = 'T3EngineerRepairSorian',
        PlatoonAIPlan = 'RepairAI',
        Priority = 925,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
                { SBC, 'DamagedStructuresInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    
    
    # =========================
    #     T3 ENGINEER ASSIST
    # =========================
    Builder {
        BuilderName = 'NC T3 Engineer Assist T3 Energy Production',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 947, #950,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'LessThanEconStorageRatio', { 5.0, 1.00 } },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION TECH3' }},
           
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = {'ENERGYPRODUCTION TECH3'},
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },

    Builder {
        BuilderName = 'NC T3 Engineer Assist T3 Energy Production permanent',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1047, 
        
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.TECH3 * categories.ENERGYPRODUCTION}},
            { EBC, 'LessThanEconStorageRatio', { 5.0, 1.00 } },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION TECH3' }},
           
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = true,
                BeingBuiltCategories = {'ENERGYPRODUCTION TECH3'},
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
 

   
    
   
   
    Builder {
        BuilderName = 'NC T3 Engineer Assist Engineer',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 700,
        InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'STRUCTURE, EXPERIMENTAL' }},
       --
       { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = { 'STRUCTURE', 'EXPERIMENTAL' },
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
  
    Builder {
        BuilderName = 'NC T3 assit LOTS OF JUICE  to HELP',
        PlatoonTemplate = 'T3EngineerAssist',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 1000,
        InstanceCount = 20,
        
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 8000 } },
                
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC','EXPERIMENTAL'},
                time = 60,
            },
        }
    }, 
 
    
 
}

BuilderGroup {
    
    BuilderGroupName = 'NCemergencyenergy',
    BuildersType = 'EngineerBuilder',
      

    Builder {
        BuilderName = 'NC T2 Power Engineer low power',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 4999,
        DelayEqualBuildPlattons = {'Energy', 3},
       

        BuilderType = 'Any',
        BuilderConditions = {
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
            { EBC, 'LessThanEnergyTrend', { 200.0 } },
                     
         
			
        },
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',

                },
            }
        }
    },

    Builder {
        BuilderName = 'NC T3 emergency t3 energy build',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 5000,
        
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'LessThanEnergyTrend', { 600.0 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * categories.TECH3 * categories.ENERGYPRODUCTION } },
	
        },
        BuilderData = {
            DesiresAssist = false,
          
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                   

                },
            }
        }
    },

}

BuilderGroup {
    
    BuilderGroupName = 'NCemergencyenergymain',
    BuildersType = 'EngineerBuilder',

  
      

   

    
    Builder {
        BuilderName = 'NC t3 energy mainbase',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 5002,
     
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'LessThanEnergyTrend', { 600.0 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE * categories.TECH3  * categories.ENERGYPRODUCTION } },

     
    

                     
			
        },
        BuilderData = {
            DesiresAssist = false,
       
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                
              
                   

                },
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Mass Fab Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1100,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSFABRICATION' } },
     
                { EBC, 'LessThanEconStorageRatio', { 0.50, 2 } },
                { EBC, 'GreaterThanEconStorageCurrent', { 250, 10000 } }, 
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSPRODUCTION TECH3' } },
                
            },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                AdjacencyCategory = 'ENERGYPRODUCTION',
                BuildStructures = {
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                    'T3MassCreation',
                },
            }
        }
    },

}


BuilderGroup {
    BuilderGroupName = 'NCEngineerFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    # ============
    #    TECH 1
    # ============
    Builder {
        BuilderName = 'NC T1 Engineer Disband one time ',
        PlatoonTemplate = 'T1BuildEngineer',
     
        Priority = 99999,
        InstanceCount = 5,
        BuilderConditions = {
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.MOBILE * categories.ENGINEER * categories.TECH1 }},
           
          
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'NC T1 Engineer Disband continuous ',
        PlatoonTemplate = 'T1BuildEngineer',
        DelayEqualBuildPlattons = {'Engineer_continuous', 15},
        Priority = 900,
      
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech1' } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_continuous' }},
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {8, categories.ENGINEER * categories.TECH1}},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 2, categories.FACTORY }},
          
        },
        BuilderType = 'All',
    },
    
   
  
  
   
    Builder {
        BuilderName = 'NC T1 Engineer Disband - Filler 1',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 825, #800,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.MOBILE * categories.ENGINEER * categories.TECH1 }},
     
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 1, categories.FACTORY * (categories.TECH2 + categories.TECH3) }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech1' } },
		
            
        
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'All',
    },
    
    Builder {
        BuilderName = 'NC T1 Engineer Disband - Filler 2 ',
        PlatoonTemplate = 'T1BuildEngineer',
        Priority = 500,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 1, 'FACTORY TECH3' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY TECH3' }},
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {8, categories.ENGINEER * categories.TECH1}},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech1' } },
          
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'All',
    },
    
    # ============
    #    TECH 2
    # ============
    Builder {
        BuilderName = 'NC T2 Engineer Disband',
        PlatoonTemplate = 'T2BuildEngineer',
        Priority = 925,
        BuilderConditions = {
           
            { UCBC, 'EngineerLessAtLocation', { 'LocationType', 3, 'ENGINEER TECH2' }},
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'FACTORY TECH3' }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH2'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech2' } },
        },
        BuilderType = 'All',
    },
   
    Builder {
        BuilderName = 'NC T2 Engineer Disband - Filler 1 ',
        PlatoonTemplate = 'T2BuildEngineer',
        Priority = 800,
        BuilderConditions = {
            
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 1000 } },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {4, categories.ENGINEER * (categories.TECH2 + categories.TECH3 + categories.SUBCOMMANDER)}},
			
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH2'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech2' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'All',
    },
    
   
    
    # ============
    #    TECH 3
    # ============
    Builder {
        BuilderName = 'NC T3 Engineer Disband - Init',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 950,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { UCBC,'EngineerLessAtLocation', { 'LocationType', 3, 'ENGINEER TECH3' }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER } },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH3'} },
        },
        BuilderType = 'All',
    },
  
    Builder {
        BuilderName = 'NC T3 Engineer Disband - Filler 3',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 950,
        InstanceCount =3,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200} },
        
            { UCBC,'EngineerLessAtLocation', { 'LocationType', 20, 'ENGINEER TECH3' }},
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {10, categories.ENGINEER * (categories.TECH3 + categories.SUBCOMMANDER)}},
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER } },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH3'} },
          
            #{ UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'All',
    },
    
    Builder {
        BuilderName = 'NC T3 Engineer extra juice!!',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 2000,
        InstanceCount = 5,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500} },
            { EBC, 'GreaterThanEconStorageCurrent', { 25000, 10000 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 2.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * categories.TECH3  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {10, categories.ENGINEER * (categories.TECH3 + categories.SUBCOMMANDER)}},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH3'} },
                          
          
         
         
           
			{ SBC, 'NoRushTimeCheck', { 600 }},
         
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
       
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'NC T3 Engineer NO POWER!!!',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 10000,
        InstanceCount = 3,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500} },
            { EN, 'LessThanEconStorageCurrentNC', { 9999999, 1000 } },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {10, categories.ENGINEER * (categories.TECH3 + categories.SUBCOMMANDER)}},
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {1, categories.ENGINEER * (categories.TECH3 + categories.SUBCOMMANDER)}},
                          
          
         
         
           
			{ SBC, 'NoRushTimeCheck', { 600 }},
         
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
       
        },
        BuilderType = 'All',
    },

  

  
}



BuilderGroup {
    BuilderGroupName = 'NCACUBuilders',
    BuildersType = 'EngineerBuilder',
    
    # After initial
    # Build on nearby mass locations
    Builder {
        BuilderName = 'NC CDR Single T1Resource',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 0, #950, Probably unneeded, removed for testing
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 40, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1Resource',
                },
            }
        }
    },
    Builder {    	
        BuilderName = 'NC CDR T1 Power',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 875,
        BuilderConditions = {            
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.1 }},
            { SIBC, 'LessThanEconEfficiencyOverTime', { 2.0, 1.25 }},
            #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 1, 'ENGINEER TECH2, ENGINEER TECH3' } },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3'}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                #AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC CDR Base D',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 925,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 0, 'DEFENSE TECH1' }},
            { MABC, 'MarkerLessThanDistance',  { 'Rally Point', 50 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BaseTemplate = ExBaseTmpl,
                BuildClose = false,
                NearMarkerType = 'Rally Point',
                ThreatMin = -5,
                ThreatMax = 5,
                ThreatRings = 0,
                BuildStructures = {
                    'T1GroundDefense',
                    'T1AADefense',
                }
            }
        }
    },
    # CDR Assisting
    Builder {
        BuilderName = 'NC CDR Assist T2/T3 Power',
        PlatoonTemplate = 'CommanderAssistSorian',
        Priority = 700,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistLocation = 'LocationType',
				AssistRange = 100,
                BeingBuiltCategories = {'ENERGYPRODUCTION TECH3', 'ENERGYPRODUCTION TECH2'},
                time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC CDR Assist Engineer',
        PlatoonTemplate = 'CommanderAssistSorian',
        Priority = 500,
        BuilderConditions = {
       --
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ALLUNITS' } },
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
				AssistRange = 100,
                AssisteeType = 'Engineer',
                time = 60,
            },
        }
    },
    # CDR Assisting
    Builder {
        BuilderName = 'NC CDR Assist T4',
        PlatoonTemplate = 'CommanderAssistSorian',
        Priority = 750,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'EXPERIMENTAL' }},
			
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistLocation = 'LocationType',
				AssistRange = 100,
                BeingBuiltCategories = {'EXPERIMENTAL'},
                time = 60,
            },
        }
    },
  
    Builder {
        BuilderName = 'NC CDR Assist Factory',
        PlatoonTemplate = 'CommanderAssistSorian',
        Priority = 500,
        BuilderConditions = {
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
          
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' }},
       --
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
				AssistRange = 100,
                time = 60,
            },
        }
    },
    #Builder {
    #    BuilderName = 'NC CDR Assist Factory Upgrade Tech 2',
    #    PlatoonTemplate = 'CommanderAssistSorian',
    #    Priority = 800,
    #    BuilderConditions = {
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'TECH2 FACTORY' } },
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY TECH2, FACTORY TECH3' } },
    #       { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
  
    #   --
    #    },
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            AssisteeType = 'Factory',
    #            PermanentAssist = false,
    #            BeingBuiltCategories = {'FACTORY TECH2'},
    #            Time =20,
    #        },
    #    }
    #},
    #Builder {
    #    BuilderName = 'NC CDR Assist Factory Upgrade Tech 3',
    #    PlatoonTemplate = 'CommanderAssistSorian',
    #    Priority = 800,
    #    BuilderConditions = {
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'TECH3 FACTORY' } },
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'TECH3 FACTORY' } },
    #   --
    #        { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
   
    #    },
    #    BuilderType = 'Any',
    #    BuilderData = {
    #        Assist = {
    #            AssistLocation = 'LocationType',
    #            AssisteeType = 'Factory',
    #            PermanentAssist = false,
    #            BeingBuiltCategories = {'FACTORY TECH3',},
    #            time = 60,
    #        },
    #    }
    #},
   
}

BuilderGroup {
    BuilderGroupName = 'NCSCUUpgrades',
    BuildersType = 'EngineerBuilder',
	
    Builder {
        BuilderName = 'NC UEF SCU Upgrade',
        PlatoonTemplate = 'SCUEnhance',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1, 1}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY TECH2, FACTORY TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH3' }},
                { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0}},
				{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.05, 1.1 }},
				{ SBC, 'SCUNeedsUpgrade', { 'Pod' }},
               
            },
        Priority = 900,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'ResourceAllocation', 'Pod' },
        },
    },
	# Aeon
    Builder {
        BuilderName = 'NC Aeon SCU Upgrade',
        PlatoonTemplate = 'SCUEnhance',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2, 2}},
            {CF,'NoTeleportActivated',{}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY TECH2, FACTORY TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH3' }},
                { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.05, 1.1 }},
				{ SBC, 'SCUNeedsUpgrade', { 'EngineeringFocusingModule' }},
               
            },
        Priority = 900,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'ResourceAllocation', 'EngineeringFocusingModule' },
        },
    },
	# Cybran
    Builder {
        BuilderName = 'NC Cybran SCU Upgrade',
        PlatoonTemplate = 'SCUEnhance',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY TECH2, FACTORY TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH3' }},
                { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.05, 1.1 }},
				{ SBC, 'SCUNeedsUpgrade', { 'Switchback' }},
              
            },
        Priority = 900,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'ResourceAllocation', 'Switchback' },
        },
    },
	# Seraphim
    Builder {
        BuilderName = 'NC Seraphim SCU Upgrade',
        PlatoonTemplate = 'SCUEnhance',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4, 4}},
            {CF,'NoTeleportActivated',{}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY TECH2, FACTORY TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH3' }},
                { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.05, 1.1 }},
				{ SBC, 'SCUNeedsUpgrade', { 'EngineeringThroughput' }},
                
            },
        Priority = 900,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'EngineeringThroughput' },
        },
    },
    Builder {
        BuilderName = 'NC SCU teleport',
        PlatoonTemplate = 'SCUEnhance',
       
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2, 4}},
            { CF, 'CoinFlip', {111111} },
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', {500, 25000} }, 
           
            
				
                
            },
        Priority = 900,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'Teleporter' },
        },
    },
}
	
BuilderGroup {
    BuilderGroupName = 'NCACUUpgrades',
    BuildersType = 'EngineerBuilder', #'PlatoonFormBuilder',
    
    Builder {
        BuilderName = 'NC UEF CDR Upgrade AdvEng - Pods',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1}},
           
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
				{ SBC, 'CmdrHasUpgrade', { 'Shield', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'LeftPod', 'RightPod', 'AdvancedEngineering', 'T3Engineering' },
        },
    },
   
    Builder {
        BuilderName = 'NC UEF CDR Upgrade T3 Eng - Shields air exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1, 1}},
           
            { MIBC, 'GreaterThanGameTime', { 1100} },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},

				{ SBC, 'CmdrHasUpgrade', { 'Shield', false }},
                
            },
        Priority = 1100,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {  'RightPodRemove', 'Shield' },
        },
    },
   
    
    Builder {
        BuilderName = 'NC Aeon CDR Upgrade AdvEng - Resource - Crysalis',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				{ SBC, 'CmdrHasUpgrade', { 'HeatSink', false }},
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'AdvancedEngineering', 'T3Engineering' },
        },
    },
    
    Builder {
        BuilderName = 'NC Aeon CDR air exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2, 2}},
            { MIBC, 'GreaterThanGameTime', { 1100} },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'Shield', 'HeatSink' },
        },
    },
    
    # Cybran
    Builder {
        BuilderName = 'NC Cybran CDR Upgrade AdvEng - Laser Gen',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
				{ SBC, 'CmdrHasUpgrade', { 'MicrowaveLaserGenerator', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'StealthGenerator', 'AdvancedEngineering', 'T3Engineering' },
        },
    },
  
	
    # Seraphim
    Builder {
        BuilderName = 'NC Seraphim CDR Upgrade AdvEng - Resource - Crysalis',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				{ SBC, 'CmdrHasUpgrade', { 'AdvancedRegenAura', false }},
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'AdvancedEngineering', 'RegenAura', 'T3Engineering' },
        },
    },
  
    Builder {
        BuilderName = 'NC Seraphim CDR air exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1100} },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
                
            },
        Priority = 1100,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'AdvancedRegenAura' },
        },
    },
 
}


BuilderGroup {
    BuilderGroupName = 'NCEngineerMassBuildersHighPri',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1ResourceEngineer 150', #150
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
     
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            RequireTransport = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1ResourceEngineer 250',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 4,

        BuilderConditions = {
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'NC T1ResourceEngineer 450',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            RequireTransport = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },       
    Builder {
        BuilderName = 'NC T1ResourceEngineer 1500',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            #NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 T2Resource Engineer 250',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 T2Resource Engineer 1500',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 0, #875,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 T3Resource Engineer 250 range',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 975,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 T3Resource Engineer 1500 range',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 0, #850,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapMexNC , '<', categories.MASSEXTRACTION } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },



    

    Builder {
        BuilderName = 'NC T3 Engineer find unfinished',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 1000,
        
       
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'GreaterThanEconTrend', { 0, 0 } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.01, 1.00 } },
                { SBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC',' STRUCTURE ECONOMIC',' STRUCTURE'},
                time = 60,
            },
        },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCEngineerMassBuildersLowerPri',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1ResourceEngineer 150 Low',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 2,
        BuilderConditions = {
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH2, ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1ResourceEngineer 350 Low',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 700,
        InstanceCount = 2,
        BuilderConditions = {
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH2, ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 350, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1ResourceEngineer 1500 Low',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 650,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH2, ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            #NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T2ResourceEngineer 150 Low',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 1000,
        InstanceCount = 2,
        BuilderConditions = {
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },    
    Builder {
        BuilderName = 'NC T2 T2Resource Engineer 350 Low',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 850,
        InstanceCount = 1,
        BuilderConditions = {
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 350, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 T2Resource Engineer 1500 Low',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 750,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
                #{ UCBC, 'EngineerLessAtLocation', { 'LocationType', 4, 'ENGINEER TECH3'}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 T3Resource Engineer 350 range Low',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 850,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 350, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 T3Resource Engineer 1500 range Low',
        PlatoonTemplate = 'T2T3EngineerBuilderNC_FIREBASE',
        Priority = 750,
        BuilderConditions = {
        
            { MIBC, 'GreaterThanGameTime', { 600 } },
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1500, -500, 0, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    
}





BuilderGroup {
    BuilderGroupName = 'NCMassFabPause',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'Mass Fabricator Pause',
        PlatoonTemplate = 'MassFabsSorian',
        Priority = 300,
        InstanceCount = 3,
        BuilderConditions = {
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSFABRICATION}},
                { EBC, 'LessThanEconStorageRatio',  { 2.0, 1.0}},
            },
        BuilderType = 'Any',
        FormRadius = 10000,
    },
}




BuilderGroup {
    BuilderGroupName = 'NCT3Engineerassistmex',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC mex assist',
        PlatoonTemplate = 'AnyEngineerassistNC',
        
        Priority = 1000,
        InstanceCount = 5,
        
        BuilderType = 'Any',
        BuilderConditions = {
          
            { UCBC, 'BuildingGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * (categories.TECH3 + categories.TECH2)}},
            { EBC, 'GreaterThanEconStorageCurrent', { 1, 1000 } },
            { EBC, 'LessThanEconStorageRatio', { 1.0, 2 } },
                
            },
        BuilderData = {
            Assist ={
               
                    AssisteeType = 'Structure',
               
                    AssistLocation = 'LocationType',
                    BeingBuiltCategories = {'MASSEXTRACTION'},
                    Time = 60,
            },
        }
    }, 
    
Builder {
    BuilderName = 'NC commander mex assist',
    PlatoonTemplate = 'CommanderAssistSorian',
   
    Priority = 500,
    
    
    BuilderType = 'Any',
    BuilderConditions = {
    
        { UCBC, 'BuildingGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * (categories.TECH3 + categories.TECH2)}},
        { EBC, 'GreaterThanEconStorageCurrent', { 1, 1000 } },
        { EBC, 'LessThanEconStorageRatio', { 1.0, 2 } },
            
        },
    BuilderData = {
        Assist ={
                
                AssisteeType = 'Structure',
                
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'MASSEXTRACTION'},
                Time = 60,
        },
    }
}, 
}
   
BuilderGroup {
    BuilderGroupName = 'NCengineertowers',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Engineering Support UEF phase1',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower60', 45},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower60' }},
          
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 1,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support UEF phase2',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower30', 30},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower30' }},
           
            { EBC, 'GreaterThanEconStorageCurrent', { 8000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 1,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support UEF phase3',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower15', 15},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower15' }},
          
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 3000} },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 1,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support UEF bigly spendly',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower10', 10},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower10' }},
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 1.0 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 20000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 1,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
   
    
    Builder {
        BuilderName = 'NC Engineering Support Cybran phase1',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower60', 45},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower60' }},
        
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 3,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support Cybran phase2',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower30', 30},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower30' }},
            
            { EBC, 'GreaterThanEconStorageCurrent', { 8000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 3,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support Cybran phase3',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower15', 15},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower15' }},
           
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 3,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
    Builder {
        BuilderName = 'NC Engineering Support Cybran balls to the wall',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 1200,
        DelayEqualBuildPlattons = {'Engineer_tower10', 10},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3} },
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_tower10' }},
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 1.0 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 20000, 3000 } },  
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'STRUCTURE AIR FACTORY',
                BuildClose = true,
                FactionIndex = 3,
                BuildStructures = {
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                    'T2EngineerSupport',
                },
            }
        }
    },
}



BuilderGroup {
    BuilderGroupName = 'NC tower upgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC upgrade 1',
        PlatoonTemplate = 'T2Engineering1',
        Priority = 5000,
        InstanceCount = 10,
      
        BuilderConditions = {
           
            
            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 2000 } },  
            
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC upgrade 2',
        PlatoonTemplate = 'T2Engineering2',
        Priority = 5000,
        InstanceCount = 10,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 2000 } },  
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC upgrade 3',
        PlatoonTemplate = 'T2Engineering',
        Priority = 5000,
        InstanceCount = 10,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 2000 } },  
        },
        BuilderType = 'Any',
    },
}


