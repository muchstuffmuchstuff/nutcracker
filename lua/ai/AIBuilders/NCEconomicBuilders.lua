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
local Tech3MassExtractortoTech2ExtractorRatio = 1.0
local StoragetoMassExtractorRatio = 4.0
local Tech3MextoTech2Mex_lots_of_potential = 0.90




BuilderGroup {
    BuilderGroupName = 'NCEngineerEnergyBuilders',
    BuildersType = 'EngineerBuilder',

   
    Builder {
        BuilderName = 'NC T1 Power Engineer 2',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1050,
      
     
        
        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 150} },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
        
		
			
        },
 
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                BuildClose = true,
                AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
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
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
        
		
			
        },
 
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = false,
            Construction = {
                BuildClose = true,
                AdjacencyCategory = 'FACTORY',
                BuildStructures = {
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
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
				{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
			
            },
        InstanceCount = 1,
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
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
    
   
}






BuilderGroup {
    BuilderGroupName = 'NCT1EngineerBuilders',
    BuildersType = 'EngineerBuilder',
    # =====================================
    #     T1 Engineer Resource Builders
    # =====================================
    
    Builder {
        BuilderName = 'NC T1 Hydrocarbon Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 980,
        InstanceCount = 2,
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.MASSEXTRACTION } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.ENERGYPRODUCTION } },
              
				{ SBC, 'CanBuildOnHydroLessThanDistance', { 'LocationType', 200, -500, 0, 0, 'AntiSurface', 1 }},
                { SBC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 200}},
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
            { UCBC, 'HaveUnitRatio', { StoragetoMassExtractorRatio, categories.MASSSTORAGE, '<=', categories.MASSEXTRACTION} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 3, categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3)}},
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
            { UCBC, 'CheckBuildPlattonDelay', { 'Energy_storage' }},
            { MIBC, 'GreaterThanGameTime', { 800} },
            
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
    #        { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' } },
    #        
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
    
    Builder {
        BuilderName = 'NC T1 Engineer Assist Engineer',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
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
    #        { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
    #        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH1}},
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.FACTORY * categories.TECH2 }},
    #       
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
        InstanceCount = 5,
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
    #      { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
    #        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' }},
    #        
    #        
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
            { UCBC, 'HaveUnitRatio', { StoragetoMassExtractorRatio, categories.MASSSTORAGE, '<=', categories.MASSEXTRACTION} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 3, categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3)}},
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
        BuilderName = 'NC Engineer Assist T3 Factory Upgrade',
        PlatoonTemplate = 'AnyEngineerassistNC',
        Priority = 975,
        InstanceCount = 5,
        DelayEqualBuildPlattons = {'Help', 7},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Help' }},
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' }},
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 1000 } },
           
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
        PlatoonTemplate = 'T3EngineerAssistNC',
        Priority = 947,
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
        BuilderName = 'NC Engineer Assist Factory good income',
        PlatoonTemplate = 'AnyEngineerassistNC',
        Priority = 500,
        InstanceCount = 15,
        BuilderType = 'Any',
        DelayEqualBuildPlattons = {'Help', 7},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Help' }},
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'MOBILE' } },
         
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
           
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = { 'AIR'},
                AssisteeType = 'Factory',
                time = 120,
            },
        }
    },

    Builder {
        BuilderName = 'NC T3 Engineer Assist T3 Energy Production permanent',
        PlatoonTemplate = 'T3EngineerAssistNC',
        Priority = 1047, 
        
        BuilderConditions = {
            
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
        BuilderName = 'NC Preset Hellp',
        PlatoonTemplate = 'PresetAssistNC',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 1100,
        InstanceCount = 35,
        DelayEqualBuildPlattons = {'Help', 20},
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Help' }},
            { MIBC, 'GreaterThanGameTime', { 600} },
            
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 15000 } },
                
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC','EXPERIMENTAL'},
                time = 200,
            },
        }
    }, 
 
    
    
 
}

