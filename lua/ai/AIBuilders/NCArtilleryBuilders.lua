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
        Priority = 999,
      
	
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { MIBC, 'FactionIndex', {1} },
            {CF, 'NoSateliteRush',{}},
      
        
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE} },
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ARTILLERY + categories.EXPERIMENTAL) }},
		
            { EBC, 'GreaterThanEconStorageCurrent', { 8000, 15000 } },           
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
        Priority = 1050,
      
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            {CF, 'NoSateliteRush',{}},
       --
          
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
          
      
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ARTILLERY }},
            
           ---  

            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 15000 } },
                    
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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 950,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
          
{ EBC, 'GreaterThanEconStorageCurrent', { 15, 100 } },
            
       --
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistRange = 150,
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'EXPERIMENTAL STRUCTURE'},
                Time = 500,
            },
        }
    },
    Builder {
        BuilderName = 'NC T4EngineerAssistBuildHLRA escalation',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1200,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
           ---  
{ EBC, 'GreaterThanEconStorageCurrent', { 10000, 100 } },
           
       --
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistRange = 150,
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'EXPERIMENTAL STRUCTURE'},
                Time = 500,
            },
        }
    },
}



BuilderGroup {
    BuilderGroupName = 'ncNukeBuildersEngineerBuilders',
    BuildersType = 'EngineerBuilder',
     Builder {
        BuilderName = 'nc T3 Nuke',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        
        Priority = 990,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {2, 3}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.NUKE + categories.ARTILLERY * categories.EXPERIMENTAL) }},
           { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 4000, 10000 } }, 
           
           
          
			
       --
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
        BuilderName = 'nc T3 Nuke uef',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        
        Priority = 990,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {1}},
            {CF, 'NoSateliteRush',{}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            
            
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.STRUCTURE * categories.NUKE } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.NUKE + categories.ARTILLERY * categories.EXPERIMENTAL) }},
           { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } }, 
            
           
           
          
			
       --
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
        BuilderName = 'nc T3 Nuke EXTRA CASH',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        
        Priority = 990,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {2, 3}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE  * (categories.NUKE + categories.ARTILLERY * categories.EXPERIMENTAL) }},
           { UCBC, 'HaveGreaterThanUnitsWithCategory', {4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 10000 } }, 
           
           
          
			
       --
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
        BuilderName = 'nc T3 Nuke uef EXTRA CASH',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        
        Priority = 990,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {2,3}},
            {CF, 'NoSateliteRush',{}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            
            
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.STRUCTURE  * (categories.NUKE + categories.ARTILLERY * categories.EXPERIMENTAL) }},
           { UCBC, 'HaveGreaterThanUnitsWithCategory', {4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 10000 } }, 
           
           
          
			
       --
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
           ---  

            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 15000 } },
            
       --
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
        BuilderName = 'NC Assist Build t3 juice',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1150,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
           ---  

            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 15000 } },
            
       --
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
            { SBC, 'MapGreaterThan', { 500, 500 }},
           
       --
            
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 20000 } },
          
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
			{ SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY)}},
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
        BuilderName = 'NC Seraphim Exp Nuke ESCALATION',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 989,
		InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
           
       --
            
            { EBC, 'GreaterThanEconStorageCurrent', { 45000, 20000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.STRUCTURE}},
			
		
       
		
          
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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 999,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
          

            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 15000 } },
       --
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
        BuilderName = 'NC arty ',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1001,
        {  DelayEqualBuildPlattons = 'Artillery', 80},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'FactionIndex', {2,3,4}},
           
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
           
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.ARTILLERY - categories.TECH2}},

            { EBC, 'GreaterThanEconStorageCurrent', { 5500, 10000 } }, 
           

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
        BuilderName = 'NC arty NO RANDOMIZER',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1001,
        {  DelayEqualBuildPlattons = 'Artillery', 80},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'FactionIndex', {1}},
            {CF, 'NoSateliteRush',{}},
           
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
           
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.ARTILLERY - categories.TECH2}},

            { EBC, 'GreaterThanEconStorageCurrent', { 5500, 10000 } }, 
           

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
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1500 } },
       --
            #{ SIBC, 'T4BuildingCheck', {} },
          
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 *  (categories.xab2307 + categories.ARTILLERY ) * categories.STRUCTURE}},
            { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL}},
         
            
          
{ EBC, 'GreaterThanEconStorageCurrent', { 15000, 10000 } }, 
			
           
      
            
           
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
       --
            #{ SIBC, 'T4BuildingCheck', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.TECH3 *  (categories.xab2307 + categories.ARTILLERY ) * categories.STRUCTURE}},
            { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
    { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6, categories.STRUCTURE * (categories.NUKE + categories.ARTILLERY) * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
     
{ EBC, 'GreaterThanEconStorageCurrent', { 15000, 10000 } }, 

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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1001,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
         
       --
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
    Builder {
        BuilderName = 'NC t3 assist arty - big and juicy eco',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1201,
        InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
         
       --
            { EBC, 'GreaterThanEconStorageCurrent', { 45000, 15000 } },
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
        BuilderName = 'NC t2 assist arty - big and juicy eco',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1201,
        InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
         
       --
            { EBC, 'GreaterThanEconStorageCurrent', { 45000, 15000 } },
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
        BuilderName = 'NC t1 assist arty - big and juicy eco',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 1201,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
         
       --
            { EBC, 'GreaterThanEconStorageCurrent', { 45000, 15000 } },
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