#***************************************************************************
#*
#**  File     :  /lua/ai/AISeaAttackBuilders.lua
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

function SeaAttackCondition(aiBrain, locationType, targetNumber)
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	#if aiBrain:GetCurrentEnemy() then
	#	local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
	#	targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiSurface' )
	#	targetNumber = targetNumber + aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiSub' )
	#end

    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    --local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.NAVAL, position, radius )
    --local subThreat = pool:GetPlatoonThreat( 'AntiSub', categories.MOBILE * categories.NAVAL, position, radius )
    local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.NAVAL)
    local subThreat = pool:GetPlatoonThreat( 'AntiSub', categories.MOBILE * categories.NAVAL)
    if ( surfaceThreat + subThreat ) >= targetNumber then
        return true
	elseif UC.UnitCapCheckGreater(aiBrain, .95) then
		return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.NAVAL * categories.TECH3) and ( surfaceThreat + subThreat ) > 1125 then #5 Units x 225
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.NAVAL * categories.TECH2)
	and UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.NAVAL * categories.TECH3) and ( surfaceThreat + subThreat ) > 280 then #7 Units x 40
		return true
	elseif UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.NAVAL - categories.TECH1) and ( surfaceThreat + subThreat ) > 42 then #7 Units x 6
		return true
    end
    return false
end


BuilderGroup {
    BuilderGroupName = 'ncSeaHunterFormBuilders',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'nc Sea Hunters T1',
        PlatoonTemplate = 'SeaHuntNC',
		#PlatoonAddPlans = {'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
		PlatoonAddPlans = {'AirLandToggleSorian'},
        Priority = 1000,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
		UseFormation = 'AttackFormation',
        },
        BuilderConditions = {

            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.NAVAL - categories.EXPERIMENTAL - categories.CARRIER} },
            { SeaAttackCondition, { 'LocationType', 20 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			SearchRadius = 6000,
            PrioritizedCategories = {                
				'STRUCTURE DEFENSE ANTINAVY TECH2',
				'STRUCTURE DEFENSE ANTINAVY TECH1',
				'MOBILE NAVAL',
				'STRUCTURE NAVAL',
            },
        },
    },
}	
    




BuilderGroup {
    BuilderGroupName = 'NCT1SeaFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Sea Sub',
        PlatoonTemplate = 'T1SeaSub',
        Priority = 600,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },

			{ SBC, 'NoRushTimeCheck', { 600 }},
			
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.NAVAL * categories.MOBILE } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.1 }},
        },
        BuilderType = 'Sea',
             },

 Builder {
        BuilderName = 'NC T1 Sea Sub lots of enemies',
        PlatoonTemplate = 'T1SeaSub',
        Priority = 600,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 10, categories.NAVAL * categories.MOBILE,  'Enemy' }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.1 }},
        },
        BuilderType = 'Sea',
             },
   
}

BuilderGroup {
    BuilderGroupName = 'NCT2SeaFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T2 Naval Destroyer',
        PlatoonTemplate = 'T2SeaDestroyer',
        Priority = 700,
        InstanceCount = 50,
        BuilderType = 'Sea',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 5, categories.NAVAL * categories.MOBILE,  'Enemy' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.FACTORY * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
        },
    },
}





BuilderGroup {
    BuilderGroupName = 'NCT2SeaStrikeForceBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'Sorian T2 Naval Destroyer - SF',
        PlatoonTemplate = 'T2SeaDestroyer',
        Priority = 705,
        BuilderType = 'Sea',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.FACTORY * categories.TECH2 } },
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.STRUCTURE * categories.DEFENSE * categories.ANTINAVY, 'Enemy'}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
        },
    },
    Builder {
        BuilderName = 'NC T2 Naval Cruiser - SF',
        PlatoonTemplate = 'T2SeaCruiser',
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 705,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.FACTORY * categories.TECH2 } },
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.STRUCTURE * categories.DEFENSE * categories.ANTINAVY, 'Enemy'}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
        },
        BuilderType = 'Sea',
    },
}


