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
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')



local AIAddBuilderTable = import('/lua/ai/AIAddBuilderTable.lua')



BuilderGroup {
    BuilderGroupName = 'NCemergencybuildersearlygame',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1 Base AA',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
          
           { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'DEFENSE STRUCTURE ANTIAIR' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.AIR * categories.ANTIAIR * categories.TECH1 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 7, categories.FACTORY * categories.AIR - categories.SCOUT, 'Enemy'}},
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } }, 
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T1AADefense',
                  
                },
                Location = 'LocationType',
            }
        }
    },
   

       Builder {
        BuilderName = 'NC T1 being factory rushed - building t1d',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 950,

        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
         { SBC, 'LessThanGameTime', { 840 } },
         { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.MOBILE * categories.LAND - categories.SCOUT, 250 } },
    
       
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } }, 
            
      
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T1GroundDefense',
                    'T1GroundDefense',
                 

                  
                },
                Location = 'LocationType',
            }
        }
    },
Builder {
        BuilderName = 'NC T2 being factory rushed - building t2d',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 20, categories.TECH2 * categories.DIRECTFIRE * categories.DEFENSE }},
         { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.MOBILE * categories.LAND - categories.SCOUT, 250 } },
        
       
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } }, 
            
      
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                NearBasePatrolPoints = true,
                BuildClose = false,
                BuildStructures = {
                    'T2GroundDefense',
                    'T2GroundDefense',
                   

                  
                },
                Location = 'LocationType',
            }
        }
    },
   
    
    
  
    
  
      

    Builder {
        BuilderName = 'NC T1 being tml rushed - building TMD',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
           
            
          
         { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.TACTICALMISSILEPLATFORM, 260 } },
         { UCBC, 'UnitsLessAtLocation', { 'LocationType', 4, categories.ANTIMISSILE * categories.TECH2}},
       
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } }, 
            
      
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T2MissileDefense',
                  
                },
                Location = 'LocationType',
            }
        }
    },
    
  
Builder {
        BuilderName = 'NC T2 Base D Engineer - Light',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 925,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, 'DEFENSE TECH2 STRUCTURE' }},
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 30, categories.MOBILE * categories.LAND -categories.ENGINEER,  'Enemy' }},
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } }, 
            
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 1,
            Construction = {
                BuildClose = false,
                NearBasePatrolPoints = true,
                BuildStructures = {
                    'T2GroundDefense',
                   
					
                },
                Location = 'LocationType',
            }
        }
    },
     
}


  
BuilderGroup {
    BuilderGroupName = 'NCt4airemergencyreactionmainbase',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Base AA air exp spotted main',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 951,

        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 20, categories.STRUCTURE *(categories.TECH2 + categories.TECH3) * categories.ANTIAIR * categories.DEFENSE} },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * categories.TECH3 * categories.ANTIAIR} },
            
        
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
                   'T3AADefense',
 
                  
                },
                Location = 'LocationType',
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCt4airemergencyreaction',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Base AA air exp spotted',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,

        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 8, categories.STRUCTURE *(categories.TECH2 + categories.TECH3) * categories.ANTIAIR * categories.DEFENSE} },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * categories.TECH3 * categories.ANTIAIR} },
            
        
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                   'T3AADefense',
 'T3AADefense',
 
                  
                },
                Location = 'LocationType',
            }
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT2NavalDefenses',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2 Naval D Engineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 925,
        
        BuilderConditions = {
{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
            { UCBC, 'NavalDefensivePointNeedsStructure', { 'LocationType', 300, 'DEFENSE TECH2 ANTINAVY', 20, 3, 0, 1, 1, 'AntiSurface' } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 8, categories.DEFENSE} },
			
       --
            
            
           
            { UCBC, 'UnitCapCheckLess', { .7 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                NearMarkerType = 'Naval Defensive Point',
                MarkerRadius = 20,
                LocationRadius = 300,
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                ThreatType = 'AntiSurface',
                MarkerUnitCount = 3,
                MarkerUnitCategory = 'DEFENSE TECH2 ANTINAVY',
                BuildStructures = {
                    'T2NavalDefense',
'T2NavalDefense',
'T2NavalDefense',
'T2NavalDefense',
'T2MissileDefense',
'T2Artillery',
'T2MissileDefense',
'T2Artillery',
'T2MissileDefense',
'T2Artillery',
                },
            }
        }
    },

}


BuilderGroup {
    BuilderGroupName = 'NCTMLandTMDantinavy',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2MissileDefenseEng',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 799,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, 'ANTIMISSILE TECH2 STRUCTURE' }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2 }},
       --
           
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 1,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T2MissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },


    Builder {
        BuilderName = 'NC Light T2TML',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 799,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NAVAL * categories.MOBILE,  'Enemy' }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.TACTICALMISSILEPLATFORM}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
       --
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T2StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },
}




# Inside the base location defenses
BuilderGroup {
    BuilderGroupName = 'NCT1BaseDefenses',
    BuildersType = 'EngineerBuilder',
   
    Builder {
        BuilderName = 'NC T1 Base D AA Engineer - Response',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 4, 'DEFENSE ANTIAIR STRUCTURE'}},
			
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 1, 'Air' } },
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } },
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * categories.TECH1 * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T1AADefense',
                },
                Location = 'LocationType',
            }
        }
    },
    
}



