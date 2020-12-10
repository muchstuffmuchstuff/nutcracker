#***************************************************************************
#*
#**  File     :  /lua/ai/AIArtilleryBuilders.lua
#**
#**  Summary  : Default artillery/nuke/etc builders for skirmish
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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'


local AIUtils = import('/lua/ai/aiutilities.lua')


function CheckUnitRangeNC(aiBrain, locationType, unitType, category, factionIndex)

    # Find the unit's blueprint
    local template = import('/lua/BuildingTemplates.lua').BuildingTemplates[factionIndex or aiBrain:GetFactionIndex()]
    local buildingId = false
    for k,v in template do
        if v[1] == unitType then
            buildingId = v[2]
            break
        end
    end
    if not buildingId then
        WARN('*AI ERROR: Invalid building type - ' .. unitType)
        return false
    end

    local bp = __blueprints[buildingId]
    if not bp.Economy.BuildTime or not bp.Economy.BuildCostMass then
        WARN('*AI ERROR: Unit for EconomyCheckStructure is missing blueprint values - ' .. unitType)
        return false
    end

    local range = false
    for k,v in bp.Weapon do
        if not range or v.MaxRadius > range then
            range = v.MaxRadius
        end
    end
    if not range then
        WARN('*AI ERROR: No MaxRadius for unit type - ' .. unitType)
        return false
    end

    local basePosition = aiBrain:GetLocationPosition(locationType)

    # Check around basePosition for StructureThreat
    local unit = AIUtils.AIFindBrainTargetAroundPoint(aiBrain, basePosition, range, category)

    if unit then
        return true
    end
    return false
end

BuilderGroup {
    BuilderGroupName = 'NCExperimentalArtillery',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T4 Artillery Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 980,
		InstanceCount = 1,
        BuilderConditions = {
		
            { CheckUnitRangeNC, { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.STRUCTURE}},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.EXPERIMENTAL * categories.STRUCTURE * categories.ARTILLERY}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 11, categories.ENERGYPRODUCTION * categories.TECH3 } },
		
		
          
            { SIBC, 'GreaterThanEconEfficiency', { 0.95, 1.1}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
            { MIBC, 'FactionIndex', {1} },
           
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                    'T3ShieldDefense',
                    'T3ShieldDefense',
                    'T3ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
	
    Builder {
        BuilderName = 'NC T4EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 850,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.95, 1.1}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistRange = 150,
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'EXPERIMENTAL STRUCTURE'},
                Time = 120,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'ncNukeBuildersEngineerBuilders',
    BuildersType = 'EngineerBuilder',
     Builder {
        BuilderName = 'nc T3 Nuke Engineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
		InstanceCount = 1,
        BuilderConditions = {
			
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3 } },
         
		{ MIBC, 'FactionIndex', {1,2, 3}},
          
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.1}},
            
			
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T3StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'nc T3 Nuke lots of cash',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
		InstanceCount = 1,
        BuilderConditions = {
			
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENERGYPRODUCTION * categories.TECH3 } },
         
		{ MIBC, 'FactionIndex', {1,2, 3}},
          
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.1, 1.1}},
            
			
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T3StrategicMissile',
                },
                Location = 'LocationType',
            }
        }
    },

      Builder {
        BuilderName = 'NC Seraphim Exp Nuke Engineer',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 959,
		InstanceCount = 1,
        BuilderConditions = {
		
			
			
			
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
			
			
          
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.1}},
            
            { IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4Artillery',
                },
                Location = 'LocationType',
            }
        }
    },
      Builder {
        BuilderName = 'NC Assist Build t4',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 999,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.4}},
            
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 150,
                BeingBuiltCategories = {'STRUCTURE STRATEGIC EXPERIMENTAL'},
                Time = 120,
            },
        }
    },
}

BuilderGroup {
    BuilderGroupName = 'NCartyinrange',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC arty in range',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1200,
        BuilderConditions = {
            {CheckUnitRangeNC, { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
     { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE * categories.xab2307}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
		
           
            { SIBC, 'GreaterThanEconEfficiency', { 1.0, 1.3}},
		
            { IBC, 'BrainNotLowPowerMode', {} },
          
			
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
            
                BuildStructures = {
                    'T3Artillery',

                },
                Location = 'LocationType',
            }
        }
    },
 
    Builder {
        BuilderName = 'NC Rapid T3 Artillery in range',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1201,
        BuilderConditions = {
	{ SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE * categories.xab2307 }},
    { CheckUnitRangeNC, { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ENERGYPRODUCTION * categories.TECH3 } },
           
	
            { SIBC, 'GreaterThanEconEfficiency', { 0.95, 1.1}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'T4BuildingCheck', {} },
            
           
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				#T4 = true,
			
                BuildStructures = {
                    'T3RapidArtillery',
'T3ShieldDefense',
'T3ShieldDefense',
'T3ShieldDefense',
'T3ShieldDefense',
'T3ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 999,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.95, 1.1}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 250,
                BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
                Time = 120,
            },
        }
    },
}
    

BuilderGroup {
    BuilderGroupName = 'NCT3Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Artillery',
        PlatoonTemplate = 'T3ArtilleryStructureSorian',
        Priority = 1,
        InstanceCount = 1000,
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT4Artillerybehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T4 Artillery',
        PlatoonTemplate = 'T4ArtilleryStructureSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 1,
        InstanceCount = 1000,
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}



BuilderGroup {
    BuilderGroupName = 'NCNukebehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T3 Nuke Silo',
        PlatoonTemplate = 'T3NukeSorian',
        Priority = 1,
        InstanceCount = 10,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T4 Nuke Silo',
        PlatoonTemplate = 'T4NukeSorian',
        Priority = 1,
        InstanceCount = 10,
        BuilderType = 'Any',
    },
}