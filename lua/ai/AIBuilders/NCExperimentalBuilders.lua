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
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
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
        BuilderName = 'nc T4 Exp Air attack command focus',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NCairexperimentalattack_commandfocus',
    
        Priority = 1500,
        InstanceCount = 50,
        FormRadius = 500,
        AggressiveMove = false,
        SearchRadius = 80000,
        BuilderType = 'Any',
        BuilderConditions = {
            {CF,'AirExpRandomizer',{1}},
            { MIBC, 'FactionIndex', {2,3}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
     
         
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

            { SBC, 'NoRushTimeCheck', { 0 }},
        },
      
            
            UseMoveOrder = true,
            PrioritizedCategories = { 'LAND MOBILE',
    
    },
},
    Builder {
        BuilderName = 'nc T4 Exp Air attack land focus',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NCairexperimentalattack_landfocus',
    
        Priority = 1500,
        InstanceCount = 50,
        FormRadius = 500,
        AggressiveMove = false,
        SearchRadius = 80000,
        BuilderType = 'Any',
        BuilderConditions = {
            {CF,'AirExpRandomizer',{2}},
            { MIBC, 'FactionIndex', {2,3}},
            { MIBC, 'GreaterThanGameTime', { 1200} },
     
         
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

            { SBC, 'NoRushTimeCheck', { 0 }},
        },
      
            
            UseMoveOrder = true,
            PrioritizedCategories = { 'LAND MOBILE',
    
    },
},
Builder {
    BuilderName = 'nc T4 Exp Air attack energy focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_energyfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{3}},
        { MIBC, 'FactionIndex', {2,3}},
        { MIBC, 'GreaterThanGameTime', { 1200} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'ENERGYPRODUCTION',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack mex focus',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattack_mexfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{4}},
        { MIBC, 'FactionIndex', {2,3}},
        { MIBC, 'GreaterThanGameTime', { 1200} },

        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },
        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'MASSEXTRACTION',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack command focus sera',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattacksera_commandfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{1}},
        { MIBC, 'FactionIndex', {4}},
        { MIBC, 'GreaterThanGameTime', { 1200} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'LAND MOBILE',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack land focus sera',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattacksera_landfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{2}},
        { MIBC, 'FactionIndex', {4}},
        { MIBC, 'GreaterThanGameTime', { 1200} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'LAND MOBILE',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack energy focus sera',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattacksera_energyfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = { 
        {CF,'AirExpRandomizer',{3}},
        { MIBC, 'FactionIndex', {4}},
        { MIBC, 'GreaterThanGameTime', { 1200} },

        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'ENERGYPRODUCTION',

},
},
Builder {
    BuilderName = 'nc T4 Exp Air attack mex focus sera',
    PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
    PlatoonTemplate = 'NCairexperimentalattacksera_mexfocus',

    Priority = 1500,
    InstanceCount = 50,
    FormRadius = 500,
    AggressiveMove = false,
    SearchRadius = 80000,
    BuilderType = 'Any',
    BuilderConditions = {
        {CF,'AirExpRandomizer',{4}},
        { MIBC, 'FactionIndex', {4}},
        { MIBC, 'GreaterThanGameTime', { 1200} },
 
     
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL AIR' } },

        { SBC, 'NoRushTimeCheck', { 0 }},
    },
  
        
        UseMoveOrder = true,
        PrioritizedCategories = { 'MASSEXTRACTION',

},
},

}



BuilderGroup {
    BuilderGroupName = 'NCMobileAirExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	
  
    Builder {
        BuilderName = 'nc Air Exp1 sera and cyb get r done',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1300,
        DelayEqualBuildPlattons = {'MobileExperimental_air', 120},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {3,4}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_air' }},
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoNukeRush',{}},
           
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * (categories.AIR + categories.LAND + categories.STRUCTURE) }},
            
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
       
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
			
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'nc Air exp aeon get r done',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1300,
        DelayEqualBuildPlattons = {'MobileExperimental_air', 120},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_air' }},
            {CF, 'NoDukeNukem',{}},
            {CF, 'Noparagonrush',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF, 'NoNukeRush',{}},
           
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * (categories.AIR + categories.LAND + categories.STRUCTURE) }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
   
   
          
       
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
			
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },

    


    Builder {
        BuilderName = 'nc air Exp continuation of builds',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1300,
        DelayEqualBuildPlattons = {'MobileExperimental_air_continuation', 180},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2,3, 4}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_air_continuation' }},
            
            { EBC, 'GreaterThanEconStorageCurrent', { 20000, 10000 } },
           
       
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
			
                BuildStructures = {
                    'T4AirExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    

    Builder {
        BuilderName = ' NC T2 Assist Experimental Mobile Air',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 970,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
       --
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 80,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 300,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3  Assist Experimental Mobile Air',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 970,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
       --
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 80,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 300,
            },
        }
    },
 
}

BuilderGroup {
    BuilderGroupName = 'ncMobileLandExperimentalbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'nc T4 Exp Land attack',
        PlatoonAddPlans = {'PlatoonCallForHelpAISorian'},
        PlatoonTemplate = 'NClandexperimentalattack',
    
        Priority = 1500,
        InstanceCount = 50,
        FormRadius = 250,
        AggressiveMove = false,
        SearchRadius = 80000,
        BuilderType = 'Any',
        BuilderConditions = {
            
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'EXPERIMENTAL LAND' } },
			
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        UseMoveOrder = true,
        PrioritizedCategories = { 

            'COMMAND',
        }, 
       
    },
 

}



