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



local SUtils = import('/lua/AI/sorianutilities.lua')

function AirAttackCondition(aiBrain, locationType, targetNumber )
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	if aiBrain:GetCurrentEnemy() then
		local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
		targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiAir' )
	end
	
    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    --local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE, position, radius )
	local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE)
    local airThreat = 0 #pool:GetPlatoonThreat( 'AntiAir', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE, position, radius )
    if ( surfaceThreat + airThreat ) >= targetNumber then
        return true
	elseif UC.UnitCapCheckGreater(aiBrain, .95) then
		return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.AIR * categories.TECH3 * (categories.GROUNDATTACK + categories.BOMBER)) and surfaceThreat > 120 then #8 Units x 15
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.AIR * categories.TECH2 * (categories.GROUNDATTACK + categories.BOMBER))
	and UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.AIR * categories.TECH3 * (categories.GROUNDATTACK + categories.BOMBER)) and surfaceThreat > 25 then #5 Units x 5
		return true
	elseif UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.TECH1) and surfaceThreat > 6 then #3 Units x 2
		return true
    end
    return false
end

BuilderGroup {
    BuilderGroupName = 'NCT1AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 below 3:1 ratio',
        PlatoonTemplate = 'NCt1fighter_ratio_response',
        Priority = 760,
        
        
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
			{ SBC, 'NoRushTimeCheck', { 600 }},
         
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR *(categories.TECH1 + categories.TECH2) - categories.SCOUT - categories.TRANSPORTFOCUS } },

        },
        
    },
    Builder {
        BuilderName = 'NC T1 Interceptors endless',
        PlatoonTemplate = 'T1AirFighter',
        Priority = 659,
        InstanceCount = 15,
       
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            { SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ANTIAIR * categories.AIR * categories.TECH1 }},
            
           
        { UCBC, 'HaveLessThanUnitsWithCategory', { 10 , categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
  
			
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
        InstanceCount = 30,
        BuilderType = 'Air',

        BuilderConditions = {
          
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            { SBC, 'NoRushTimeCheck', { 600 }},
      
            
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
     
        },
     
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes endless',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 705,
        InstanceCount = 10,
       
        BuilderType = 'Air',

        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ANTIAIR * categories.AIR * categories.TECH3 }},
            { SBC, 'NoRushTimeCheck', { 600 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
           
 
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
		InstanceCount = 30,
        
      
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 60.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.EXPERIMENTAL * categories.AIR - categories.ORBITALSYSTEM - categories.UNTARGETABLE  } },
		
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
	},
	Builder {
        BuilderName = 'NC T2 Gunship - Exp Response build fast',
        PlatoonTemplate = 'NC_T2_gunship_exp_attack',
		Priority = 789,
		InstanceCount = 30,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
			
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
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
		InstanceCount = 30,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
		
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
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
		InstanceCount = 30,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
			
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 50, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 0.2, categories.MOBILE * categories.AIR * categories.GROUNDATTACK, '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },
    Builder {
        BuilderName = 'NC T3 mix - land spam Response build fast',
        PlatoonTemplate = 'NC_T3_mix_exp_attack',
		Priority = 788,
		InstanceCount = 30,
      
      
        BuilderType = 'Air',
        BuilderConditions = {
		
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } }, 
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.EXPERIMENTAL * categories.LAND * categories.MOBILE, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 0.2, categories.MOBILE * categories.AIR * categories.GROUNDATTACK, '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
	
        },
        
    },

}