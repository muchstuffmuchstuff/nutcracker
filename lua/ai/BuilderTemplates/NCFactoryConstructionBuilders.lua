#***************************************************************************
#*
#**  File     :  /lua/ai/SorianFactoryConstructionBuilders.lua
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
local IBC = '/lua/editor/InstantBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'

local ExtractorToFactoryRatio = 2.2


BuilderGroup {
    BuilderGroupName = 'NCmorequantumgate',
    BuildersType = 'EngineerBuilder',
  
    Builder { 

        BuilderName = 'NCmore quantum games',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 940,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 8, 'ENERGYPRODUCTION TECH3' }},
		
         
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.20, 1.20} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Gate' } },
            { IBC, 'BrainNotLowPowerMode', {} },
            
          
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
           
            }
        }
    },
}  


BuilderGroup {
BuilderGroupName = 'NCExtraLandFactory',
BuildersType = 'EngineerBuilder',
Builder {        
        BuilderName = 'NC T1 Land Factory Builder extra',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.20} },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { SBC, 'IsIsland', { false } },
          
            
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Land Factory Builder emergency',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.0} },
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { SBC, 'IsIsland', { false } },
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 30, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
          
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, 'LAND FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
}

BuilderGroup {
BuilderGroupName = 'NCExtraAirFactory',
BuildersType = 'EngineerBuilder',
Builder {        
        BuilderName = 'NC T1 Air Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
          
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Air Factory Builder emergency',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.20} },
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
}





BuilderGroup {
    BuilderGroupName = 'NCEngineerFactoryConstruction Balance',
    BuildersType = 'EngineerBuilder',
    # =============================
    #     Land Factory Builders
    # =============================
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder Balance',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 905,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
            #{ UCBC, 'FactoryRatioLessAtLocation', { 'LocationType', 'LAND', 'AIR' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {
        BuilderName = 'NC CDR T1 Land Factory Balance',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 905,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
            #{ UCBC, 'FactoryRatioLessAtLocation', { 'LocationType', 'LAND', 'AIR' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                },
            }
        }
    },
    
    # ============================
    #     Air Factory Builders
    # ============================
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder Balance',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 906,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
            { UCBC, 'FactoryRatioLessAtLocation', { 'LocationType', 'AIR', 'LAND' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

    Builder {
        BuilderName = 'NC CDR T1 Air Factory Balance',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 906,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
            { UCBC, 'FactoryRatioLessAtLocation', { 'LocationType', 'AIR', 'LAND' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                },
            }
        }
    },
}



BuilderGroup {
    BuilderGroupName = 'NCEngineerFactoryConstruction',
    BuildersType = 'EngineerBuilder',
    # =============================
    #     Land Factory Builders
    # =============================
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
    Builder {
        BuilderName = 'NC CDR T1 Land Factory',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                },
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder - Dead ACU',
        PlatoonTemplate = 'AnyEngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'COMMAND', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
    
    # ============================
    #     Air Factory Builders
    # ============================
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {
        BuilderName = 'NC CDR T1 Air Factory',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                },
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder - Dead ACU',
        PlatoonTemplate = 'AnyEngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.0, 1.1} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'COMMAND', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

    # ====================================== #
    #     Air Factories + Transport Need
    # ====================================== #
    Builder {
        BuilderName = 'NC T1 Air Factory Transport Needed',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        BuilderConditions = {
            { UCBC, 'EngineerLessAtLocation', { 'LocationType', 1, 'ENGINEER TECH3, ENGINEER TECH2' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'AIR FACTORY' } },
            { MIBC, 'ArmyNeedsTransports', {} },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { UCBC, 'HaveUnitRatio', { ExtractorToFactoryRatio, 'MASSEXTRACTION', '>=','FACTORY' } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

    # =============================
    #     Quantum Gate Builders
    # =============================
    Builder {
        BuilderName = 'NC T3 Gate Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950, #850,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH3' }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSPRODUCTION TECH3' }},
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 1, 'GATE TECH3 STRUCTURE' }},
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Gate' } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .85 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
}



