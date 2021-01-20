#***************************************************************************
#*
#**  File     :  /lua/ai/SorianLandAttackBuilders.lua
#**
#**  Summary  : Default economic builders for skirmish
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

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





BuilderGroup {
    BuilderGroupName = 'NCsubcommander_ras',
    BuildersType = 'FactoryBuilder',
Builder {
    BuilderName = 'NC lots of RAS',
    PlatoonTemplate = 'NC RAS',
    Priority = 950,
    BuilderConditions = {
    
        { MIBC, 'GreaterThanGameTime', { 1200 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 500, 10000 } },
       
        --- 
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 60, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},
Builder {
    BuilderName = 'NC lots of RAS lots of juice',
    PlatoonTemplate = 'NC RAS',
    Priority = 951,
    BuilderConditions = {
    
        { MIBC, 'GreaterThanGameTime', { 1500 } },
        { EBC, 'GreaterThanEconStorageCurrent', { 5000, 10000 } },
        --- 
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 60, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},
}






BuilderGroup {
    BuilderGroupName = 'NClandbehavior',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NClandbaseguard',
        PlatoonTemplate = 'landbaseguardNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 600 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = {


            'EXPERIMENTAL LAND',
                'ALLUNITS',
            },
        },    
      
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NClandbaseguardt3',
        PlatoonTemplate = 'landbaseguardNCt3',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
        
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH3 - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = {


            'EXPERIMENTAL LAND',
                'ALLUNITS',
            },
        },    
      
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC anti air mobile',
        PlatoonTemplate = 'NC antiairland',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
        
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ANTIAIR - categories.EXPERIMENTAL  } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = { categories.MOBILE * categories.AIR


            
            },
        },    
      
        BuilderType = 'Any',
    },
    
    
       
    
    Builder {
        BuilderName = 'NC t1 spammage all game',
        PlatoonTemplate = 'NC t1spammage',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 70,
        
        BuilderConditions = { 
        
            { MIBC, 'GreaterThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,  
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t1 spammage all game early',
        PlatoonTemplate = 'NC t1spammagesmall',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 70,
        
        BuilderConditions = { 
        
           
            { MIBC, 'LessThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,  
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t1 aphib',
        PlatoonTemplate = 'NC t1aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 70,
        
        BuilderConditions = { 
        
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH1 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,  
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t2 all game land attack',
        PlatoonTemplate = 'NC t2 ground attack', 
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 30,
        FormRadius = 300,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 450} },
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 30,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t2 aphib',
        PlatoonTemplate = 'NC t2aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 70,
        
        BuilderConditions = { 
        
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH2 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,  
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC t3 all game land attack',
        PlatoonTemplate = 'NC t3 ground attack',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 30,
        FormRadius = 300,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 1000} },
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 15,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t3 aphib',
        PlatoonTemplate = 'NC t3aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 70,
        
        BuilderConditions = { 
        
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH3 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AttackEnemyStrength = 92,  
            TargetSearchCategory = categories.STRUCTURE,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },

   
    
    
}






    
    

