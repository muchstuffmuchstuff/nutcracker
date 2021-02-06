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
    BuilderGroupName = 'NCengineerassistnuke_coinflip',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1 Engineer Assist Factory Upgrade',
        PlatoonTemplate = 'EngineerAssist',
        Priority = 1050,
        InstanceCount = 5,
        BuilderConditions = {
            { CF, 'CoinFlip', {47} },
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY' }},
            { SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.TECH3 * categories.LAND } },
      
           
           
       --
        },
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                PermanentAssist = false,
                BeingBuiltCategories = {'FACTORY LAND'},
                AssisteeType = 'Factory',
                time = 60,
            },
        }
    },
Builder {
    BuilderName = 'NC T2 Engineer Assist Factory Upgrade',
    PlatoonTemplate = 'T2EngineerAssist',
    Priority = 1050,
    InstanceCount = 5,
    BuilderConditions = {
        { CF, 'CoinFlip', {47} },
        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY' }},
        { SIBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.TECH3 * categories.LAND } },
      
       
       
   --
    },
    InstanceCount = 5,
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            PermanentAssist = false,
            BeingBuiltCategories = {'FACTORY LAND'},
            AssisteeType = 'Factory',
            time = 60,
        },
    }
},
}


BuilderGroup {
    BuilderGroupName = 'NCACUUpgrades_nukecoinflip',
    BuildersType = 'EngineerBuilder', #'PlatoonFormBuilder',
    
    Builder {
        BuilderName = 'NC UEF CDR Upgrade nuke rush',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { CF, 'CoinFlip', {47 } },
            { MIBC, 'FactionIndex', {1}},
          
            { MIBC, 'GreaterThanGameTime', { 300} },
       
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
				{ SBC, 'CmdrHasUpgrade', { 'Shield', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'LeftPod', 'RightPod', 'AdvancedEngineering', 'T3Engineering' },
        },
    },
   
  
   
    
    Builder {
        BuilderName = 'NC Aeon CDR Upgrade nuke rush',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { CF, 'CoinFlip', {47 } },
            { MIBC, 'FactionIndex', {2}},
           
            { MIBC, 'GreaterThanGameTime', { 300} },
            
				{ SBC, 'CmdrHasUpgrade', { 'HeatSink', false }},
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'AdvancedEngineering', 'T3Engineering' },
        },
    },
    
  
    
    # Cybran
    Builder {
        BuilderName = 'NC Cybran CDR Upgrade nuke rush',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { CF, 'CoinFlip', {47 } },
            { MIBC, 'FactionIndex', {3}},
         
            { MIBC, 'GreaterThanGameTime', { 300} },
           
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
				{ SBC, 'CmdrHasUpgrade', { 'MicrowaveLaserGenerator', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'StealthGenerator', 'AdvancedEngineering', 'T3Engineering' },
        },
    },
  
	
    # Seraphim
    Builder {
        BuilderName = 'NC Seraphim CDR Upgrade nuke rush',
        PlatoonTemplate = 'CommanderEnhanceSorian',
        BuilderConditions = {
            { CF, 'CoinFlip', {47 } },
            { MIBC, 'FactionIndex', {4}},
            { MIBC, 'GreaterThanGameTime', { 300} },
          
				{ SBC, 'CmdrHasUpgrade', { 'AdvancedRegenAura', false }},
				{ SBC, 'CmdrHasUpgrade', { 'T3Engineering', false }},
                
            },
        Priority = 1000,
        BuilderType = 'Any',
		PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderData = {
            Enhancement = { 'AdvancedEngineering', 'RegenAura', 'T3Engineering' },
        },
    },
  
    
 
}


BuilderGroup {
    BuilderGroupName = 'NC nuke rush landupgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC nuke rush t1 land upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 1,
        BuilderConditions = {
      
            { CF, 'CoinFlip', {47} },
         
            
          
              
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER }},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY LAND' } },
         
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC nuke rush t2 land upgrade',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 1,
        BuilderConditions = {
            { CF, 'CoinFlip', {47} },
           
         
           
         
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH2 * categories.FACTORY * categories.LAND} },
         
           
           
           --
            },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NC paragon coinflip landupgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC paragon coinflip t1 land upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1300,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13} },
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.ENGINEER }},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC paragon coinflip t2 land upgrade',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1300,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { CF, 'CoinFlip', {13} },
            { MIBC, 'GreaterThanGameTime', { 330 } },
        
            },
        BuilderType = 'Any',
    },
}

