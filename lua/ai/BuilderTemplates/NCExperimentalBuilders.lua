#***************************************************************************
#*
#**  File     :  /lua/ai/SorianExperimentalBuilders.lua
#**
#**  Summary  : Default experimental builders for skirmish
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
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'

local SUtils = import('/lua/AI/sorianutilities.lua')

local AIAddBuilderTable = import('/lua/ai/AIAddBuilderTable.lua')

function T4LandAttackCondition(aiBrain, locationType, targetNumber)
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
	local SInBC = import('/lua/editor/SorianInstantBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	if aiBrain:GetCurrentEnemy() then
		local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
		local enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
		#local enemyTML = aiBrain:GetNumUnitsAroundPoint( categories.TECH2 * categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE, {estartX, 0, estartZ}, 100, 'Enemy' )
		local enemyT3PD = aiBrain:GetNumUnitsAroundPoint( categories.TECH3 * categories.DEFENSE * categories.DIRECTFIRE, {estartX, 0, estartZ}, 100, 'Enemy' )
		--targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiSurface')
		targetNumber = SUtils.GetThreatAtPosition( aiBrain, {estartX, 0, estartZ}, 1, 'AntiSurface', {'Commander', 'Air', 'Experimental'}, enemyIndex )
		targetNumber = targetNumber + (enemyT3PD * 54)# + (enemyTML * 54)
	end

    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    --local surThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.LAND * categories.EXPERIMENTAL, position, radius * 2.5 )
	local surThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.LAND * categories.EXPERIMENTAL)
    if surThreat >= targetNumber * .6 then
        return true
	--elseif UC.UnitCapCheckGreater(aiBrain, .99) then
	--	return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif SInBC.PoolGreaterAtLocationExp(aiBrain, locationType, 4, categories.MOBILE * categories.LAND * categories.EXPERIMENTAL) then
		return true
    end
    return false
end

function T4AirAttackCondition(aiBrain, locationType, targetNumber)
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
	local SInBC = import('/lua/editor/SorianInstantBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	if aiBrain:GetCurrentEnemy() then
		local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
		local enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
		targetNumber = SUtils.GetThreatAtPosition( aiBrain, {estartX, 0, estartZ}, 1, 'AntiAir', {'Air'}, enemyIndex )
		#targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiAir' )
	end

    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    local surThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.AIR * categories.EXPERIMENTAL, position, radius * 2.5)
    if surThreat > targetNumber * .6 then
        return true
	--elseif UC.UnitCapCheckGreater(aiBrain, .99) then
	--	return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif SInBC.PoolGreaterAtLocationExp(aiBrain, locationType, 4, categories.MOBILE * categories.AIR * categories.EXPERIMENTAL) then
		return true
    end
    return false
end

 






BuilderGroup {
    BuilderGroupName = 'ncMobileAirExperimentalbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'nc T4 Exp Air attack',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NCairexperimentalattack',
    
        Priority = 1500,
        InstanceCount = 50,
        FormRadius = 250,
        AggressiveMove = true,
        SearchRadius = 80000,
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL MOBILE AIR' } },
			
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'COMMAND', 'ALLUNITS' }, 
        },
    },

}

BuilderGroup {
    BuilderGroupName = 'NCMobileAirExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	
    Builder {
        BuilderName = 'nc T3 Air Exp1 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 970,
        BuilderConditions = {
 
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.AIR }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.TECH3 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.LAND }},

			
		
          
	
            { IBC, 'BrainNotLowPowerMode', {} },
			
			{ SIBC, 'T4BuildingCheck', {} },
		
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = false,
				#T4 = true,
                NearMarkerType = 'Protected Experimental Construction',
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
 Builder {
        BuilderName = 'nc T2 help czar',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {

            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1} },
 { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},

        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 350,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
             
            },
        }
    },
    Builder {
        BuilderName = 'nc t3 help czar ',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {
    { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 350,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                
            },
        }
    },
}






BuilderGroup {
    BuilderGroupName = 'NCEconomicExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Econ Exper Engineer',
        PlatoonTemplate = 'AeonT3EngineerBuilder',
        Priority = 950,
		InstanceCount = 1,
        BuilderConditions = {
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
		#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
			{ IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
            Construction = {
                BuildClose = false,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4EconExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 Engineer Assist Experimental Economic',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 800,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Experimental Economic',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 951,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
        }
    },
}