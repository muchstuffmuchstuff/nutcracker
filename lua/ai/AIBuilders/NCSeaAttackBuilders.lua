---muchstuff

---nutcracker

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
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
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
	elseif UC.UnitCapCheckGreater(aiBrain, 0.955) then
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
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
		UseFormation = 'AttackFormation',
        },
        BuilderConditions = {

            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.NAVAL - categories.EXPERIMENTAL - categories.CARRIER } },
            { SeaAttackCondition, { 'LocationType', 20 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			SearchRadius = 6000,
            PrioritizedCategories = {                
				'STRUCTURE DEFENSE ANTINAVY TECH2',
                'STRUCTURE DEFENSE ANTINAVY TECH1',
                'STRUCTURE NAVAL',
				'MOBILE NAVAL',
				
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
       --

			{ SBC, 'NoRushTimeCheck', { 600 }},
			
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.NAVAL * categories.MOBILE } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25,125 } },
            
        },
        BuilderType = 'Sea',
             },

 Builder {
        BuilderName = 'NC T1 Sea Sub lots of enemies',
        PlatoonTemplate = 'T1SeaSub',
        Priority = 600,
        BuilderConditions = {
       --
       { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.NAVAL,  'Enemy' }},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
			
            { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } },
            
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
        Priority = 790,
        InstanceCount = 5,
        BuilderType = 'Sea',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.NAVAL,  'Enemy' }},
			
  { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } },
            
        },
    },
    Builder {
        BuilderName = 'NC T2 Naval cruiser adaptive',
        PlatoonTemplate = 'T2SeaCruiser',
        Priority = 790,
        InstanceCount = 5,
        BuilderType = 'Sea',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600} },            
			{ SBC, 'NoRushTimeCheck', { 0}},
            { EBC, 'GreaterThanEconStorageCurrent', { 25, 125 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 1, categories.NAVAL * (categories.DESTROYER + categories.SUBMERSIBLE),  'Enemy' }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.NAVAL * categories.MOBILE } },
            
        },
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT3SeaFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC t3 subkiller',
        PlatoonTemplate = 'T3SubKiller',
        Priority = 791,
        InstanceCount = 1,
        BuilderType = 'Sea',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {4} },
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'HaveLessThanUnitsWithCategory', {5, categories.xss0304 } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.NAVAL,  'Enemy' }},
			
{ EBC, 'GreaterThanEconStorageCurrent', { 150, 4000 } },
            
        },
    },
    Builder {
        BuilderName = 'NC t3 battleship',
        PlatoonTemplate = 'T3SeaBattleship',
        Priority = 792,
        InstanceCount = 1,
        BuilderType = 'Sea',
        BuilderConditions = {
           
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.BATTLESHIP }},
            { UCBC, 'HaveLessThanUnitsWithCategory', {5, categories.BATTLESHIP } },
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.NAVAL,  'Enemy' }},
			
{ EBC, 'GreaterThanEconStorageCurrent', { 150, 4000 } },
            
        },
    },
    
}



