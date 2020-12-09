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
    BuilderGroupName = 'NC scu tele',
    BuildersType = 'StrategyBuilder',
    Builder {
        BuilderName = 'NC Tele SCU Strategy',
        Priority = 700,
        InstanceCount = 10,
     
        InterruptStrategy = true,
        OnStrategyActivate = function(self, aiBrain)
            Builders[self.BuilderName].Running = true
            local x,z = aiBrain:GetArmyStartPos()
            local faction = aiBrain:GetFactionIndex()
            local upgrades
            local removes
            if faction == 2 then
                upgrades = {'StabilitySuppressant', 'Teleporter'}
            elseif faction == 4 then
                upgrades = {'Shield', 'Teleporter'}
            end
            local SCUs = {}
            local possSCUs = AIUtils.GetOwnUnitsAroundPoint(aiBrain, categories.SUBCOMMANDER, {x,0,z}, 200)
            for k,v in possSCUs do
                table.insert(SCUs, v)
                if table.getn(SCUs) > 10 then
                    break
                end
            end
            for k,v in SCUs do
                if v.PlatoonHandle and aiBrain:PlatoonExists(v.PlatoonHandle) then
                    v.PlatoonHandle:RemoveEngineerCallbacksSorian()
                    v.PlatoonHandle:Stop()
                    v.PlatoonHandle:PlatoonDisbandNoAssign()
                end
                if v.NotBuildingThread then
                    KillThread(v.NotBuildingThread)
                    v.NotBuildingThread = nil
                end
                if v.ProcessBuild then
                    KillThread(v.ProcessBuild)
                    v.ProcessBuild = nil
                end
                v.BuilderManagerData.EngineerManager:RemoveUnit(v)
                IssueStop({v})
                IssueClearCommands({v})
                if v:HasEnhancement('Overcharge') then
                    local order = {
                        TaskName = "EnhanceTask",
                        Enhancement = "OverchargeRemove"
                    }
                    IssueScript({v}, order)
                elseif v:HasEnhancement('ResourceAllocation') then
                    local order = {
                        TaskName = "EnhanceTask",
                        Enhancement = "ResourceAllocationRemove"
                    }
                    IssueScript({v}, order)
                end
            end
            local plat = aiBrain:MakePlatoon('', '')
            aiBrain:AssignUnitsToPlatoon(plat, SCUs, 'attack', 'None')
            for k,v in SCUs do
                for x,z in upgrades do
                    if not v:HasEnhancement(z) then
                        local order = {
                            TaskName = "EnhanceTask",
                            Enhancement = z
                        }
                        IssueScript({v}, order)
                    end
                end
            end
            local allDead
            local upgradesFinished
            repeat
                WaitSeconds(5)
                allDead = true
                upgradesFinished = true
                if not aiBrain:PlatoonExists(plat) then
                    Builders[self.BuilderName].Running = false
                    return
                end
                for k,v in plat:GetPlatoonUnits() do
                    if not v.Dead then
                        allDead = false
                    end
                    if not v:HasEnhancement(upgrades[2]) then
                        upgradesFinished = false
                    end
                end
            until allDead or upgradesFinished

            if allDead then return end

            local targetLocation = Behaviors.GetHighestThreatClusterLocationSorian(aiBrain, plat)
            for k,v in SCUs do
                local telePos = AIUtils.RandomLocation(targetLocation[1],targetLocation[3])
                IssueTeleport({v}, telePos)
            end
            WaitSeconds(45)
            plat:HuntAISorian()
            Builders[self.BuilderName].Running = false
        end,
        PriorityFunction = function(self, aiBrain)
            if Builders[self.BuilderName].Running then
                return 100
            end
            local enemyIndex
            local returnval = 1
            if aiBrain:GetCurrentEnemy() then
                enemyIndex = aiBrain:GetCurrentEnemy():GetArmyIndex()
            else
                return returnval
            end

            if Random(1,10) == 7 then
                returnval = 100
            end

            return returnval
        end,
        BuilderConditions = {
            { SBC, 'NoRushTimeCheck', { 600 }},
            { MIBC, 'FactionIndex', {2, 4}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 10, 'SUBCOMMANDER' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.3}},
            
        },
        BuilderType = 'Any',
        RemoveBuilders = {},
        AddBuilders = {}
    },
}