BuilderGroup {
    BuilderGroupName = 'NCT2Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T2 TML Silo',
        PlatoonTemplate = 'T2TacticalLauncherNC',
        Priority = 1,
        InstanceCount = 5,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TACTICALMISSILEPLATFORM} },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Artillery',
        PlatoonTemplate = 'T2ArtilleryStructureSorian',
        Priority = 1,
        InstanceCount = 5,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ARTILLERY * categories.TECH2 * categories.STRUCTURE} },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT3BaseDefenses',
    BuildersType = 'EngineerBuilder',
  
    
    
  
    Builder {
        BuilderName = 'NC T3 Base D Engineer PD - Exp Response',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 1300,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'DEFENSE TECH3 DIRECTFIRE STRUCTURE'}},
		
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE  * (categories.TECH2 + categories.TECH3) * categories.DIRECTFIRE }},
            
          
			{ SBC, 'T4ThreatExists', {{'Land'}, categories.LAND}},
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T3GroundDefense',
                },
                Location = 'LocationType',
            }
        }
    },
   
}















BuilderGroup {
    BuilderGroupName = 'NCShieldUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T2 Shield Cybran 1',
        PlatoonTemplate = 'T2Shield1',
        Priority = 5,
        
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
         
           
       --
           
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 2',
        PlatoonTemplate = 'T2Shield2',
        Priority = 5,
        
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
          
          
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 3',
        PlatoonTemplate = 'T2Shield3',
        Priority = 5,
      
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
           
      
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 4',
        PlatoonTemplate = 'T2Shield4',
        Priority = 5,
        
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
          
           
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield UEF Seraphim',
        PlatoonTemplate = 'T2Shield',
        Priority = 5,
        
        BuilderConditions = {
      
            { MIBC, 'FactionIndex', {1, 4}},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
   
           
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT3Shields',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Shield D enemy arty spotted',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Shield' }},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { MIBC, 'FactionIndex', {1, 2, 4}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.STRUCTURE * categories.TECH3 * categories.ARTILLERY, 'Enemy'}},
		
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
          
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
    
            
       --
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, STRUCTURE EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Shield D exp spotted',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Shield' }},
            { SBC, 'GreaterThanGameTime', { 1000 } },
            { MIBC, 'FactionIndex', {1, 2, 4}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.MOBILE, 'Enemy'}},
		
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
          
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
    
            
       --
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, STRUCTURE EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Shield D Engineer Factory Adj Cybran',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Shield' }},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { MIBC, 'FactionIndex', {3}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 16, categories.SHIELD * categories.TECH2 * categories.STRUCTURE} },
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
            
            
       --
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, STRUCTURE EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T2ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
}





# Anti nuke defenses
BuilderGroup {
    BuilderGroupName = 'NCT3NukeDefenses',
    BuildersType = 'EngineerBuilder',
   
    Builder {
        BuilderName = 'NC T3 Anti-Nuke 1:1',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 1500,
        DelayEqualBuildPlattons = {'Antinuke', 20},
		InstanceCount = 10,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Antinuke' }},
            { SBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NUKE * categories.STRUCTURE, 'Enemy'}},
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE} },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'ENERGYPRODUCTION',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },

    Builder {
        BuilderName = 'NC T3 Anti-Nuke 2:2',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 1500,
        DelayEqualBuildPlattons = {'Antinuke', 20},
		InstanceCount = 10,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Antinuke' }},
            { SBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NUKE * categories.STRUCTURE, 'Enemy'}},
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE} },
           
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'ENERGYPRODUCTION',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    
   

   
    Builder {
        BuilderName = 'NC T3 Engineer Assist Anti-Nuke Emerg',
        PlatoonTemplate = 'T3EngineerAssistNC',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},

			{ SIBC, 'EngineerNeedsAssistance', { true, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'ANTIMISSILE TECH3 STRUCTURE'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Anti-Nuke Emerg 2',
        PlatoonTemplate = 'T3EngineerAssistNC',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },

			{ SIBC, 'EngineerNeedsAssistance', { true, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'ANTIMISSILE TECH3 STRUCTURE'},
                Time = 60,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT3NukeDefenseBehaviors',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Anti Nuke Silo',
        PlatoonTemplate = 'T3AntiNuke',
        Priority = 5,
        InstanceCount = 20,
        BuilderConditions = {
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCexpansionstandardefense',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2 standard',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 930,
        BuilderConditions = {
          
         
           { UCBC, 'UnitsLessAtLocation',  { 'LocationType', 8, categories.STRUCTURE * categories.TECH2 * (categories.DIRECTFIRE + categories.ANTIAIR) } },
           { EBC, 'GreaterThanEconStorageCurrent', { 100, 5000 } },    
       --
       
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T2AADefense',
                    'T2GroundDefense',
                  
                },
                Location = 'LocationType',
            }
        }
    },
}






