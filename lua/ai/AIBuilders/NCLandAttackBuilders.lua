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
    BuilderGroupName = 'NCattackexpansionbehavior',
    BuildersType = 'PlatoonFormBuilder',   
    Builder {
        BuilderName = 'NC Expansion attack',
        PlatoonTemplate = 'StartLocationAttack2Sorian',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1500,
     
        BuilderConditions = {        
            { MIBC, 'GreaterThanGameTime', { 360} },
				{ SBC, 'NoRushTimeCheck', { 0 }},
		
				
                
            },
        BuilderData = {
			ThreatSupport = 75,
            MarkerType = 'Expansion Area',            
            MoveFirst = 'Random',
            MoveNext = 'Random',
			LocationType = 'LocationType',
            #ThreatType = '',
            #SelfThreat = '',
            #FindHighestThreat ='',
            #ThreatThreshold = '',
            AvoidBases = false,
         
			UseFormation = 'AttackFormation',
			AggressiveMove = false,
        
            
        },    
        InstanceCount = 100,
        BuilderType = 'Any',
    },
    
}

BuilderGroup {
    BuilderGroupName = 'NCengihuntlandbehavior',
    BuildersType = 'PlatoonFormBuilder',
  Builder {
        BuilderName = 'NCengihuntlandunits',
        PlatoonTemplate = 'StrikeForceMediumNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1500,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 360} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
                        SearchRadius = 6000,
			ThreatSupport = 40,
            PrioritizedCategories = {

 'ENGINEER',
'MASSEXTRACTION',
               
                
                'COMMAND',
            
                'ALLUNITS',
            },
        },    
        InstanceCount = 100,
        BuilderType = 'Any',
    },
 
}

BuilderGroup {
    BuilderGroupName = 'NCmasshuntlandbehavior',
    BuildersType = 'PlatoonFormBuilder',
  Builder {
        BuilderName = 'NCmasshuntlandunits',
        PlatoonTemplate = 'StrikeForceMediumNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1500,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 360} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
                        SearchRadius = 6000,
			ThreatSupport = 40,
            PrioritizedCategories = {
'MASSEXTRACTION',
                'ENGINEER',
                
                'COMMAND',
            
                'ALLUNITS',
            },
        },    
        InstanceCount = 100,
        BuilderType = 'Any',
    },
 
}


