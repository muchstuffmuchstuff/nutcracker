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
    Builder {
        BuilderName = 'nc first landscout',
        PlatoonTemplate = 'T1LandScout',
        
        Priority = 9999999,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 300} },
            { SBC, 'MapLessThan', {1000, 1000} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.LAND * categories.SCOUT }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.LAND } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY }},
          
           
            { SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'nc ratio land scout spam',
        PlatoonTemplate = 'T1LandScout',
        DelayEqualBuildPlattons = {'Scouts', 30},
        Priority = 775,
        BuilderConditions = {
            
            { SBC, 'MapLessThan', {3000, 3000} },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LAND * categories.SCOUT }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.LAND } },
          
           
            { SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Land',
    },
   
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
        Priority = 800,
        DelayEqualBuildPlattons = {'Scouts', 15},
        BuilderConditions = {
           
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { MIBC, 'GreaterThanGameTime', { 320 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.TECH1 * categories.AIR * categories.INTELLIGENCE } },
		
      
           
	
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', {  2, categories.INTELLIGENCE * categories.AIR * categories.TECH1} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
   
   
    

    Builder {
        BuilderName = 'NC T3 airscout',
        PlatoonTemplate = 'T3AirScout',
        Priority = 900, 

        DelayEqualBuildPlattons = {'Scouts', 3},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Scouts' }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.TECH3 * categories.AIR * categories.INTELLIGENCE } },
			
			
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
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
        DelayEqualBuildPlattons = {'Radar', 15},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Radar' }},
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
        DelayEqualBuildPlattons = {'Radar', 15},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Radar' }},
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
        DelayEqualBuildPlattons = {'Radar', 15},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Radar' }},
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
        DelayEqualBuildPlattons = {'Radar', 15},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Radar' }},
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
        DelayEqualBuildPlattons = {'Radar', 15},
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'CheckBuildPlattonDelay', { 'Radar' }},
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
        BuilderName = 'NC T1 Air Scout solo',
        PlatoonTemplate = 'T1AirScoutflyaround',
        Priority = 650,
    
        BuilderConditions = {
            { SBC, 'NoRushTimeCheck', { 0 }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH1 } },
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH1 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 1,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC T3 Air Scout solo',
        PlatoonTemplate = 'T3AirScoutflyaround',
        Priority = 750,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH3 } },
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.MOBILE * categories.SCOUT * categories.TECH3 } },
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









