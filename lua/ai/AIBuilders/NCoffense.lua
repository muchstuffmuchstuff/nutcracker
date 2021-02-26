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
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')


BuilderGroup {
    BuilderGroupName = 'NCadaptiveoffense',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC tml upclose',
    PlatoonTemplate = 'T2T3EngineerBuilderNC',
    Priority = 1100,
   
    BuilderConditions = {

    
        { WRC, 'EnemyInTMLRangeNC', { 'LocationType', true } },
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
        { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
        { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.TACTICALMISSILEPLATFORM}},

    },
    BuilderType = 'Any',
    BuilderData = {
        RequireTransport = true,
        NumAssistees = 1,
        Construction = {
        
            BuildClose = false,
            BuildStructures = {
                'T2StrategicMissile',

            },
            Location = 'LocationType',
        }
    }
},
Builder {
    BuilderName = 'nc T3 Nuke adaptive offense',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    DelayEqualBuildPlattons = {'Nuke', 180},
    Priority = 1400,
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'Nuke' }},
        { MIBC, 'GreaterThanGameTime', {600 } },
        { SBC, 'MapGreaterThan', { 500, 500 }},
        {CF,'EarlyAttackAuthorized',{}},
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 1, categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3, 'Enemy'}},
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
       
  
    },
    BuilderType = 'Any',
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderData = {
        MinNumAssistees = 6,
        Construction = {
            BuildClose = false,
            AdjacencyCategory = 'ENERGYPRODUCTION TECH3',
            BuildStructures = {
                'T2EngineerSupport',
                'T2EngineerSupport',
                'T3StrategicMissile',
            },
            Location = 'LocationType',
        }
    }
},

Builder {
    BuilderName = 'nc Air Exp1 adaptive offense',
    PlatoonTemplate = 'T3EngineerBuilderNC',
    Priority = 1300,
    DelayEqualBuildPlattons = {'MobileExperimental_air', 120},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_air' }},
        { MIBC, 'FactionIndex', {2,3,4}},
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { MIBC, 'GreaterThanGameTime', { 600} },
        {CF,'EarlyAttackAuthorized',{}},
        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
    },
    BuilderType = 'Any',
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderData = {
        MinNumAssistees = 2,
        Construction = {
            BuildClose = true,
        
            BuildStructures = {
                'T2EngineerSupport',
                'T2EngineerSupport',
                'T4AirExperimental1',
            },
            Location = 'LocationType',
        }
    }
},


Builder {
    BuilderName = 'Nc Satelite adaptive',
    PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
    Priority = 1050,
    DelayEqualBuildPlattons = {'MobileExperimental_satelite_continuation', 180},
    BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_satelite_continuation' }},
        { MIBC, 'FactionIndex', {1}},
        { SBC, 'MapGreaterThan', { 500, 500 }},
        { MIBC, 'GreaterThanGameTime', { 600} },
        {CF,'EarlyAttackAuthorized',{}},
        { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3, 'Enemy'}},
        { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 + categories.EXPERIMENTAL + categories.NUKE * categories.STRUCTURE }},
    },
    BuilderType = 'Any',
    PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
    BuilderData = {
        MinNumAssistees = 6,
        Construction = {
            BuildClose = true,
            #T4 = true,
         
            BuildStructures = {
                'T2EngineerSupport',
                'T2EngineerSupport',
                'T4SatelliteExperimental',
            },
            Location = 'LocationType',
        }
    }
},
}


    



    
    
    