BuilderGroup {
    BuilderGroupName = 'NCT1LandFactoryBuildersemergency',
    BuildersType = 'FactoryBuilder',
    
 Builder {
        BuilderName = 'NC T1 Light Tank - Tech 1 - EMERGENCY',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 825,
        InstanceCount = 100,
        BuilderConditions = {
          { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY TECH3' }},
	{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.LAND * categories.MOBILE - categories.ENGINEER,  'Enemy' }},	
 { SBC, 'LessThanGameTime', { 1200 } },	
{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAND * categories.MOBILE - categories.ENGINEER } },
			
      
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
}





BuilderGroup {
    BuilderGroupName = 'NCT1LandFactoryBuilders',
    BuildersType = 'FactoryBuilder',
 
    Builder {
        BuilderName = 'NC T1 Bot - Early Game',
        PlatoonTemplate = 'T1LandDFBot',
        Priority = 825,
		
        BuilderConditions = {
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH2, LAND FACTORY TECH3' }},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { SBC, 'LessThanGameTime', { 1200 } },	
          
			{ SBC, 'NoRushTimeCheck', { 600 }},
       
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
  
    Builder {
        BuilderName = 'NC T1 Light Tank - Tech 1',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 725,
        BuilderConditions = {
           
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'LAND FACTORY TECH3' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
      
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },


 
    Builder {
        BuilderName = 'NC T1 Light Tank - Tech 3',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 600,
        BuilderConditions = {
          
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'LAND FACTORY TECH3' }},
		
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'UnitCapCheckLess', { .8 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
        },
        BuilderType = 'Land',
    },    

    Builder {
        BuilderName = 'NC T1 Mortar - Not T1',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 600,
        BuilderConditions = {
        
            { UCBC, 'HaveUnitRatio', { 0.3, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
           
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'LAND FACTORY TECH3' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'UnitCapCheckLess', { .8 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
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
        Priority = 900,
InstanceCount = 30,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'LAND FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
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
        Priority = 600,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
    Builder {
        BuilderName = 'NC T2 MML',
        PlatoonTemplate = 'T2LandArtillery',
        Priority = 600,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH3' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
                    
        },
    },
    # Tech 2 priority
    Builder {
        BuilderName = 'NC T2AttackTank - Tech 2',
        PlatoonTemplate = 'T2AttackTankSorian',
        Priority = 600,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
  
    Builder {
        BuilderName = 'NC T2 Amphibious Tank - Tech 2',
        PlatoonTemplate = 'T2LandAmphibious',
        Priority = 600,
InstanceCount = 100,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
           
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ SBC, 'IsWaterMap', { true } },
			{ MIBC, 'FactionIndex', {1, 2, 4}},
        },
    },
    # Tech 3 priority
    Builder {
        BuilderName = 'NC T2 Amphibious Tank - Tech 3',
        PlatoonTemplate = 'T2LandAmphibious',
        Priority = 550,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
         
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ SBC, 'IsWaterMap', { true } },
			{ MIBC, 'FactionIndex', {1, 2, 4}},
        },
    },
    # Tech 2 priority
    Builder {
        BuilderName = 'NC T2 Amphibious Tank - Tech 2 Cybran',
        PlatoonTemplate = 'T2LandAmphibious',
        Priority = 600,
InstanceCount = 100,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SBC, 'IsIslandMap', { true } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'LAND FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ MIBC, 'FactionIndex', {3}},
        },
    },
    # Tech 3 priority
    Builder {
        BuilderName = 'NC T2 Amphibious Tank - Tech 3 Cybran',
        PlatoonTemplate = 'T2LandAmphibious',
        Priority = 550,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
       
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ MIBC, 'FactionIndex', {3}},
        },
    },
    Builder {
        BuilderName = 'NC T2MobileShields',
        PlatoonTemplate = 'T2MobileShields',
        Priority = 600,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 4, 'FACTORY TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.15, categories.LAND * categories.MOBILE * ( categories.COUNTERINTELLIGENCE + (categories.SHIELD * categories.DEFENSE) ) - categories.DIRECTFIRE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE - categories.TECH1}},
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
        Priority = 925,
InstanceCount = 20,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'LAND FACTORY TECH3' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.DIRECTFIRE * categories.LAND * categories.MOBILE - categories.TECH1 } },
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
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    # T3 Artilery
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveUnitRatio', { 0.3, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
        },
    },
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery - tough def',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 725,
        BuilderType = 'Land',
        BuilderConditions = {
    
			{ SBC, 'GreaterThanThreatAtEnemyBase', { 'AntiSurface', 53}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveUnitRatio', { 0.5, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
        },
    },
    Builder {
        BuilderName = 'NC T3 Mobile Flak',
        PlatoonTemplate = 'T3LandAA',
        Priority = 700,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.15, categories.LAND * categories.ANTIAIR * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'LAND ANTIAIR MOBILE' } },
            #{ TBC, 'HaveLessThreatThanNearby', { 'LocationType', 'AntiAir', 'Air' } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3SniperBots',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3ArmoredAssault',
        PlatoonTemplate = 'T3ArmoredAssaultSorian',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    Builder {
        BuilderName = 'NC T3MobileMissile',
        PlatoonTemplate = 'T3MobileMissile',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.15, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
          
        },
    },
    Builder {
        BuilderName = 'NC T3MobileShields',
        PlatoonTemplate = 'T3MobileShields',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.15, categories.LAND * categories.MOBILE * ( categories.COUNTERINTELLIGENCE + (categories.SHIELD * categories.DEFENSE) ) - categories.DIRECTFIRE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE - categories.TECH1}},
        },
    },
}

#----------------------------------------
# T3 AA
#---------------------------------------    
BuilderGroup {
    BuilderGroupName = 'NCT3LandResponseBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3 Mobile AA Response',
        PlatoonTemplate = 'T3LandAA',
        Priority = 900,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'LAND ANTIAIR MOBILE' } },
            { TBC, 'HaveLessThreatThanNearby', { 'LocationType', 'AntiAir', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.05 }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Land',
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
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
         
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 SiegeBot Enemy Nearby',
        PlatoonTemplate = 'T3LandBot',
        Priority = 935,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Land', 1 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 }},
     
        },
        BuilderType = 'Land',
    },
}


            


    
    