BuilderGroup {
    
    BuilderGroupName = 'NCemergencyenergy',
    BuildersType = 'EngineerBuilder',
      

    
   
    Builder {
        BuilderName = 'NC T3 emergency t3 energy build',
        PlatoonTemplate = 'T3EngineerBuilderNC',
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
                DesiresAssist = false,
                BuildClose = true,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                   

                },
            }
        }
    },
    Builder {
        BuilderName = 'NC t3 energy mapcontrol',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 5002,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'LessThanEnergyTrend', { 400.0 } },
            { UCBC, 'HaveUnitRatio', { Tech3MextoTech2Mex_lots_of_potential, categories.MASSEXTRACTION * categories.TECH3, '<=', categories.MASSEXTRACTION * categories.TECH2 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE * categories.TECH3  * categories.ENERGYPRODUCTION } },
	
        },
        BuilderData = {
            DesiresAssist = false,
       
            Construction = {
                BuildClose = true,
                DesiresAssist = false,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
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
        BuilderName = 'NC T2 Power Engineer first',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 5000,
        
       

        BuilderType = 'Any',
        BuilderConditions = {
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
            
                     
         
			
        },
        BuilderData = {
            DesiresAssist = true,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2EnergyProduction',
                    'T2EnergyProduction',

                },
            }
        }
    },

    Builder {
        BuilderName = 'NC T2 Power Engineer low power',
        PlatoonTemplate = 'NCT2T3Engineertagteam',
        Priority = 4999,
       
       

        BuilderType = 'Any',
        BuilderConditions = {
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
			{ SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION *  categories.TECH3}},
            
                     
         
			
        },
        BuilderData = {
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2EnergyProduction',
                    'T2EnergyProduction',
                    'T2EnergyProduction',
                  

                },
            }
        }
    },
    Builder {
        BuilderName = 'NC t3 energy mainbase first',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 5003,
     
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION *  categories.TECH3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * categories.TECH3  * categories.ENERGYPRODUCTION } },
          
	
        },
        BuilderData = {
            DesiresAssist = false,
       
            Construction = {
                BuildClose = true,
                DesiresAssist = true,
                BuildStructures = {
                    'T3EnergyProduction',
            
                
              
                   

                },
            }
        }
    },
    Builder {
        BuilderName = 'NC t3 energy mainbase',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 5002,
     
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'LessThanEnergyTrend', { 600.0 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE * categories.TECH3  * categories.ENERGYPRODUCTION } },
	
        },
        BuilderData = {
            DesiresAssist = false,
       
            Construction = {
                BuildClose = true,
                DesiresAssist = false,
                BuildStructures = {
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                    'T3EnergyProduction',
                
              
                   

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
        BuilderName = 'NC T1 Engineer Disband one time small ',
        PlatoonTemplate = 'NCengineer_startup',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        Priority = 99999,
        BuilderConditions = {
           
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.MOBILE * categories.ENGINEER }},
           
          
        },
        BuilderType = 'All',
    },
  
    Builder {
        BuilderName = 'NC T1 Engineer Disband second batch ',
        PlatoonTemplate = 'NCengineer_secondbatch',
        Priority = 99999,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.MOBILE * categories.ENGINEER }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.MOBILE * categories.TECH1 - categories.ENGINEER }},
           
          
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'NC T1 Engineer Disband third batch ',
        PlatoonTemplate = 'NCengineer_thirdbatch',
        Priority = 99999,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.MOBILE * categories.ENGINEER }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE - categories.ENGINEER - categories.TRANSPORTFOCUS - categories.SCOUT}},
           
          
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'NC T1 Engineer Disband continuous  ',
        PlatoonTemplate = 'T1BuildEngineer',
        DelayEqualBuildPlattons = {'Engineer_continuous', 15},
        Priority = 900,
      
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Engineer_continuous' }},
            
            
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech1' } },
            
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {6, categories.ENGINEER * categories.TECH1}},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 4, categories.FACTORY }},
          
        },
        BuilderType = 'All',
    },
    
 
    
    # ============
    #    TECH 2
    # ============
    Builder {
        BuilderName = 'NC T2 Engineer Disband',
        PlatoonTemplate = 'NCengineer2_startup',
        Priority = 925,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * (categories.TECH2 + categories.TECH3) }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.ENGINEER * (categories.TECH2 + categories.TECH3) }},
            
        },
        BuilderType = 'All',
    },
   
    Builder {
        BuilderName = 'NC T2 Engineer Disband - Filler 1 ',
        PlatoonTemplate = 'T2BuildEngineer',
        Priority = 800,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.TECH3 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 1000 } },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {6, categories.ENGINEER * (categories.TECH2 + categories.TECH3 + categories.SUBCOMMANDER)}},
			
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'ENGINEER TECH2'} },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech2' } },
           
        },
        BuilderType = 'All',
    },
    
   
    
    # ============
    #    TECH 3
    # ============
    Builder {
        BuilderName = 'NC T3 Engineer Disband - Init',
        PlatoonTemplate = 'NCengineer3_startup',
        Priority = 950,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * (categories.TECH2 + categories.TECH3) }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.ENGINEER * categories.TECH3 }},
            
        },
        BuilderType = 'All',
    },
  
    Builder {
        BuilderName = 'NC T3 Engineer Disband - Filler 3',
        PlatoonTemplate = 'T3BuildEngineer',
        Priority = 950,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300} },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {10, categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER}},
            { EBC, 'GreaterThanEconStorageCurrent', {300, 15000 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH3 - categories.SUBCOMMANDER  } },
            { UCBC, 'EngineerCapCheck', { 'LocationType', 'Tech3' } },
            
          
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
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 20000 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * categories.TECH3  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {10, categories.ENGINEER * (categories.TECH3 + categories.SUBCOMMANDER)}},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ENGINEER * categories.TECH3} },

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
            { SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)}},
            { EBC, 'LessThanEnergyTrend', { 200.0 } },
         
			
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
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 0, categories.DEFENSE * categories.TECH1 }},
            { MABC, 'MarkerLessThanDistance',  { 'Rally Point', 50 }},
            
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
            { EBC, 'LessThanEnergyTrend', { 200.0 } },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' }},
            
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
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
            
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
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 1000 } },
            
            
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
           
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
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
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * (categories.TECH2 + categories.TECH3) } },
    #     { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
  
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
    #        { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * categories.TECH3 } },
    #       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
    #        
   
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
        BuilderName = 'NC SCU teleport upgrade aeon',
        PlatoonTemplate = 'UpgradeNC',
        DelayEqualBuildPlattons = {'Teleupppy', 15},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Teleuppy' }},
            { SBC, 'SCUNeedsUpgrade', { 'StabilitySuppressant' }},
            
            { MIBC, 'FactionIndex', {2}},
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 15000 } },
            {CF,'TeleportStrategyActivated',{}},
            { MIBC, 'GreaterThanGameTime', { 600} },
            
            
            },
        Priority = 6000,
        InstanceCount = 20,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'StabilitySuppressant','Teleporter' },
        },
    },
    Builder {
        BuilderName = 'NC SCU teleport upgrade sera',
        PlatoonTemplate = 'UpgradeNC',
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'Teleupppy', 15},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Teleuppy' }},
            { SBC, 'SCUNeedsUpgrade', { 'Shield' }},
            
            { MIBC, 'FactionIndex', {4}},
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 15000 } },
            {CF,'TeleportStrategyActivated',{}},
            { MIBC, 'GreaterThanGameTime', { 600} },
            
            
            },
        Priority = 6000,
        BuilderType = 'Any',
        BuilderData = {
            Enhancement = { 'Shield','Teleporter' },
        },
    },
}



