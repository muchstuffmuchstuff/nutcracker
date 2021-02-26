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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local Tech3airfactoryrelativetotech2and1 = 0.30



local SUtils = import('/lua/AI/sorianutilities.lua')





BuilderGroup {
    BuilderGroupName = 'NCT1AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
  
    Builder {
        BuilderName = 'NC fake builder for coinflip air',
        PlatoonTemplate = 'NCt1fighter_ratio_response',
        Priority = 760,
        InstanceCount = 20,
        
        
        BuilderType = 'Air',
        BuilderConditions = {
            {CF,'bomberandgroundattackrandomizer',{400}},
        },
        
    },

    Builder {
        BuilderName = 'NC T1 below 3:1 ratio',
        PlatoonTemplate = 'NCt1fighter_ratio_response',
        Priority = 760,
        InstanceCount = 20,
        
        
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 1, categories.AIR * categories.ANTIAIR * categories.TECH3, 'Enemy'}},
            { UCBC, 'HaveUnitRatio', { Tech3airfactoryrelativetotech2and1, categories.FACTORY * categories.AIR * categories.TECH3, '<=', categories.FACTORY * categories.AIR * (categories.TECH1 + categories.TECH2) } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR *(categories.TECH1 + categories.TECH2) - categories.SCOUT - categories.TRANSPORTFOCUS } },

        },
        
    },
    Builder {
        BuilderName = 'NC T1 Interceptors endless',
        PlatoonTemplate = 'T1AirFighter',
        Priority = 659,
       
       
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 240 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 1, categories.AIR * categories.ANTIAIR * categories.TECH3, 'Enemy'}},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ANTIAIR * categories.AIR * categories.TECH1 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8 , categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
  
			
        },
        
    },
    
  
 
}

BuilderGroup {
    BuilderGroupName = 'NCT3AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3AntiAirPlanes below 3:1 ratio',
        PlatoonTemplate = 'NCt3fighter_ratio_response',
        Priority = 791,
        InstanceCount = 20,
        BuilderType = 'Air',

        BuilderConditions = {
          
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { SBC, 'NoRushTimeCheck', { 600 }},
      
            
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
     
        },
     
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes endless',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 705,
       
       
        BuilderType = 'Air',

        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ANTIAIR * categories.AIR * categories.TECH3 }},
            { SBC, 'NoRushTimeCheck', { 600 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
           
 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 7, categories.AIR * categories.MOBILE * categories.ANTIAIR * categories.TECH3 - categories.BOMBER - categories.GROUNDATTACK } },
		
	
            
        },
     
    },
    
}

BuilderGroup {
    BuilderGroupName = 'NCt3emergencybuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Exp Response build fast',
        PlatoonTemplate = 'NCt3fighter_ratio_response_exp',
		Priority = 1050,
		InstanceCount = 20,
        
      
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 60.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE  } },
		
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
	},
	Builder {
        BuilderName = 'NC T2 Gunship - Exp Response build fast',
        PlatoonTemplate = 'NC_T2_gunship_exp_attack',
		Priority = 789,
		InstanceCount = 5,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
			{CF,'gunshipallowed',{}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.LAND * categories.MOBILE, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 25.0, categories.MOBILE * categories.AIR * categories.GROUNDATTACK, '<=', categories.EXPERIMENTAL * categories.LAND * categories.MOBILE } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },
    Builder {
        BuilderName = 'NC T3 mix - Exp Response build fast',
        PlatoonTemplate = 'NC_T3_mix_exp_attack',
		Priority = 790,
		InstanceCount = 5,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
            {CF,'gunshipallowed',{}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.LAND * categories.MOBILE, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 25.0, categories.MOBILE * categories.AIR * (categories.STRATEGICBOMBER + categories.GROUNDATTACK), '<=', categories.EXPERIMENTAL * categories.LAND * categories.MOBILE } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },
    Builder {
        BuilderName = 'NC T2 Gunship - land spam Response build fast',
        PlatoonTemplate = 'NC_T2_gunship_exp_attack',
		Priority = 787,
		InstanceCount = 5,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
			{CF,'gunshipallowed',{}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 50, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 4.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },
    Builder {
        BuilderName = 'NC T3 mix - land spam Response build fast',
        PlatoonTemplate = 'NC_T3_mix_exp_attack',
		Priority = 788,
		InstanceCount = 5,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
            {CF,'gunshipallowed',{}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 50, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 4.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },

}