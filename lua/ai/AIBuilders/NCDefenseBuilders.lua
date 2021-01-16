#***************************************************************************
#*
#**  File     :  /lua/ai/SorianDefenseBuilders.lua
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.0 }},
            
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
InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
         { SBC, 'LessThanGameTime', { 840 } },
         { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.MOBILE * categories.LAND - categories.SCOUT, 250 } },
    
       
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.0 }},
            
      
         
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.0 }},
            
      
         
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
        BuilderName = 'NC uef land exp spotted',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 7, categories.TACTICALMISSILEPLATFORM}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.uel0401, 'Enemy'}},
         
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
  
       --
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 2, 'DEFENSE' } },
            
      
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                NearBasePatrolPoints = true,
                BuildClose = false,
                BuildStructures = {
                    'T2StrategicMissile',
                   

                  
                },
                Location = 'LocationType',
            }
        }
    },
    
    
    Builder {
        BuilderName = 'NC other land exp spotted',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 950,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 2, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 30, categories.DIRECTFIRE * (categories.TECH2 + categories.TECH3) * categories.DEFENSE }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL LAND', 'Enemy'}},
         
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
       
       --
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 2, 'DEFENSE' } },
            
         
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                NearBasePatrolPoints = true,
                BuildClose = false,
                BuildStructures = {
                    'T2GroundDefense',
                    'T2Artillery',
                    'T2GroundDefense',
                   

                  
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC other land fatboy spotted',
        PlatoonTemplate = 'T2T3EngineerBuilderNC',
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 2, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 6, categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.uel0401, 'Enemy'}},
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 1000 } },  
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 2, 'DEFENSE' } },
       
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                NearBasePatrolPoints = true,
                BuildClose = false,
                BuildStructures = {
                    'T2StrategicMissile',
                    
                   

                  
                },
                Location = 'LocationType',
            }
        }
    },
  
       Builder {
        BuilderName = 'NC T1 being factory rushed - building TML',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { SBC, 'LessThanGameTime', { 840 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * (categories.TECH2 + categories.TECH3) * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
          
         { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.FACTORY + categories.ENGINEER, 250 } },
         { UCBC, 'UnitsLessAtLocation', { 'LocationType', 6, categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE}},
       
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.0 }},
            
      
         
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T2StrategicMissile',
                    'T2StrategicMissile',
                  
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
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH2' }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 30, categories.MOBILE * categories.LAND -categories.ENGINEER,  'Enemy' }},
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
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
    BuilderGroupName = 'NCt4airemergencyreaction',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Base AA air exp spotted',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.05 }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 20, categories.STRUCTURE *(categories.TECH2 + categories.TECH3) * categories.ANTIAIR * categories.DEFENSE} },
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
        InstanceCount = 5,
        BuilderConditions = {
{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
            { UCBC, 'NavalDefensivePointNeedsStructure', { 'LocationType', 300, 'DEFENSE TECH2 ANTINAVY', 20, 3, 0, 1, 1, 'AntiSurface' } },
			
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
           
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
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'ANTIMISSILE TECH2 STRUCTURE' }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'ENERGYPRODUCTION TECH2' }},
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
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.TACTICALMISSILEPLATFORM}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.05 }},
            
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
        BuilderName = 'NC T1 Base D Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 0,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'DEFENSE STRUCTURE'}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, 'ENGINEER TECH2'}},
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
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
                    'T1GroundDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Base D AA Engineer - Response',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 4, 'DEFENSE ANTIAIR STRUCTURE'}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, 'ENGINEER TECH2'}},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 1, 'Air' } },
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
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
    Builder {
        BuilderName = 'NC T1 Base D PD Engineer - Response',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 4, 'DEFENSE DIRECTFIRE STRUCTURE'}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, 'ENGINEER TECH2'}},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 1, 'Land' } },
       --
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * categories.TECH1 * categories.STRUCTURE - categories.SHIELD - categories.ANTIMISSILE } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                BuildStructures = {
                    'T1GroundDefense',
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
        InstanceCount = 1000,
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Artillery',
        PlatoonTemplate = 'T2ArtilleryStructureSorian',
        Priority = 1,
        InstanceCount = 1000,
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
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, 'DEFENSE TECH3 DIRECTFIRE STRUCTURE'}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
       --
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE  * (categories.TECH2 + categories.TECH3) * categories.DIRECTFIRE }},
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, categories.DEFENSE * categories.TECH3 * categories.STRUCTURE * (categories.ANTIAIR + categories.DIRECTFIRE) } },
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











# Shields
BuilderGroup {
    BuilderGroupName = 'NCT2Shields',
    BuildersType = 'EngineerBuilder',
  
}

BuilderGroup {
    BuilderGroupName = 'NCT2ShieldsExpansion',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2 Shield D Engineer Near Factory Expansion',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 925,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
           
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SHIELD * categories.TECH2 * categories.STRUCTURE}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.SHIELD * categories.TECH2 * categories.STRUCTURE }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
       --
       
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, ENERGYPRODUCTION EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
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

BuilderGroup {
    BuilderGroupName = 'NCShieldUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T2 Shield Cybran 1',
        PlatoonTemplate = 'T2Shield1',
        Priority = 5,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
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
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
          
          
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 3',
        PlatoonTemplate = 'T2Shield3',
        Priority = 5,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
           
      
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 4',
        PlatoonTemplate = 'T2Shield4',
        Priority = 5,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3, 3}},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
          
           
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield UEF Seraphim',
        PlatoonTemplate = 'T2Shield',
        Priority = 5,
        InstanceCount = 2,
        BuilderConditions = {
      
            { MIBC, 'FactionIndex', {1, 4}},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
   
           
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
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
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
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
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
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
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Shield', 6},
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { MIBC, 'FactionIndex', {3}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.99 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 16, categories.SHIELD * categories.TECH2 * categories.STRUCTURE} },
            
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.2 }},
            
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
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 0, #945,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH3}},
			
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
        
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
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
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 0, #945,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH3}},
			
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
        
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 2, 'NUKE SILO STRUCTURE', 'Enemy'}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Anti-Nuke 3:3',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 0, #945,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH3}},
			
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 4, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
        
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 3, 'NUKE SILO STRUCTURE', 'Enemy'}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Anti-Nuke 4:4',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 0, #945,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH3}},
			
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
        
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 4, 'NUKE SILO STRUCTURE', 'Enemy'}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
 
    Builder {
        BuilderName = 'NC T3 Anti-Nuke Engineer - Emerg',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1301,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
           
		
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
       
       --
      
            
         
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 8,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
		
       --
           
            
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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { SBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			
			
       --
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.05, 1.2 }},
            
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
           { EBC, 'GreaterThanEconStorageCurrent', { 100, 1000 } },    
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






