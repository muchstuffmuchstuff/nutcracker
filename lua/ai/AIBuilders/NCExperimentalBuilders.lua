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
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local SUtils = import('/lua/AI/sorianutilities.lua')

local AIAddBuilderTable = import('/lua/ai/AIAddBuilderTable.lua')


BuilderGroup {
    BuilderGroupName = 'ncMobileAirExperimentalbehavior',
    BuildersType = 'PlatoonFormBuilder',
    
Builder {
    BuilderName = 'nc T4 Exp Air attack command focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_commandfocus',

    Priority = 1500,
    InstanceCount = 5,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{1}},
        { MIBC, 'FactionIndex', {2,3,4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'COMMAND',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack land focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_landfocus',

    Priority = 1500,
    InstanceCount = 5,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{2}},
        { MIBC, 'FactionIndex', {2,3,4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'LAND MOBILE',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack energy focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_energyfocus',

    Priority = 1500,
    InstanceCount = 5,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = { 
        {CF,'AirExpRandomizer',{3}},
        { MIBC, 'FactionIndex', {2,3,4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },

        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'ENERGYPRODUCTION TECH3',
                                  'ENERGYSTORAGE',
                                  'ENERGYPRODUCTION TECH2',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack mex focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_mexfocus',

    Priority = 1500,
    InstanceCount = 5,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{4}},
        { MIBC, 'FactionIndex', {2,3,4}},
        { MIBC, 'GreaterThanGameTime', { 1000} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'MASSEXTRACTION TECH3',
        'MASSEXTRACTION TECH2',
        'MASSEXTRACTION TECH1',

},
},

}



BuilderGroup {
    BuilderGroupName = 'NCMobileAirExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	
  
    Builder {
        BuilderName = 'nc Air Exp1 sera and cyb get r done',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 1300,
      
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'FactionIndex', {3,4}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            { MIBC, 'GreaterThanGameTime', { 800} },
            {CF, 'NoDukeNukem',{}},
            {CF,'TeleportStrategyNotRunning',{}},
            {CF,'ExpClearedtoBuild',{}},
            {CF, 'NoNukeRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 0, 10000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS - categories.INSIGNIFICANTUNIT } },
       
        },
        BuilderType = 'Any',
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
    Builder {
        BuilderName = 'nc Air exp aeon get r done',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 1300,
     
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},

            { MIBC, 'FactionIndex', {2}},
           
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 800} },
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF, 'NoDukeNukem',{}},
            {CF,'TeleportStrategyNotRunning',{}},
            {CF,'ExpClearedtoBuild',{}},
            {CF, 'Noparagonrush',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF, 'NoNukeRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 0, 10000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS - categories.INSIGNIFICANTUNIT } },
   
   
          
       
        },
        BuilderType = 'Any',
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

BuilderGroup {
    BuilderGroupName = 'ncMobileLandExperimentalbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'nc T4 Exp Land attack',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NClandexperimentalattack',
    
        Priority = 1500,
        InstanceCount = 5,
        FormRadius = 250,
        AggressiveMove = false,
        SearchRadius = 80000,
        BuilderType = 'Any',
        BuilderConditions = {
            
          
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL LAND' } },
			
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        UseMoveOrder = true,
        PrioritizedCategories = { 

            'COMMAND',
        }, 
       
    },
 

}



BuilderGroup {
    BuilderGroupName = 'NCMobileLandExperimental',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Land Exp1 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        

        InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
          
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { MIBC, 'FactionIndex', {2, 3, 4}},
            {CF, 'NoDukeNukem',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF,'TeleportStrategyNotRunning',{}},
            {CF,'ExpClearedtoBuild',{}},
            {CF, 'NoNukeRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            
         
          
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
           
          
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
          
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
         
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
    Builder {
        BuilderName = 'NC Land Exp1 water map',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 990,
       

        InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
          
            { MIBC, 'FactionIndex', { 1,3}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            
            { SBC, 'IsIslandMap', { true } },
            {CF,'ExpClearedtoBuild',{}},
            {CF, 'NoDukeNukem',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF, 'NoNukeRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
         
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
    BuilderGroupName = 'NCEconomicExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Econ Exper Engineer',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 950,
		InstanceCount = 1,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF,'ExpClearedtoBuild',{}},
         
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.ENERGYPRODUCTION * categories.TECH3}},

        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
		
            --- 
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
    
   
}

BuilderGroup {
    BuilderGroupName = 'NC Satelite',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'Nc Satelite standard',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 951,
        DelayEqualBuildPlattons = {'biglyspendly', 60},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'biglyspendly' }},
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 800} },
            {CF,'ExpClearedtoBuild',{}},
            {CF,'NukeandExperimentalClearedtoBuild',{}},
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoSateliteRush',{}},
            {CF, 'NoNukeRush',{}},
            {CF,'EarlyAttackAuthorized',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
   
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
    
    
    
   
}

BuilderGroup {
    BuilderGroupName = 'NC Satelite Behavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Orbital behavior',
        PlatoonTemplate = 'NC Orbital',
        PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 800,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.ORBITALSYSTEM} },
            
        },
        FormRadius = 100,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            SearchRadius = 6000,
            PrioritizedCategories = { 'MASSEXTRACTION' },
        },
    },
}

