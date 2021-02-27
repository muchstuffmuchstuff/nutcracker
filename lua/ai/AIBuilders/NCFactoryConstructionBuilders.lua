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
local IBC = '/lua/editor/InstantBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')
local factoryratio = 1.4
local MaxCapFactoryNC = 0.02




BuilderGroup {
    BuilderGroupName = 'NCExpansionExtraFactory',
    BuildersType = 'EngineerBuilder',
Builder {        
        BuilderName = 'NC T1 Land Factory Builder extra',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 10},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH1 * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatio', {factoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },
            { EBC, 'GreaterThanEconStorageCurrent', { 350,1000 } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
   	
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                    'T1LandFactory',
                    'T1LandFactory',
                    
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 10},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1,  categories.TECH1 * categories.FACTORY * categories.AIR} },
            { UCBC, 'HaveUnitRatio', {factoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.AIR } },  
            { EBC, 'GreaterThanEconStorageCurrent', { 350,1000 } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
  	
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                    'T1AirFactory',
                    'T1AirFactory',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
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
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 10},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }}, 
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY * categories.LAND } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            { UCBC, 'HaveUnitRatio', {factoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
  
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder - Dead ACU',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 10000,

        BuilderConditions = {

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
        BuilderName = 'NC T1 Air Factory Builder regular',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 10},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factories' }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH1 * categories.FACTORY * categories.AIR } },
            { UCBC, 'HaveUnitRatio', {factoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.AIR } },  
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
     
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

    Builder {
       
        BuilderName = 'NC Gate Engineer first',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 950,
        DelayEqualBuildPlattons = {'Gate', 40},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Gate' }},
            { MIBC, 'FactionIndex', {1, 2, 3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
            { EBC, 'GreaterThanEconStorageCurrent', { 4000, 15000 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.GATE * categories.TECH3 * categories.STRUCTURE}},       
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
}