BuilderGroup {
    BuilderGroupName = 'NCACUUpgrades',
    BuildersType = 'EngineerBuilder', #'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NC UEF CDR Upgrade smaller map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 300} },
            { SBC, 'CmdrHasUpgrade', { 'HeavyAntiMatterCannon', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				
				
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'HeavyAntiMatterCannon' },
        },
    },
    
    Builder {
        BuilderName = 'NC UEF CDR Upgrade larger map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				
				
                
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
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'Shield', false }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * (categories.AIR + categories.ORBITALSYSTEM) , 'Enemy'}},
				
                
            },
        Priority = 1100,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {  'Shield','ShieldGeneratorField' },
        },
    },
   
    
    Builder {
        BuilderName = 'NC Aeon CDR Upgrade smaller map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 300} },
            { SBC, 'CmdrHasUpgrade', { 'HeatSink', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				
				
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'HeatSink', 'CrysalisBeam'},
        },
    },

    Builder {
        BuilderName = 'NC Aeon CDR Upgrade larger map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {1500, 4000 } }, 
				
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'AdvancedEngineering', 'Shield', 'T3Engineering','ShieldHeavy'},
        },
    },
    
    Builder {
        BuilderName = 'NC Aeon CDR air exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 600} },
            { SBC, 'CmdrHasUpgrade', { 'ShieldHeavy', false }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * (categories.AIR + categories.ORBITALSYSTEM) , 'Enemy'}},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'Shield','Heavy Personal Shield Generator'},
            
        },
    },
    
    # Cybran
    Builder {
        BuilderName = 'NC Cybran CDR Upgrade smaller map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3}},
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 300} },
            { SBC, 'CmdrHasUpgrade', { 'CoolingUpgrade', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
			
			
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'CoolingUpgrade',},
        },
    },
    Builder {
        BuilderName = 'NC Cybran CDR Upgrade larger map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {1500, 4000 } }, 
			
			
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'AdvancedEngineering', 'StealthGenerator', 'T3Engineering'}
        },
    },

    Builder {
        BuilderName = 'NC Cybran CDR exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * (categories.AIR + categories.ORBITALSYSTEM) , 'Enemy'}},
			
			
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'AdvancedEngineering', 'StealthGenerator', 'T3Engineering','CloakingGenerator'}
        },
    },

 
    
	
    # Seraphim
    Builder {
        BuilderName = 'NC Seraphim CDR Upgrade smaller map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 300} },
            { SBC, 'CmdrHasUpgrade', { 'RateOfFire', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				
				
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'RateOfFire'},
        },
    },

    Builder {
        BuilderName = 'NC Seraphim CDR Upgrade larger map',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { SBC, 'CmdrHasUpgrade', { 'AdvancedRegenAura', false }},
            { EBC, 'GreaterThanEconStorageCurrent', {25, 125 } }, 
				
				
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'AdvancedEngineering', 'T3Engineering',}
        },
    },
  
    Builder {
        BuilderName = 'NC Seraphim CDR air exp spotted',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SBC, 'CmdrHasUpgrade', { 'DamageStabilization', false }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * (categories.AIR + categories.ORBITALSYSTEM) , 'Enemy'}},
                
            },
        Priority = 1100,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = {'DamageStabilization', 'DamageStabilizationAdvanced'},
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
     
        InstanceCount = 6,
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
            NeedGuard = false,
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
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
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
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
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
        Priority = 875,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
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
        Priority = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
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
        BuilderName = 'NC Engineer find unfinished',
        PlatoonTemplate = 'AnyEngineerassistNC',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 1000,
        InstanceCount = 10,
        DelayEqualBuildPlattons = {'Help', 7},
       
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Help' }},
            { MIBC, 'GreaterThanGameTime', { 600} },
           
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 10000 } },
                { SBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC','EXPERIMENTAL'},
                time = 100,
            },
        },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC Engineer assist',
        PlatoonTemplate = 'AnyEngineerassistNC',
        Priority = 1200,
        InstanceCount = 100,
        DelayEqualBuildPlattons = {'Help', 7},
       
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Help' }},
            { MIBC, 'GreaterThanGameTime', { 600} },
           
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 10000 } },
                { SBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC','EXPERIMENTAL'},
                time = 200,
            },
        },
        BuilderType = 'Any',
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
          
            { EBC, 'GreaterThanEconStorageCurrent', { 6000, 3000 } },  
            
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
          
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 3000} },  
            
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
        
            { EBC, 'GreaterThanEconStorageCurrent', { 6000, 3000 } },  
            
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
           
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 3000 } },  
            
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
      
      
        BuilderConditions = {
           
            
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },  
            
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC upgrade 2',
        PlatoonTemplate = 'T2Engineering2',
        Priority = 5000,
        
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },  
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC upgrade 3',
        PlatoonTemplate = 'T2Engineering',
        Priority = 5000,
    
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },  
        },
        BuilderType = 'Any',
    },
}


