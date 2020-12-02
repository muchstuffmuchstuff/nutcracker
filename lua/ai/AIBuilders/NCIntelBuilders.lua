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



BuilderGroup {
    BuilderGroupName = 'NCAirScoutFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 AirScout initial',
        PlatoonTemplate = 'T1AirScout',
        Priority = 500, #600,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.AIR}},
			{ SBC, 'LessThanGameTime', { 300 } },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY }},
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.TECH2 * categories.FACTORY * categories.AIR } },
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.FACTORY * categories.TECH1 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.AIR } },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T1 AirScout',
        PlatoonTemplate = 'T1AirScout',
        Priority = 600, #600,
        BuilderConditions = {
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.AIR}}, #1
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 3, [1024] = 3, [2048] = 4, [4096] = 8}, categories.SCOUT * categories.AIR}},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.TECH3 * categories.FACTORY * categories.AIR } },
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.FACTORY * categories.TECH1 } },
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 2, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.AIR } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
   
    Builder {
        BuilderName = 'NC T2 AirScout',
        PlatoonTemplate = 'T2AirScout',
        Priority = 700, #501,
        BuilderConditions = {
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.AIR}}, #1
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 3, [1024] = 3, [2048] = 3, [4096] = 8}, categories.SCOUT * categories.AIR}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.TECH3 * categories.FACTORY * categories.AIR } },
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.FACTORY * categories.TECH2 } },
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 2, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.SCOUT * categories.AIR } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'NC T3 airscout',
        PlatoonTemplate = 'T3AirScout',
        Priority = 900, #701,
        BuilderConditions = {
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.INTELLIGENCE * categories.AIR * categories.TECH3 }}, #1
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 4, [1024] = 6, [2048] = 8, [4096] = 8}, categories.INTELLIGENCE * categories.AIR * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T3 Air Scout - Lower Pri',
        PlatoonTemplate = 'T3AirScout',
        Priority = 701, #700,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.INTELLIGENCE * categories.AIR * categories.TECH3 }}, #3
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 4, [512] = 6, [1024] = 8, [2048] = 10, [4096] = 12}, categories.INTELLIGENCE * categories.AIR * categories.TECH3}},
			{ SBC, 'MapGreaterThan', { 500, 500 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.05 }},
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
        BuilderConditions = {

			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 4, [1024] = 8, [2048] = 10, [4096] = 12}, categories.INTELLIGENCE * categories.AIR * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.INTELLIGENCE * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
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
            { SIBC, 'GreaterThanEconIncome',  { 0.5, 10 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.0 }},
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
         
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1 }},
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
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI ) * categories.STRUCTURE}},
        
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1 }},
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
            { UCBC, 'EngineerLessAtLocation', { 'LocationType', 1, categories.ENGINEER - categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, ( categories.RADAR + categories.OMNI ) * categories.STRUCTURE}},
            
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OMNI * categories.STRUCTURE } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
          
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
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
        },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 2,
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC T1 Air Scout together',
        PlatoonTemplate = 'T1AirScoutFormswarm',
        Priority = 650,
        BuilderConditions = {
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
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        PlatoonAddPlans = { 'AirIntelToggle' },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 1,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T3 Air Scout together',
        PlatoonTemplate = 'T3AirScoutFormswarm',
        Priority = 751,
        BuilderConditions = {
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
        Priority = 300,
        BuilderConditions = {
        
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2 } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.TECH2, 'RADAR STRUCTURE' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.25 }},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.RADAR * categories.STRUCTURE * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        FormDebugFunction = function()
            local test = false
        end,
    },
    Builder {
        BuilderName = 'NC T2 Radar Upgrade',
        PlatoonTemplate = 'T2RadarUpgrade',
        Priority = 400,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 9, 500}},
		
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OMNI * categories.STRUCTURE } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.25 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.OMNI * categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.OMNI * categories.STRUCTURE, 'RADAR STRUCTURE' } },
        },
        BuilderType = 'Any',
    },
}



BuilderGroup {
    BuilderGroupName = 'NCRadarUpgradeBuildersMain',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T1 Radar Upgrade',
        PlatoonTemplate = 'T1RadarUpgrade',
        Priority = 200,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 2, 100 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2 } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.TECH2, 'RADAR STRUCTURE' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.25 }},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.RADAR * categories.STRUCTURE * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        FormDebugFunction = function()
            local test = false
        end,
    },
    Builder {
        BuilderName = 'NC T2 Radar Upgrade',
        PlatoonTemplate = 'T2RadarUpgrade',
        Priority = 300,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 9, 500}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OMNI * categories.STRUCTURE } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.25 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.OMNI * categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.OMNI * categories.STRUCTURE, 'RADAR STRUCTURE' } },
        },
        BuilderType = 'Any',
    },
}



BuilderGroup {
    BuilderGroupName = 'NCCounterIntelBuilders',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2 Counter Intel Near Factory',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 0,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH2}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.COUNTERINTELLIGENCE * categories.TECH2}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T2RadarJammer',
                },
                Location = 'LocationType',
            }
        }
    },
}

