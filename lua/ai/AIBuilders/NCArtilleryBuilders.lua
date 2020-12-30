#***************************************************************************
#*
#**  File     :  /lua/ai/AIArtilleryBuilders.lua
#**
#**  Summary  : Default artillery/nuke/etc builders for skirmish
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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')




BuilderGroup {
    BuilderGroupName = 'NCExperimentalArtillery',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T4 Artillery Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 980,
      
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'FactionIndex', {1} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'T4BuildingCheck', {} },
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE, 1 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY + categories.EXPERIMENTAL) * categories.TECH3 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 11, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25000, 15000 } },           
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                 
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T4 Artillery escalation',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 980,
      
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'FactionIndex', {1} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'T4BuildingCheck', {} },
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE, 1 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
      
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 7, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconTrend', { 50, 3000 } }, 
                    
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                 
                },
                Location = 'LocationType',
            }
        }
    },
	
    Builder {
        BuilderName = 'NC T4EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 950,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
            
            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 15000 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistRange = 150,
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'EXPERIMENTAL STRUCTURE'},
                Time = 300,
            },
        }
    },
}



BuilderGroup {
    BuilderGroupName = 'ncNukeBuildersEngineerBuilders',
    BuildersType = 'EngineerBuilder',
     Builder {
        BuilderName = 'nc T3 Nuke Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { EBC, 'GreaterThanEconTrend', { 60, 3000 } },  
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH3 } },
           
          
			
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
        BuilderName = 'nc T3 Nuke Engineer other income situation',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { EBC, 'GreaterThanEconTrend', { 40, 3000 } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 6000, 8000 } },
           
           
           
          
			
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
        BuilderName = 'nc T3 Nuke lots of cash',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 999,
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
        
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconTrend', { 80, 3000 } },  
			
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
        BuilderName = 'nc T3 Nuke lots of endless cash',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 999,
		InstanceCount = 1,
        BuilderConditions = {
            
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
           
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 10, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 60000, 20000 } },
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.ENERGYPRODUCTION * categories.TECH3 } },
       
			
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
        BuilderName = 'nc T3 Nuke escalation',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 999,
		InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
            { EBC, 'GreaterThanEconTrend', { 150, 3000 } },  
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
           
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 7, categories.ENERGYPRODUCTION * categories.TECH3 } },
       
			
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
        BuilderName = 'NC Assist Build t3',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 950,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
            { EBC, 'GreaterThanEconTrend', { 40, 3000 } },  
            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 15000 } },
            
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 150,
                BeingBuiltCategories = {'STRUCTURE NUKE'},
                Time = 300,
            },
        }
    },
    
    

      Builder {
        BuilderName = 'NC Seraphim Exp Nuke Engineer',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 959,
		InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
           
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'T4BuildingCheck', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 20000 } },
          
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
			{ SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.ENERGYPRODUCTION * categories.TECH3 } },
		
          
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC Seraphim T4 Nuke NutCracker',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 999,
		InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
         
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'T4BuildingCheck', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 20000 } },
          
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
			{ SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.NUKE }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.ENERGYPRODUCTION * categories.TECH3 } },
		
          
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                },
                Location = 'LocationType',
            }
        }
    },
    
  
      Builder {
        BuilderName = 'NC Assist Build t4',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 999,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
            { EBC, 'GreaterThanEconTrend', { 40, 3000 } },  
            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 15000 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 150,
                BeingBuiltCategories = {'EXPERIMENTAL'},
                Time = 300,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCartyinrange',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC arty in range',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1200,
        {  DelayEqualBuildPlattons = 'Artillery', 40},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.xab2307}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY + categories.EXPERIMENTAL) * categories.TECH3 }},
            
        
            { EBC, 'GreaterThanEconTrend', { 50, 3000 } },  
           
          

		
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
    
    Builder {
        BuilderName = 'NC arty in range LOTS OF JUICE',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1200,
        {  DelayEqualBuildPlattons = 'Artillery', 40},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            {WRC,'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.xab2307 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 7, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 2300, 15000 } },
         
          
            { EBC, 'GreaterThanEconTrend', { 80, 3000 } },  
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

    
 
    Builder {
        BuilderName = 'NC Rapid T3 Artillery in range',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 998,
        {  DelayEqualBuildPlattons = 'Artillery', 40},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'T4BuildingCheck', {} },
          
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 *  (categories.xab2307 + categories.ARTILLERY ) * categories.STRUCTURE}},
            { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL}},
         
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 1.0}},
            { EBC, 'GreaterThanEconTrend', { 50, 3000 } },  
			
           
      
            
           
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
        BuilderName = 'NC Rapid T3 Artillery in range bunkerbuster',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1201,
        {  DelayEqualBuildPlattons = 'Artillery', 40},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'T4BuildingCheck', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.TECH3 *  (categories.xab2307 + categories.ARTILLERY ) * categories.STRUCTURE}},
            { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
    { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6, categories.STRUCTURE * (categories.NUKE + categories.ARTILLERY) * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
           
         
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 1.0}},
            { EBC, 'GreaterThanEconTrend', { 50, 3000 } },  
		
         
          
            
           
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
        BuilderName = 'NC T3EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1001,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
         
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 15000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
                Time = 220,
            },
        }
    },
}
    

BuilderGroup {
    BuilderGroupName = 'NCT3Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Artillery',
        PlatoonTemplate = 'T3ArtilleryStructureSorian',
        Priority = 1,
        InstanceCount = 1000,
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT4Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T4 Artillery',
        PlatoonTemplate = 'T4ArtilleryStructureSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 1,
        InstanceCount = 1000,
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}



BuilderGroup {
    BuilderGroupName = 'NCNukebehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Nuke Silo',
        PlatoonTemplate = 'T3NukeNC',
        Priority = 1,
        InstanceCount = 10,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T4 Nuke Silo',
        PlatoonTemplate = 'T4NukeSorian',
        Priority = 1,
        InstanceCount = 10,
        BuilderType = 'Any',
    },
}