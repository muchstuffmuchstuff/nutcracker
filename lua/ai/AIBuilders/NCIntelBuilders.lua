#***************************************************************************
#*
#**  File     :  /lua/ai/SorianIntelBuilders.lua
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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')


BuilderGroup {
    BuilderGroupName = 'NClandscout',
    BuildersType = 'FactoryBuilder',
   
}


BuilderGroup {
    BuilderGroupName = 'NClandscoutbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC landscout behavior',
        BuilderConditions = {
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SCOUT * categories.LAND }},
        },
        PlatoonTemplate = 'T1LandScoutNC',
        Priority = 10,
        InstanceCount = 100,
        BuilderData = {
            UseCloak = false,
        },
        LocationType = 'LocationType',
        BuilderType = 'Any',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCAirScoutFactoryBuilders',
    BuildersType = 'FactoryBuilder',
   
     
    Builder {
        BuilderName = 'NC T1 AirScout',
        PlatoonTemplate = 'T1AirScout',
        Priority = 400,
        DelayEqualBuildPlattons = {'Scouts', 30},
        BuilderConditions = {

            { MIBC, 'GreaterThanGameTime', { 360 } },
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 3, [1024] = 6, [2048] = 8, [4096] = 8}, categories.SCOUT * categories.AIR}},
      
           
	
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH1} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
   
    

    Builder {
        BuilderName = 'NC T3 airscout',
        PlatoonTemplate = 'T3AirScout',
        Priority = 900, 
        DelayEqualBuildPlattons = {'Scouts', 15},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1220 } },
          
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 4, [1024] = 6, [2048] = 8, [4096] = 8}, categories.INTELLIGENCE * categories.AIR * categories.TECH3}},
			
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
 
}


BuilderGroup {
    BuilderGroupName = 'NCextrat3scout',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3 Air Scout extra',
        PlatoonTemplate = 'T3AirScout',
        Priority = 844, 
        DelayEqualBuildPlattons = {'Scouts', 15},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1220 } },
    
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 4, [1024] = 8, [2048] = 10, [4096] = 12}, categories.INTELLIGENCE * categories.AIR * categories.TECH3}},
		
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
           
        },
        BuilderType = 'Air',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCRadarEngineerBuilders',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1 Radar Engineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 980,
        BuilderConditions = {
    
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI ) * categories.STRUCTURE}},
            
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Radar',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Radar Engineer - T2',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 980,
        BuilderConditions = {
       
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI ) * categories.STRUCTURE}},
         
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 0, 500 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Radar',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Radar Engineer - T3',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 960,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI + categories.TECH2 ) * categories.STRUCTURE}},
        
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 0, 2000 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1Radar',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 Radar Engineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {

            { UCBC, 'EngineerLessAtLocation', { 'LocationType', 3, categories.ENGINEER - categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI ) * categories.STRUCTURE}},
            
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T2Radar',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Omni Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.TECH3 * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OMNI * categories.STRUCTURE } },
		
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI + categories.TECH2 ) * categories.STRUCTURE}},
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 0, 2000 } }, 
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.OMNI * categories.STRUCTURE, 'RADAR STRUCTURE' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3Radar',
                },
                Location = 'LocationType',
            }
        }
    },
}


BuilderGroup {
    BuilderGroupName = 'NCAirScoutbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T1 Air Scout',
        PlatoonTemplate = 'T1AirScoutFormSorian',
        Priority = 650,
    
        BuilderConditions = {
            { SBC, 'NoRushTimeCheck', { 0 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH1 } },
        },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 20,
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC T1 Air Scout together',
        PlatoonTemplate = 'T1AirScoutFormswarm',
        Priority = 650,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH1 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 1,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC T3 Air Scout',
        PlatoonTemplate = 'T3AirScoutFormSorian',
        Priority = 750,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH3 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        PlatoonAddPlans = { 'AirIntelToggle' },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 20,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T3 Air Scout together',
        PlatoonTemplate = 'T3AirScoutFormswarm',
        Priority = 751,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH3 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        PlatoonAddPlans = { 'AirIntelToggle' },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 1,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCRadarUpgradeBuildersMain',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T1 Radar Upgrade',
        PlatoonTemplate = 'T1RadarUpgrade',
        Priority = 850,
        BuilderConditions = {
        
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2 } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.TECH2, 'RADAR STRUCTURE' }},
            { EBC, 'GreaterThanEconStorageCurrent', { 0, 500 } }, 
            
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.RADAR * categories.STRUCTURE * categories.TECH2 } },
       --
        },
        BuilderType = 'Any',
        FormDebugFunction = function()
            local test = false
        end,
    },
    Builder {
        BuilderName = 'NC T2 Radar Upgrade',
        PlatoonTemplate = 'T2RadarUpgrade',
        Priority = 850,
        BuilderConditions = {
            { EBC, 'GreaterThanEconTrend',  { 0, 0}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.TECH3 * categories.ENERGYPRODUCTION } },
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OMNI * categories.STRUCTURE } },
            { EBC, 'GreaterThanEconStorageCurrent', { 0, 2000 } }, 
            
            
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.OMNI * categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.OMNI * categories.STRUCTURE, 'RADAR STRUCTURE' } },
        },
        BuilderType = 'Any',
    },
}









