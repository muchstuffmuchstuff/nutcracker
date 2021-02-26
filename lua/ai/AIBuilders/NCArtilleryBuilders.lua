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
        PlatoonTemplate = 'T3EngineerBuilderNC',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 999,
      
	
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
          
            {CF, 'NoSateliteRush',{}},
            {CF, 'NoDukeNukem',{}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.EXPERIMENTAL * categories.ARTILLERY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ARTILLERY * (categories.TECH3 + categories.EXPERIMENTAL) } },
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE} },
            
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
		
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 15000 } },           
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
             
		
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
        PlatoonTemplate = 'T3EngineerBuilderNC',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 1050,
      
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1} },
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            {CF, 'NoSateliteRush',{}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            {CF, 'NoDukeNukem',{}},
          
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
          
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.EXPERIMENTAL * categories.ARTILLERY } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            
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
        BuilderName = 'NC T4 Artillery Engineer - Cybran',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {

            { MIBC, 'FactionIndex', {3} },
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { SBC, 'MapGreaterThan', { 500, 500 }},
      
            {CF, 'NoDukeNukem',{}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.EXPERIMENTAL * categories.ARTILLERY } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},

            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 15000 } },
         
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 2,
            Construction = {
            
           
            
             
                AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                BuildStructures = {
                    'T4LandExperimental2',
                },
                Location = 'LocationType',
            }
        }
    },

    Builder {
        BuilderName = 'NC T4 Artillery escalation cybran',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {

            { MIBC, 'FactionIndex', {3} },
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { SBC, 'MapGreaterThan', { 500, 500 }},
      
            {CF, 'NoDukeNukem',{}},
          
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.EXPERIMENTAL * categories.ARTILLERY } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ARTILLERY }},

            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 15000 } },
         
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 2,
            Construction = {
          
             
                AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                BuildStructures = {
                    'T4LandExperimental2',
                },
                Location = 'LocationType',
            }
        }
    },
	
    
   
}



BuilderGroup {
    BuilderGroupName = 'ncNukeBuildersEngineerBuilders',
    BuildersType = 'EngineerBuilder',
     Builder {
        BuilderName = 'nc T3 Nuke cybran',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        DelayEqualBuildPlattons = {'Nuke', 180},
        Priority = 990,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Nuke' }},
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {3}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            {CF,'NukeClearedtoBuild',{}},
            {CF,'EarlyAttackAuthorized',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8000, 10000 } }, 
      
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
				AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                BuildStructures = {
                    'T3StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'nc T3 Nuke aeon',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        DelayEqualBuildPlattons = {'Nuke', 180},
        Priority = 990,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Nuke' }},
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            {CF, 'NoRapidFireRush',{}},
            {CF,'NukeClearedtoBuild',{}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF, 'Noparagonrush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8000, 10000 } }, 
      
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
				AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                BuildStructures = {
                    'T3StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'nc T3 Nuke uef',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        DelayEqualBuildPlattons = {'Nuke', 180},
        Priority = 990,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Nuke' }},
            { MIBC, 'GreaterThanGameTime', {800 } },
            { MIBC, 'FactionIndex', {1}},
            {CF, 'NoSateliteRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            {CF,'NukeClearedtoBuild',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 10000 } }, 
    
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
        BuilderName = 'nc T3 Nuke continuation',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        DelayEqualBuildPlattons = {'Nuke', 180},
        Priority = 990,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Nuke' }},
            { MIBC, 'GreaterThanGameTime', {800 } },
            { MIBC, 'FactionIndex', {1,2, 3}},
            {CF,'NukeClearedtoBuild',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
          
        

           { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 40000, 10000 } }, 
      
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
				AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
                BuildStructures = {
                    'T3StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },

   
  
    
    
    
    

      Builder {
        BuilderName = 'NC Seraphim Exp Nuke Engineer',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 959,
		DelayEqualBuildPlattons = {'MobileExperimental_exp_nuke', 400},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_exp_nuke' }},
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 20000 } },
          
			
			
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
		
          
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
 
  
    
  
      
}

BuilderGroup {
    BuilderGroupName = 'NCartyinrange',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC arty',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Artillery_regular', 280},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Artillery_regular' }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'FactionIndex', {2,3,4}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoRapidFireRush',{}},
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
            
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},

            { EBC, 'GreaterThanEconStorageCurrent', { 10500, 10000 } }, 
           

        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            
            Construction = {
                BuildClose = true,
				AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
            
                BuildStructures = {
                    'T3Artillery',

                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC arty NO RANDOMIZER or SATELITE',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Artillery_regular', 280},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Artillery_regular' }},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'FactionIndex', {1}},
            
            {CF, 'NoSateliteRush',{}},
         
            {CF, 'NoDukeNukem',{}},
            {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
           
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},

            { EBC, 'GreaterThanEconStorageCurrent', { 10500, 10000 } }, 
           

        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
            
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
        Priority = 950,
        DelayEqualBuildPlattons = {'MobileExperimental_rapid', 280},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_rapid' }},
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            
            {CF, 'NoRapidFireRush',{}},
            {CF,'TeleportStrategyActivatedNotRunning',{}},
            {CF, 'NoDukeNukem',{}},
           
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { WRC,'CheckUnitRangeNC', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 35000, 15000 } },
 
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
    BuilderGroupName = 'NCT3Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Artillery',
        PlatoonTemplate = 'T3ArtilleryStructureSorian',
        Priority = 1,
        InstanceCount = 15,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.STRUCTURE * categories.ARTILLERY * categories.TECH3 } },
        },
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
        InstanceCount = 15,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.EXPERIMENTAL * categories.ARTILLERY } },
        },
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
        InstanceCount = 50,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.NUKE * categories.TECH3} },
        },
        BuilderType = 'Any',
       
    },
    Builder {
        BuilderName = 'NC T4 Nuke Silo',
        PlatoonTemplate = 'T4NukeSorian',
        Priority = 1,
        InstanceCount = 10,
        BuilderConditions = { 

            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.NUKE * categories.EXPERIMENTAL} },
        },
        BuilderType = 'Any',
    },
}