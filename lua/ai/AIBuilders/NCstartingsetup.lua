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

----standard build and randomizer builds
BuilderGroup {
    BuilderGroupName = 'NC Initial ACU Builders',
    BuildersType = 'EngineerBuilder',
    
   
    Builder {
        BuilderName = 'NC No randomizer cannot path T1 enabled',
        PlatoonAddBehaviors = { 'CommanderBehaviorSorian', },
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 999999,
        BuilderConditions = {
           
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } }, 
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
        
                { IBC, 'NotPreBuilt', {}},
            },
        InstantCheck = true,
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
           
                    'T1AirFactory',
					'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
					'T1EnergyProduction',
                    'T1EnergyProduction',                 
'T1AADefense',
'T1EnergyProduction',
'T1AADefense',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1AirFactory',



					
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC No randomizer can path',
        PlatoonAddBehaviors = { 'CommanderBehaviorSorian', },
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 999999,
        BuilderConditions = {
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
          
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
        
                { IBC, 'NotPreBuilt', {}},
            },
        InstantCheck = true,
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
					'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
					'T1EnergyProduction',
                    'T1EnergyProduction',                 
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1LandFactory',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1AADefense',
'T1EnergyProduction',





					
                }
            }
        }
    },
    
   
    Builder {
        BuilderName = 'NC CDR Initial Giant map',
        PlatoonAddBehaviors = { 'CommanderBehaviorSorian', },
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 999999,
        BuilderConditions = {
       
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
                { IBC, 'NotPreBuilt', {}},
            },
        InstantCheck = true,
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
					'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
					'T1EnergyProduction',
                    'T1EnergyProduction',                 
'T1AADefense',
'T1EnergyProduction',
'T1AADefense',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1AirFactory',
'T1EnergyProduction',
'T1EnergyProduction',



					
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC CDR Initial small',
        PlatoonAddBehaviors = { 'CommanderBehaviorSorian', },
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 99999,
        BuilderConditions = {
          
            { SBC, 'MapLessThan', { 1000, 1000 }},
                { IBC, 'NotPreBuilt', {}},
            },
        InstantCheck = true,
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    
                    'T1LandFactory',
					'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
					'T1EnergyProduction',
                    'T1EnergyProduction',                 

'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1EnergyProduction',
'T1LandFactory',
'T1EnergyProduction',

                


					
                }
            }
        }
    },
 
    Builder {
        BuilderName = 'NC CDR Initial PreBuilt Balanced',
        PlatoonAddBehaviors = { 'CommanderBehaviorSorian', },
		PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 99999,
        BuilderConditions = {
                { IBC, 'PreBuiltBase', {}},
            },
        InstantCheck = true,
        BuilderType = 'Any',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                    'T1AirFactory',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
					'T1EnergyProduction',
                    'T1AirFactory',
                    'T1LandFactory',
                    'T1LandFactory',
                    'T1LandFactory',
                }
            }
        }
    },
  
}


    