BuilderGroup {
    BuilderGroupName = 'NClandbehavior_expansion',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NClandbaseguard_expansion',
        PlatoonTemplate = 'landbaseguardNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
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
        InstanceCount = 1,
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
        InstanceCount = 1,
        BuilderType = 'Any',
    },

  
    Builder {
        BuilderName = 'NCengihuntlandunits',
        PlatoonTemplate = 'StrikeForceMediumNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 360} },
            { SBC, 'LessThanGameTime', { 2399 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                        SearchRadius = 6000,
			ThreatSupport = 5,
            PrioritizedCategories = {

 'ENGINEER',
'MASSEXTRACTION',
               
                
                'COMMAND',
            
                'ALLUNITS',
            },
        },    
        InstanceCount = 10,
        BuilderType = 'Any',
    },



 
  Builder {
        BuilderName = 'NCmasshuntlandunits',
        PlatoonTemplate = 'StrikeForceMediumNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        BuilderConditions = { 
   
            { MIBC, 'GreaterThanGameTime', { 360} },
            { SBC, 'LessThanGameTime', { 2399 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
           
                        SearchRadius = 6000,
			ThreatSupport = 5,
            PrioritizedCategories = {
'MASSEXTRACTION',
                'ENGINEER',
                
                'COMMAND',
            
                'ALLUNITS',
            },
        },    
        InstanceCount = 10,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NCmasshuntlandunits_lategame',
        PlatoonTemplate = 'StrikeForceLargeNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 101,
        BuilderConditions = { 
   
            { MIBC, 'GreaterThanGameTime', { 2400} },
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
        InstanceCount = 10,
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
 { SBC, 'LessThanGameTime', { 600 } },	
{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAND * categories.MOBILE - categories.ENGINEER } },
			
      
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Land',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCT1_expansionprotect',
    BuildersType = 'FactoryBuilder',
     
    Builder {
        BuilderName = 'NC T1 Light Tank expansion',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 975,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER}},
         
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            
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
        BuilderName = 'NC T1 Light Tank - Tech 1',
        PlatoonTemplate = 'T1LandDFTank',
        Priority = 725,
        BuilderConditions = {
           
            { UCBC, 'HaveLessThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH1 } },
           
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            
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
          
			
            { UCBC, 'HaveLessThanUnitsWithCategory', { 50, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            
        },
        BuilderType = 'Land',
    },    

    Builder {
        BuilderName = 'NC T1 Mortar - Not T1',
        PlatoonTemplate = 'T1LandArtillery',
        Priority = 600,
        InstanceCount = 3,
        BuilderConditions = {
        
         
        
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY - categories.TECH1 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
            
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
  
    Builder {
        BuilderName = 'NC T2 MML',
        PlatoonTemplate = 'T2LandArtillery',
        Priority = 600,
        InstanceCount = 3,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ MIBC, 'FactionIndex', {3}},
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
		
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.05 }},
            
           
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
    },
    # T3 Artilery
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 700,
        InstanceCount = 3, 
        BuilderType = 'Land',
        BuilderConditions = {
          
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
        },
    },
    Builder {
        BuilderName = 'NC T3 Mobile Heavy Artillery - tough def',
        PlatoonTemplate = 'T3LandArtillery',
        Priority = 725,
        InstanceCount = 3,
        BuilderType = 'Land',
        BuilderConditions = {
    
	
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
        
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
        },
    },
 
    Builder {
        BuilderName = 'NC T3SniperBots',
        PlatoonTemplate = 'T3SniperBots',
        Priority = 700,
        BuilderType = 'Land',
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.LAND * categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitRatio', { 0.15, categories.LAND * categories.INDIRECTFIRE * categories.MOBILE, '<=', categories.LAND * categories.DIRECTFIRE * categories.MOBILE}},
          
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
         
            { TBC, 'HaveLessThreatThanNearby', { 'LocationType', 'AntiAir', 'Air' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
         
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.80, 1.05 }},
            
     
        },
        BuilderType = 'Land',
    },
}


            


    
    