BuilderGroup {
    BuilderGroupName = 'NCMobileLandExperimental',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Land Exp1 Engineer 1',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'MobileExperimental_land', 30},

        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { MIBC, 'FactionIndex', {2, 3, 4}},
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF, 'NoNukeRush',{}},
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_land' }},
         
          
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 5000 } },
           
          
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
          
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * (categories.AIR + categories.LAND + categories.STRUCTURE) }},
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
            
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC Land Exp1 water map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 990,
        DelayEqualBuildPlattons = {'MobileExperimental_land', 30},

        InstanceCount = 1,
        BuilderConditions = {

            { MIBC, 'FactionIndex', { 1,3}},
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_land' }},
            { SBC, 'IsIslandMap', { true } },
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoRapidFireRush',{}},
            {CF, 'NoNukeRush',{}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL}},
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
            
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
    

    Builder {
        BuilderName = 'NC Land Exp1 continuation',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 975,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'MobileExperimental_land_continuation', 180},

        BuilderConditions = {
            { MIBC, 'FactionIndex', {1,2, 3, 4}},
            { MIBC, 'GreaterThanGameTime', { 1800} },
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_land' }},
            
           

            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.EXPERIMENTAL * categories.LAND }},
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 10000 } },
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.ENERGYPRODUCTION * categories.TECH3}},
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
            
                BuildStructures = {
                    'T4LandExperimental1',
                },
                Location = 'LocationType',
            }
        }
    },
   
  
    Builder {
        BuilderName = 'NC T2 Engineer Assist Experimental Mobile Land',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 950,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND }},
       --
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 10000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 80,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE LAND'},
                Time = 300,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Experimental Mobile Land',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 950,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.LAND}},
       --
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 10000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 80,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE LAND'},
                Time = 300,
            },
        }
    },
}






BuilderGroup {
    BuilderGroupName = 'NCEconomicExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Econ Exper Engineer',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 950,
		InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 2400} },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY) * categories.TECH3 }},
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.ENERGYPRODUCTION * categories.TECH3}},
		#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 6, categories.MASSPRODUCTION * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
		
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 15000, 15000 } },
            
		
			
			
			
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
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 800,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 4800} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC}},
            --- 
            
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
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 951,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2}},
            { MIBC, 'GreaterThanGameTime', { 4800} },
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC }},
            --- 
            
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

BuilderGroup {
    BuilderGroupName = 'NC Satelite',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'Nc Satelite standard',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'MobileExperimental_satelite', 30},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_satelite' }},
            {CF, 'NoDukeNukem',{}},
            {CF, 'NoSateliteRush',{}},
            {CF, 'NoNukeRush',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 2000, 10000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * (categories.ANTIMISSILE + categories.NUKE + categories.ARTILLERY * categories.EXPERIMENTAL) }},
   
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 6,
            Construction = {
                BuildClose = true,
                #T4 = true,
                AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4SatelliteExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'Nc Satelite BIG N JUICY',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 1050,
        DelayEqualBuildPlattons = {'MobileExperimental_satelite_continuation', 180},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1}},
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { UCBC, 'CheckBuildPlattonDelay', { 'MobileExperimental_satelite_continuation' }},
            { EBC, 'GreaterThanEconStorageCurrent', { 20000, 10000 } },
            {CF, 'NoDukeNukem',{}},
           
            
   
        },
        BuilderType = 'Any',
        BuilderData = {
            MinNumAssistees = 6,
            Construction = {
                BuildClose = true,
                #T4 = true,
                AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4SatelliteExperimental',
                },
                Location = 'LocationType',
            }
        }
    },
    
    Builder {
        BuilderName = 'NC Satelite Assist t2',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1000,
        InstanceCount = 5,
        BuilderConditions = {
         
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 100 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'Nc Satelite Assist t3',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1050,
        InstanceCount = 5,
        BuilderConditions = {
           
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
            ---
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 100 } }, 
           
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC Satelite Assist t2 juicy',
        PlatoonTemplate = 'T2EngineerAssist',
        Priority = 1200,
        InstanceCount = 10,
        BuilderConditions = {
          
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
       --- 
       { EBC, 'GreaterThanEconStorageCurrent', { 10000, 7000 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'Nc Satelite Assist t3 juicy',
        PlatoonTemplate = 'T3EngineerAssist',
        Priority = 1200,
        InstanceCount = 10,
        BuilderConditions = {
           
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ORBITALSYSTEM }},
            --- 
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 7000 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'EXPERIMENTAL ORBITALSYSTEM'},
                Time = 60,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NC Satelite Behavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Orbital behavior',
        PlatoonTemplate = 'NC Orbital',
        PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 800,
        BuilderConditions = {
            { SBC, 'NoRushTimeCheck', { 0 }},
        },
        FormRadius = 100,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            SearchRadius = 6000,
            PrioritizedCategories = { categories.MASSEXTRACTION }, # list in order
        },
    },
}