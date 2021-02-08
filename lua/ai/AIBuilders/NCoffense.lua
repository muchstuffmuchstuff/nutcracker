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
    Priority = 1100,
    InstanceCount = 10,
    BuilderConditions = {

    
        {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T2StrategicMissile', categories.STRUCTURE - categories.MASSEXTRACTION} },
        { MIBC, 'GreaterThanGameTime', { 600 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 8, 3000 } },  
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
    BuilderName = 'NC starting location tml ',
    PlatoonTemplate = 'EngineerBuilderSorian',
    Priority = 1350,
    InstanceCount = 2,
    
   
    BuilderConditions = {
      
        {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T2StrategicMissile', categories.STRUCTURE - categories.MASSEXTRACTION} },
        { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.TACTICALMISSILEPLATFORM}},
        { MIBC, 'GreaterThanGameTime', { 240} },
       

       
    
        { SBC, 'NoRushTimeCheck', { 0 }},
 
    },
    BuilderType = 'Any',
    BuilderData = {
        RequireTransport = true,
        Construction = {
            BuildClose = false,
            BaseTemplate = ExBaseTmpl,
            ExpansionBase = true,
            NearMarkerType = 'Start Location',
            LocationRadius = 1000,
            LocationType = 'LocationType',
            ThreatMin = -1000,
            ThreatMax = 30,
            ThreatRings = 0,
            ThreatType = 'StructuresNotMex',
            BuildStructures = {                    
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',

            }               
        },
        NeedGuard = true,
    }
}, 
Builder {
    BuilderName = 'NC offensive expansion tml',
    PlatoonTemplate = 'T2T3EngineerBuilderNC',
    Priority = 1350,
    InstanceCount = 3,
  
    BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', { 500 } },
        { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
        

        { SBC, 'NoRushTimeCheck', { 0 }},
        { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.TACTICALMISSILEPLATFORM}},
        {WRC, 'CheckUnitRangeNC', { 'LocationType', 'T2StrategicMissile', categories.STRUCTURE - categories.MASSEXTRACTION} },
     
        
    },
    BuilderType = 'Any',
    BuilderData = {
        RequireTransport = true,
        Construction = {
            BuildClose = false,
            BaseTemplate = ExBaseTmpl,
            ExpansionBase = true,
            NearMarkerType = 'Expansion Area',
            LocationRadius = 1000,
            LocationType = 'LocationType',
            ThreatMin = -1000,
            ThreatMax = 0,
            ThreatRings = 2,
            ThreatType = 'StructuresNotMex',
            BuildStructures = {
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',
                'T2StrategicMissile',
                
            }
        },
        NeedGuard = true,
    }
},

}