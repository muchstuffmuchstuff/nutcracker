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
    BuilderGroupName = 'NCtacticalattack',
    BuildersType = 'EngineerBuilder',
Builder {
    BuilderName = 'NC tml upclose',
    PlatoonTemplate = 'T2T3EngineerBuilderNC',
    Priority = 950,
    InstanceCount = 1,
    BuilderConditions = {

    
        {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T2StrategicMissile', categories.STRUCTURE - categories.MASSEXTRACTION} },
        { MIBC, 'GreaterThanGameTime', { 800 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 50, 5000 } },  
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
}