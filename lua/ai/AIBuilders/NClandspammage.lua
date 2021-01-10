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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local SUtils = import('/lua/AI/sorianutilities.lua')
local T1landspamNC = 0.20
local T1masshunterNC = 0.05
function LandAttackCondition(aiBrain, locationType, targetNumber)
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	if aiBrain:GetCurrentEnemy() then
		local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
		local enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
		--targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiSurface' )
		targetNumber = SUtils.GetThreatAtPosition( aiBrain, {estartX, 0, estartZ}, 1, 'AntiSurface', {'Commander', 'Air', 'Experimental'}, enemyIndex )
	end

    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    --local surThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.SCOUT - categories.ENGINEER, position, radius )
	local surThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.SCOUT - categories.ENGINEER)
	local airThreat = 0 #pool:GetPlatoonThreat( 'AntiAir', categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.SCOUT - categories.ENGINEER, position, radius )
	local adjustForTime = 1 + (math.floor(GetGameTimeSeconds()/60) * .01)
	--LOG("*AI DEBUG: Pool Threat: "..surThreat.." adjustment: "..adjustForTime.." Enemy Threat: "..targetNumber)
    if (surThreat + airThreat) >= targetNumber and targetNumber > 0 then
        return true
	elseif targetNumber == 0 then
		return true
	elseif UC.UnitCapCheckGreater(aiBrain, .95) then
		return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 9, categories.MOBILE * categories.LAND * categories.TECH3 - categories.ENGINEER) and surThreat > (500 * adjustForTime) then #25 Units x 20
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 9, categories.MOBILE * categories.LAND * categories.TECH2 - categories.ENGINEER)
	and UC.PoolLessAtLocation(aiBrain, locationType, 10, categories.MOBILE * categories.LAND * categories.TECH3 - categories.ENGINEER) and surThreat > (175 * adjustForTime) then #25 Units x 7
		return true
	elseif UC.PoolLessAtLocation(aiBrain, locationType, 10, categories.MOBILE * categories.LAND - categories.TECH1 - categories.ENGINEER) and surThreat > (25 * adjustForTime) then #25 Units x 1
		return true
    end
    return false
end

--spam amphib
BuilderGroup {
    BuilderGroupName = 'NCspammage',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 land aphib',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        InstanceCount = 100,
    
        BuilderConditions = {
           
       
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamNC , '<', categories.TECH1 * categories.MOBILE * categories.LAND } }, 
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        InstanceCount = 100,
   
        BuilderConditions = {
            
        
         
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
           
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        InstanceCount = 100,
      
        BuilderConditions = {
    
         
         
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
			
           
           
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        InstanceCount = 100,
    
        BuilderConditions = {
           
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamNC , '<=', categories.TECH1 * categories.MOBILE * categories.LAND } }, 
         
           
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
   
    Builder {
        BuilderName = 'NC T1 mass hunter',
        PlatoonTemplate = 'T1massattack',
        Priority = 1000,
        InstanceCount = 200,
        
    
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 700} },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.LAND * categories.BOT * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            
          
           
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack group',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        InstanceCount = 100,
   
        BuilderConditions = {
            
         
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
           
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    
    Builder {
        BuilderName = 'NC T3 land attack group',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
    
         
         
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
			
           
           
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCdefense_onisland',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 base defense on island against t1',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER, 270 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 base defense on island against t2',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 740,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.LAND * categories.MOBILE * (categories.TECH1 + categories.TECH2) - categories.ENGINEER, 270 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 base defense on island against t3',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.LAND * categories.MOBILE * (categories.TECH2 + categories.TECH3) - categories.ENGINEER, 270 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 base defense on island against EXP',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.LAND * categories.MOBILE * categories.EXPERIMENTAL, 300 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCdefense_antiair',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 base defense against t1 air',
        PlatoonTemplate = 'T1antiairland',
        Priority = 800,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.AIR * categories.MOBILE * categories.TECH1 - categories.SCOUT - categories.TRANSPORTFOCUS, 100 } },
           
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 base defense against t2 air',
        PlatoonTemplate = 'T2antiairland',
        Priority = 840,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.AIR * categories.MOBILE * (categories.TECH1 + categories.TECH2) - categories.SCOUT - categories.TRANSPORTFOCUS, 100 } },
         
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 base defense against t3 air',
        PlatoonTemplate = 'T3antiairland',
        Priority = 850,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.AIR * categories.MOBILE * (categories.TECH2 + categories.TECH3) - categories.SCOUT - categories.TRANSPORTFOCUS, 100 } },
             
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
  
}


