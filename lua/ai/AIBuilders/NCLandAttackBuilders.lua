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
       
        { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } }, 
       
      
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
        { EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } }, 
       
      
        { UCBC, 'HaveLessThanUnitsWithCategory', { 60, categories.SUBCOMMANDER } },
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.SUBCOMMANDER }},
        
    },
    BuilderType = 'Gate',
},
}




BuilderGroup {
    BuilderGroupName = 'NClandbehaviorexpansion',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NClandbaseguardexpansionunits',
        PlatoonTemplate = 'landbaseguardNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 502,
        InstanceCount = 2,
        BuilderConditions = { 
        
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = {


            
                'ALLUNITS',
            },
        },    

        BuilderType = 'Any',
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
        PlatoonTemplate = 'landbaseguardNC',
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
        BuilderName = 'NClandexcesspool',
        PlatoonTemplate = 'StrikeForceSmallNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 10,
        InstanceCount = 50,
        BuilderConditions = { 
            
            { MIBC, 'GreaterThanGameTime', { 600} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.LAND - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
            TargetSearchCategory = categories.MOBILE * categories.LAND,
            MoveToCategories = {                                               
                categories.EXPERIMENTAL * categories.LAND,
                categories.MOBILE * categories.LAND,
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
            
        },    
     
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NCengihuntlandunits_SMALL',
        PlatoonTemplate = 'StrikeForceSmallNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 10,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 600} },
            { SBC, 'LessThanGameTime', { 2399 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            TargetSearchCategory = categories.MOBILE * categories.LAND,
            MoveToCategories = {                                               
                categories.EXPERIMENTAL * categories.LAND,
                categories.MOBILE * categories.LAND,
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NCengihuntlandunits_MEDIUM',
        PlatoonTemplate = 'StrikeForceMediumNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 10,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 600} },
            { SBC, 'LessThanGameTime', { 2399 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            TargetSearchCategory = categories.MOBILE * categories.LAND,
            MoveToCategories = {                                               
                categories.EXPERIMENTAL * categories.LAND,
                categories.MOBILE * categories.LAND,
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
            
        },    
    
        BuilderType = 'Any',
    },



 
  
    Builder {
        BuilderName = 'NCmasshuntlandunits_lategame',
        PlatoonTemplate = 'StrikeForceLargeNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 101,
        InstanceCount = 10,
        BuilderConditions = { 
   
            { MIBC, 'GreaterThanGameTime', { 2400} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            TargetSearchCategory = categories.MOBILE * categories.LAND,
            MoveToCategories = {                                               
                categories.EXPERIMENTAL * categories.LAND,
                categories.MOBILE * categories.LAND,
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
          
        },    
      
        BuilderType = 'Any',
    },
    
    
}


BuilderGroup {
    BuilderGroupName = 'NCT1LandFactoryBuildersemergency',
    BuildersType = 'FactoryBuilder',
    
 Builder {
        BuilderName = 'NC T1 Light Tank  Tech 1 EMERGENCY',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 825,
        InstanceCount = 100,
        BuilderConditions = {
            { SBC, 'LessThanGameTime', { 600 } },	
	      { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.LAND * categories.MOBILE - categories.ENGINEER,  'Enemy' }},	
         
          { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAND * categories.MOBILE - categories.ENGINEER } },
			
      
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCT1expansionprotect',
    BuildersType = 'FactoryBuilder',
     
    Builder {
        BuilderName = 'NC T1 Light Tank expansion',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 975,
        InstanceCount = 3,
        BuilderConditions = {
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER}},
         
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Mortar expansion',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 975,
        InstanceCount = 3,
        BuilderConditions = {
      
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER}},
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
        BuilderType = 'Land',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCT1LandFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Light Tank  Tech 1',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 655,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Light Tank  Tech 1 big',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 625,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
      
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },

    
    Builder {
        BuilderName = 'NC T1 Mortar  Not T1',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 600,
        InstanceCount = 6,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.01 }},
            
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Mortar  Not T1 big',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 600,
        InstanceCount = 3,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
        BuilderType = 'Land',
    },
 
}



#----------------------------------------
# T1 Response Builder
# Used to respond to the sight of tanks nearby
#----------------------------------------
BuilderGroup {
    BuilderGroupName = 'NCT1ReactionDF',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Tank Enemy Nearby',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 710,
InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
          
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
          
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Mortar  rapidattack',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 710,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
          
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       
            
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Tank Enemy Nearby big',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 700,
InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
          
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 Mortar  rapidattack big',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 900,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
		
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       
            
        },
        BuilderType = 'Land',
    },
}

#----------------------------------------
# T2 Factories
#----------------------------------------
BuilderGroup {
    BuilderGroupName = 'NCT2LandFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    # Tech 2 Priority
    Builder {
        BuilderName = 'NC T2 Tank - Tech 2',
        PlatoonTemplate = 'T2LandDFTank',
        Priority = 720,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
        
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
    Builder {
        BuilderName = 'NC T2 MML',
        PlatoonTemplate = 'T2LandArtillery',
        Priority = 720,
        InstanceCount = 3,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
          
			{ SBC, 'NoRushTimeCheck', { 600 }},
            
                    
        },
    },
    # Tech 2 priority
    Builder {
        BuilderName = 'NC T2AttackTank - Tech 2',
        PlatoonTemplate = 'T2AttackTankSorian',
        Priority = 720,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
          
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
  
   
  
    
   
   
 
    Builder {
        BuilderName = 'NC T2 Tank - Tech 2 big',
        PlatoonTemplate = 'T2LandDFTank',
        Priority = 720,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
        
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
    Builder {
        BuilderName = 'NC T2 MML big',
        PlatoonTemplate = 'T2LandArtillery',
        Priority = 720,
        InstanceCount = 3,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
          
			{ SBC, 'NoRushTimeCheck', { 600 }},
            
                    
        },
    },
    
    Builder {
        BuilderName = 'NC T2AttackTank - Tech 2 big',
        PlatoonTemplate = 'T2AttackTankSorian',
        Priority = 720,
        BuilderType = 'Land',
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.TECH3 * categories.LAND }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
          
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },

 
}

#----------------------------------------
# T2 Response Builder
# Used to respond to the sight of tanks nearby
#----------------------------------------
BuilderGroup {
    BuilderGroupName = 'NCT2ReactionDF',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T2 Tank Enemy Nearby',
        PlatoonTemplate = 'T2AttackTankSorian',
        Priority = 825,
InstanceCount = 20,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
  
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.LAND * categories.TECH3}},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
           
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 Tank Enemy Nearby big',
        PlatoonTemplate = 'T2AttackTankSorian',
        Priority = 825,
InstanceCount = 20,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.LAND * categories.TECH3}},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
           
        },
        BuilderType = 'Land',
    },
}



