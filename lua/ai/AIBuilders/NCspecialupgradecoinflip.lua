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
local Tech2MassExtractortoTech1ExtractorRatio = 0.80
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'

---nuke quick upgrade

BuilderGroup {
    BuilderGroupName = 'NC nuke rush landupgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC nuke rush t1 land upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1050,
        InstanceCount = 1,
        BuilderConditions = {
      
            { CF, 'StrategyRandomizer', {3} },
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.0, 1.0 } },
          
              
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.ENGINEER }},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY LAND TECH2' } },
             { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY LAND'}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC nuke rush t2 land upgrade',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1050,
        InstanceCount = 1,
        BuilderConditions = {
            { CF, 'StrategyRandomizer', {3} },
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.0, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH2 }},
         
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY LAND TECH3' } },
             { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'FACTORY LAND'}},
           
           
           --
            },
        BuilderType = 'Any',
    },
}