#----------------------------------------
# T3 Land
#----------------------------------------
BuilderGroup {
    BuilderGroupName = 'NCT3LandFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    # T3 Tank
    Builder {
        BuilderName = 'NC T3 Siege Assault Bot',
        PlatoonTemplate = 'T3LandBot',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    # T3 Artilery
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 740,

        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
           
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
    },
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery - tough def',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 740,
        
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
    },
 
    Builder {
        BuilderName = 'NC T3SniperBots',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3ArmoredAssault',
        PlatoonTemplate = 'T3ArmoredAssaultSorian',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
           
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3MobileMissile',
        PlatoonTemplate = 'T3MobileMissile',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
           
          
        },
    },
    Builder {
        BuilderName = 'NC T3 Siege Assault Bot big',
        PlatoonTemplate = 'T3LandBot',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
           
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    # T3 Artilery
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery big',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 740,

        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
    },
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery - tough def big',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 740,
        
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
    
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
         
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
        },
    },
 
    Builder {
        BuilderName = 'NC T3SniperBots big',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
          
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3ArmoredAssault big',
        PlatoonTemplate = 'T3ArmoredAssaultSorian',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3MobileMissile big',
        PlatoonTemplate = 'T3MobileMissile',
        Priority = 740,
        BuilderType = 'Land',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
           
          
        },
    },
    
}










#----------------------------------------
# T3 Response
#--------------------------------------- 
BuilderGroup {
    BuilderGroupName = 'NCT3ReactionDF',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3 Assault Enemy Nearby',
        PlatoonTemplate = 'T3ArmoredAssaultSorian',
        Priority = 945,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
         
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 SiegeBot Enemy Nearby',
        PlatoonTemplate = 'T3LandBot',
        Priority = 935,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.01 }},
            
     
        },
        BuilderType = 'Land',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCaphibbuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 land aphib',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        InstanceCount = 5,
        BuilderConditions = {
           
       
         
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.TECH3 * categories.LAND }},
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        InstanceCount = 5,
        BuilderConditions = {
            
        
         
           
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        InstanceCount = 5,
        BuilderConditions = {
    
         
         
       
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
    
}

            


    
    

