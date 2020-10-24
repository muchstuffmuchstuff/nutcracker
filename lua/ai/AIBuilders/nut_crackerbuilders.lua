--[[
    File    :   /lua/AI/AIBuilders/nut_crackerbuilders.lua
    Author  :   muchstuff
    Summary :
        All the builders that are used by Nut Cracker AI.
        The keys for these builders are included AI/AIBaseTemplates/nut_cracker.lua.
]]

local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'




BuilderGroup {
    BuilderGroupName = 'NCEngineerFactoryConstruction',
    BuildersType = 'EngineerBuilder',
    # =============================
    #     Quantum Gate Builders
    # =============================
    Builder {
        BuilderName = 'NC T3 Gate Engineernutcraacker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 980, #850,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH3' }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSPRODUCTION TECH3' }},
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 2, 'GATE TECH3 STRUCTURE' }},
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Gate' } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .85 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },    
    Builder {
        BuilderName = 'NC T3 Gate Engineer extra juice',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1200,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH3' }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSPRODUCTION TECH3' }},
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 5, 'GATE TECH3 STRUCTURE' }},
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 3.0, 3.2} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Gate' } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .85 } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },              
}

######

BuilderGroup {
    BuilderGroupName = 'NCEngineerEnergyBuilders',
    BuildersType = 'EngineerBuilder',
    # =====================================
    #     T3 Engineer Resource Builders
    # =====================================
    Builder {
        BuilderName = 'NC T3 Power Engineer nutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1001,
        InstanceCount = 1, 
        BuilderType = 'Any',
        BuilderConditions = {
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ENERGYPRODUCTION TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.1 }},
			{ SIBC, 'LessThanEconEfficiencyOverTime', { 2.0, 1.3 }},
			{ SIBC, 'LessThanEconEfficiency', { 2.0, 1.3 }},
			#{ SIBC, 'LessThanEconTrend', { 100000, 450}},
        },
        BuilderData = {
            Construction = {
				AdjacencyCategory = 'FACTORY',
				AvoidCategory = 'ENERGYPRODUCTION TECH3',
				maxUnits = 4,
				maxRadius = 20,
                BuildStructures = {
                    'T3EnergyProduction',
                },
            }
        }
    },
}

######

BuilderGroup {
    BuilderGroupName = 'NCTime Exempt Extractor Upgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'T1 Mass Extractor Upgrade Storage Based NC',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 0, #200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 600, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION' }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T1 Mass Extractor Upgrade Bleed Off NC',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION' }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T1 Mass Extractor Upgrade Timeless Single NC',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
          
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'T1 Mass Extractor Upgrade Timeless Two NC',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
         
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'T1 Mass Extractor Upgrade Timeless LOTS NC',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 4,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 15, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Storage Based NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 0, #200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Bleed Off NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Timeless NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },            
          
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },  
    
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Timeless Multiple NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 3,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },			
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
         
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },      
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Timeless - Later NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },            

            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },    
    Builder {
        BuilderName = 'T2 Mass Extractor Upgrade Timeless Multiple - Later NC',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 3,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },			
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
      
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

#####

BuilderGroup {
    BuilderGroupName = 'NCEngineerFirebaseBuilders',
    BuildersType = 'EngineerBuilder',
    
    ########################################
    ## Builds fire bases
    ########################################
   

    Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - Aeon nutcracker push',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1001,
        InstanceCount = 10,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 900, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.3, 0.4 }},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = true,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 900,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {



'T2GroundDefense',
'T3AADefense',
'T2StrategicMissileDefense',
'T3AADefense',
'T3ShieldDefense',
'T2Radar',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T2StrategicMissile',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',




              
                }
            }
        }
    },

  Builder {
        BuilderName = ' NC T3 Expansion Area Firebase Engineer - Aeon - rapid fire',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1200,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 1700, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.EXPERIMENTAL}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
                        { SIBC, 'GreaterThanEconIncome', {17, 950}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.6 }},
			{ SBC, 'MapGreaterThan', { 2000, 2000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = true,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 1700,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {



'T2GroundDefense',
'T3AADefense',
'T2StrategicMissileDefense',
'T3AADefense',
'T3ShieldDefense',
'T2Radar',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T2StrategicMissile',
'T3RapidArtillery',
'T3RapidArtillery',
'T3RapidArtillery',
'T3RapidArtillery',
'T3RapidArtillery',




              
                }
            }
        }
    },


 Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - Aeon nuke',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1198,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 1900, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.EXPERIMENTAL}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
                        { SIBC, 'GreaterThanEconIncome', {17, 950}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.6 }},
			{ SBC, 'MapGreaterThan', { 2000, 2000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = true,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 1900,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {



'T2GroundDefense',
'T3AADefense',
'T2StrategicMissileDefense',
'T3AADefense',
'T3ShieldDefense',
'T2Radar',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T2StrategicMissile',
'T3StrategicMissile',
'T3StrategicMissile',
'T3StrategicMissile',
'T3StrategicMissile',
'T3StrategicMissile',
'T3StrategicMissile',




              
                }
            }
        }
    },




 Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - Aeon - infinite energy',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 1400,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 1900, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
		#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.EXPERIMENTAL * categories.ECONOMIC}},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
                        { SIBC, 'GreaterThanEconIncome', {17, 950}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.6 }},
			{ SBC, 'MapGreaterThan', { 2000, 2000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = true,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 1900,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {



'T3StrategicMissileDefense',
'T3ShieldDefense',
'T3ShieldDefense',
'T4EconExperimental',
'T3ShieldDefense',
'T3ShieldDefense',
'T3ShieldDefense',
'T3ShieldDefense',
'T2Radar',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',
'T3AADefense',





              
                }
            }
        }
    },

     Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - nutcracker',
        PlatoonTemplate = 'CybranT3EngineerBuilderSorian',
        Priority = 900,
        InstanceCount = 2,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 700, 'Expansion Area', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.1 }},
			{ SBC, 'MapGreaterThan', { 500, 500 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 700,
                NearMarkerType = 'Expansion Area',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 20,
                BuildStructures = {

'T2EngineerSupport',
'T2EngineerSupport',


					'T3Artillery',
'T3Artillery',
		
                }
            }
        }
    },
   

   
    Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - Cybran nutcracker',
        PlatoonTemplate = 'CybranT3EngineerBuilderSorian',
        Priority = 900,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 700, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { .9, 1.2 }},
			{ SBC, 'MapGreaterThan', { 500, 500 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 700,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 20,
                BuildStructures = {

				
'T2EngineerSupport',
'T2EngineerSupport',



					'T3Artillery',
'T3Artillery',


                }
            }
        }
    },

    Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer all in',
        PlatoonTemplate = 'UEFT3EngineerBuilderSorian',
        Priority = 1200,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 1900, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SBC, 'MapGreaterThan', { 2000, 2000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 1900,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {



'T3GroundDefense',
'T3AADefense',
'T2StrategicMissileDefense',
'T3AADefense',
'T3ShieldDefense',
'T2Radar',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T2StrategicMissile',
'T4Artillery',
'T4Artillery',
'T4Artillery',
'T4Artillery',
'T4Artillery',



				}
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Expansion Area Firebase Engineer - Seraphim nutcracker',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 1000,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'CanBuildFirebase', { 'LocationType', 825, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
            #{ UCBC, 'UnitCapCheckLess', { .75 } },
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', false } },
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.3, 0.4 }},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 825,
                NearMarkerType = 'Defensive Point',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 10,
                BuildStructures = {
				


'T2GroundDefense',
'T3AADefense',
'T2StrategicMissileDefense',
'T3AADefense',
'T3ShieldDefense',
'T2Radar',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T2StrategicMissile',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',
'T3Artillery',



                }
            }
        }
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCT3NukeDefenses',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'Sorian T3 Anti-Nuke Engineer Near Factory - Firstnutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 960,
		InstanceCount = 2,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 2, 'ANTIMISSILE TECH3 STRUCTURE' } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
            #{ SIBC, 'GreaterThanEconIncome', { 2.5, 100}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',

                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NCT3 Anti-Nuke Engineer Near Factorynutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 0, #945,
		InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			{ UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
            #{ SIBC, 'GreaterThanEconIncome', { 2.5, 100}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NCT3 Anti-Nuke Engineer - Emergnutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1301,
		InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 2, 'ANTIMISSILE TECH3 STRUCTURE' } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
            #{ SIBC, 'GreaterThanEconIncome', { 2.5, 100}},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 8,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
  
    Builder {
        BuilderName = 'NCT3 Anti-Nuke Engineer - Emerg 2nutcvracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1301,
		InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ANTIMISSILE TECH3 STRUCTURE' } },
            { UCBC, 'BuildingLessAtLocation', { 'LocationType', 1, 'ANTIMISSILE TECH3 STRUCTURE' } },
			{ SBC, 'HaveComparativeUnitsWithCategoryAndAllianceAtLocation', { 'LocationType', true, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE, categories.STRUCTURE * categories.NUKE * categories.TECH3, 'Enemy'}},
            #{ SIBC, 'GreaterThanEconIncome', { 2.5, 100}},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
            { UCBC, 'UnitCapCheckLess', { .95 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 8,
            Construction = {
                BuildClose = false,
                AdjacencyCategory = 'FACTORY -NAVAL',
                AdjacencyDistance = 100,
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NCT3 Engineer Assist Anti-Nuke Emergnutcracker',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NUKE SILO STRUCTURE', 'Enemy'}},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'EngineerNeedsAssistance', { true, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'ANTIMISSILE TECH3 STRUCTURE'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Anti-Nuke Emerg 2',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1302,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'ANTIMISSILE TECH3 STRUCTURE' } },
			{ SBC, 'HaveComparativeUnitsWithCategoryAndAllianceAtLocation', { 'LocationType', true, categories.ANTIMISSILE * categories.TECH3 * categories.STRUCTURE, categories.STRUCTURE * categories.NUKE * categories.TECH3, 'Enemy'}},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'EngineerNeedsAssistance', { true, 'LocationType', {'ANTIMISSILE TECH3 STRUCTURE'} }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 250,
                BeingBuiltCategories = {'ANTIMISSILE TECH3 STRUCTURE'},
                Time = 60,
            },
        }
    },
}

#####

BuilderGroup {
    BuilderGroupName = 'NCShieldUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'Sorian T2 Shield Cybran 1nutcracker',
        PlatoonTemplate = 'T2Shield1',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 5, 150}},
            { MIBC, 'FactionIndex', {3, 3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 2',
        PlatoonTemplate = 'T2Shield2',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 5, 200}},
            { MIBC, 'FactionIndex', {3, 3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 3',
        PlatoonTemplate = 'T2Shield3',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 5, 300}},
            { MIBC, 'FactionIndex', {3, 3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield Cybran 4',
        PlatoonTemplate = 'T2Shield4',
        Priority = 500,
        InstanceCount = 5,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 5, 400}},
            { MIBC, 'FactionIndex', {3, 3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Shield UEF Seraphim',
        PlatoonTemplate = 'T2Shield',
        Priority = 930,
        InstanceCount = 2,
        BuilderConditions = {
            { SIBC, 'GreaterThanEconIncome',  { 7, 350}},
            { MIBC, 'FactionIndex', {1, 4}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 10, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
        },
        BuilderType = 'Any',
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCT2Shields',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T2 Shield D Engineer Near Energy Productionnutcracker',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 930,
        BuilderConditions = {
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 30, categories.SHIELD * categories.TECH2 * categories.STRUCTURE}},
			{ UCBC, 'UnitsLessAtLocation', { 'LocationType', 15, categories.SHIELD * categories.TECH2 * categories.STRUCTURE }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { IBC, 'BrainNotLowPowerMode', {} },
 { MIBC, 'FactionIndex', {3, 3}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.9, 1.2 } },
            { UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, ENERGYPRODUCTION EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T2ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
}

####


BuilderGroup {
    BuilderGroupName = 'NCT3Shields',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Shield D Engineer Factory Adjnutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 975,
InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 30, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
            { MIBC, 'FactionIndex', {1, 2, 4}},
			{ UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 4, 'SHIELD STRUCTURE TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'FACTORY, STRUCTURE EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },

 Builder {
        BuilderName = 'NC T3 Shield D Engineer beside econutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1500,
InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 30, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
            { MIBC, 'FactionIndex', {2}},
				{ UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 4, 'SHIELD STRUCTURE TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.9 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 10,
            Construction = {
                AdjacencyCategory = 'EXPERIMENTAL ECONOMIC',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',

                },
                Location = 'LocationType',
            }
        }
    },
Builder {
        BuilderName = 'NC T3 Shield D Engineer beside t4artynutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1500,
InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 30, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
            { MIBC, 'FactionIndex', {1}},
				{ UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 4, 'SHIELD STRUCTURE TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 10,
            Construction = {
                AdjacencyCategory = 'ARTILLERY',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',

                },
                Location = 'LocationType',
            }
        }
    },
Builder {
        BuilderName = 'NC T3 Shield D Engineer beside expnukenutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1500,
InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 30, categories.SHIELD * categories.TECH3 * categories.STRUCTURE} },
            { MIBC, 'FactionIndex', {4}},
				{ UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 4, 'SHIELD STRUCTURE TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 10,
            Construction = {
                AdjacencyCategory = 'EXPERIMENTAL STRUCTURE',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T3ShieldDefense',

                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Shield D Engineer Factory Adj Cybrannutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, categories.ENGINEER * categories.TECH3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 16, categories.SHIELD * categories.TECH2 * categories.STRUCTURE} },
            { MIBC, 'FactionIndex', {3}},
			{ UCBC, 'LocationEngineersBuildingLess', { 'LocationType', 1, 'SHIELD STRUCTURE TECH2' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2 }},
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                AdjacencyCategory = 'STRUCTURE EXPERIMENTAL, ENERGYPRODUCTION TECH3, ENERGYPRODUCTION TECH2',
                AdjacencyDistance = 100,
                BuildClose = false,
                BuildStructures = {
                    'T2ShieldDefense',
                },
                Location = 'LocationType',
            }
        }
    },
}

#####

BuilderGroup {
    BuilderGroupName = 'NCExpResponseFormBuilders',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NCBomberAttackExpResponse',
        PlatoonTemplate = 'BomberAttackSorian',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 1000,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
			SearchRadius = 10000,
            PrioritizedCategories = {
                'EXPERIMENTAL LAND',
                'EXPERIMENTAL NAVAL',
				'EXPERIMENTAL STRUCTURE',
                'COMMAND',
                'ENERGYPRODUCTION DRAGBUILD',
                'MASSFABRICATION',
                'MASSEXTRACTION',
                'SHIELD',
                'ANTIAIR STRUCTURE',
                'DEFENSE STRUCTURE',
                'STRUCTURE',
                'MOBILE ANTIAIR',
                'ALLUNITS',
            },
        },
        BuilderConditions = {
            #{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL LAND, EXPERIMENTAL NAVAL', 'Enemy'}},
			{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 10, 'AIR MOBILE BOMBER TECH2, AIR MOBILE BOMBER TECH3' } },
			{ SBC, 'T4ThreatExists', {{'Land', 'Naval', 'Structure'}, (categories.LAND + categories.NAVAL + categories.STRUCTURE + categories.ARTILLERY)}},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    Builder {
        BuilderName = 'NCFighterAttackExpResponse',
        PlatoonTemplate = 'AirAttackSorian',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 1000,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
			SearchRadius = 10000,
            PrioritizedCategories = {
                'EXPERIMENTAL AIR',
				'AIR MOBILE BOMBER',
				'AIR MOBILE GROUNDATTACK',
				'AIR MOBILE ANTIAIR',
				'AIR MOBILE ANTINAVY',
				'AIR MOBILE',
            },
        },
        BuilderConditions = {
            #{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
			{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 30, 'AIR MOBILE ANTIAIR TECH1, AIR MOBILE ANTIAIR TECH3' } },
			{ SBC, 'T4ThreatExists', {{'Air'}, categories.AIR}},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    Builder {
        BuilderName = 'NCBomberAttackThreatResponse',
        PlatoonTemplate = 'BomberAttackSorian',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 1200,
        InstanceCount = 20,
        BuilderType = 'Any',
        BuilderData = {
			SearchRadius = 10000,
            PrioritizedCategories = {
                'STRUCTURE STRATEGIC EXPERIMENTAL',
				'EXPERIMENTAL ARTILLERY OVERLAYINDIRECTFIRE',
				'EXPERIMENTAL ORBITALSYSTEM',
                'STRUCTURE STRATEGIC TECH3',
                'COMMAND',
                'ENERGYPRODUCTION DRAGBUILD',
                'MASSFABRICATION',
                'MASSEXTRACTION',
                'SHIELD',
                'ANTIAIR STRUCTURE',
                'DEFENSE STRUCTURE',
                'STRUCTURE',
                'MOBILE ANTIAIR',
                'ALLUNITS',
            },
        },
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'STRUCTURE STRATEGIC TECH3, STRUCTURE STRATEGIC EXPERIMENTAL, EXPERIMENTAL ARTILLERY OVERLAYINDIRECTFIRE, EXPERIMENTAL ORBITALSYSTEM', 'Enemy'}},
			#{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 40, 'AIR MOBILE BOMBER TECH2, AIR MOBILE BOMBER TECH3' } },
			{ AirAttackCondition, { 'LocationType', 90 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    Builder {
        BuilderName = 'NC T2/T3 Bomber Attack Weak Enemy Response',
        PlatoonTemplate = 'BomberAttackSorian',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 0, #995,
        InstanceCount = 1,
        BuilderType = 'Any',
        BuilderData = {
			SearchRadius = 10000,
            PrioritizedCategories = {
				'EXPERIMENTAL ENERGYPRODUCTION STRUCTURE',
                'STRUCTURE STRATEGIC EXPERIMENTAL',
				'EXPERIMENTAL ARTILLERY OVERLAYINDIRECTFIRE',
				'EXPERIMENTAL ORBITALSYSTEM',
                'STRUCTURE STRATEGIC TECH3',
				'ENERGYPRODUCTION DRAGBUILD',
				'COMMAND',
				'ENGINEER',
				'MASSEXTRACTION',
                'MOBILE LAND',
				'MASSFABRICATION',
                'SHIELD',
                'ANTIAIR STRUCTURE',
                'DEFENSE STRUCTURE',
                'STRUCTURE',
                'COMMAND',
                'MOBILE ANTIAIR',
                'ALLUNITS',
            },
        },
        BuilderConditions = {
            { SBC, 'PoolThreatGreaterThanEnemyBase', {'LocationType', categories.MOBILE * categories.AIR - categories.SCOUT - categories.INTELLIGENCE, 'AntiAir', 'AntiSurface', 1}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, 'FACTORY TECH2 AIR, FACTORY TECH3 AIR' }},
			{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 40, 'AIR MOBILE BOMBER TECH2, AIR MOBILE BOMBER TECH3' } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    Builder {
        BuilderName = 'NCT1 Bomber Attack Weak Enemy Response',
        PlatoonTemplate = 'BomberAttackSorian',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 0, #995,
        InstanceCount = 1,
        BuilderType = 'Any',
        BuilderData = {
			SearchRadius = 10000,
            PrioritizedCategories = {
				'EXPERIMENTAL ENERGYPRODUCTION STRUCTURE',
                'STRUCTURE STRATEGIC EXPERIMENTAL',
				'EXPERIMENTAL ARTILLERY OVERLAYINDIRECTFIRE',
				'EXPERIMENTAL ORBITALSYSTEM',
                'STRUCTURE STRATEGIC TECH3',
				'ENERGYPRODUCTION DRAGBUILD',
				'ENGINEER',
				'MASSEXTRACTION',
                'MOBILE LAND',
				'MASSFABRICATION',
                'SHIELD',
                'ANTIAIR STRUCTURE',
                'DEFENSE STRUCTURE',
                'STRUCTURE',
                'COMMAND',
                'MOBILE ANTIAIR',
                'ALLUNITS',
            },
        },
        BuilderConditions = {
            { SBC, 'PoolThreatGreaterThanEnemyBase', {'LocationType', categories.MOBILE * categories.AIR - categories.SCOUT - categories.INTELLIGENCE, 'AntiAir', 'AntiSurface', 1}},
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 1, 'FACTORY TECH2 AIR, FACTORY TECH3 AIR' }},
			{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, 'AIR MOBILE BOMBER TECH1' } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    
 
    Builder {
        BuilderName = 'Sorian T2 Air Attack Threat',
        PlatoonTemplate = 'ThreatAirAttack',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 200,
        InstanceCount = 3,
        BuilderType = 'Any',
        BuilderData = {
			ThreatThreshold = 100,
		},
        BuilderConditions = {
            #{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, 'AIR MOBILE BOMBER' } },
			{ AirAttackCondition, { 'LocationType', 12 } },
            { UCBC, 'PoolLessAtLocation', { 'LocationType', 1, 'AIR MOBILE TECH3' } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
			{ SIBC, 'AIThreatExists', { 100 } },
        },
    },
    Builder {
        BuilderName = 'Sorian T3 Air Attack Threat',
        PlatoonTemplate = 'ThreatAirAttack',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 200,
        InstanceCount = 3,
        BuilderType = 'Any',
        BuilderData = {
			ThreatThreshold = 100,
		},
        BuilderConditions = {
            #{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, 'AIR MOBILE BOMBER' } },
			{ AirAttackCondition, { 'LocationType', 90 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
			{ SIBC, 'AIThreatExists', { 100 } },
        },
    },
}


#####

BuilderGroup {
    BuilderGroupName = 'NCT3AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3AntiAirPlanes Initial',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 755,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.AIR, 'Enemy'}},
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 50, categories.AIR * categories.ANTIAIR * categories.TECH3 } },
			{ SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 12, [512] = 15, [1024] = 30, [2048] = 80, [4096] = 100}, categories.AIR * categories.ANTIAIR * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, categories.ANTIAIR * categories.AIR - categories.BOMBER } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 760,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			#{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 9, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            #{ UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.ANTIAIR * categories.TECH3 } },
			
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 3, categories.ANTIAIR * categories.AIR - categories.BOMBER } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air Extra',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 761,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 10, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 160, categories.AIR * categories.ANTIAIR * categories.TECH3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 3, categories.ANTIAIR * categories.AIR - categories.BOMBER } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air Extra 2',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 763,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 15, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 270, categories.AIR * categories.ANTIAIR * categories.TECH3 } },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 3, categories.ANTIAIR * categories.AIR - categories.BOMBER } },
			{ UCBC, 'UnitCapCheckLess', { .8 } },
        },
        BuilderType = 'Air',
    },

      
   Builder {
        BuilderName = 'NC T3AntiAirPlanes - 2transport',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 698,
        BuilderConditions = {
			
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 4, 'TRANSPORTFOCUS'} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
			{ UCBC, 'UnitCapCheckLess', { .9 } },
        },
        BuilderType = 'Air',
    },
 Builder {
        BuilderName = 'NC T3AntiAirPlanes - 3transport',
        PlatoonTemplate = 'T3AirTransport',
        Priority = 699,
        BuilderConditions = {
			
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 6, 'TRANSPORTFOCUS'} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
			{ UCBC, 'UnitCapCheckLess', { .9 } },
        },
        BuilderType = 'Air',
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCBaseGuardAirFormBuilders',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC AntiAirT4Guard',
        PlatoonTemplate = 'AntiAirT4GuardNC',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 10,
        InstanceCount = 50,
        BuilderData = {
            NeverGuardEngineers = true,
        },
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 40, categories.AIR * categories.MOBILE * (categories.TECH1 + categories.TECH2 + categories.TECH3) * categories.ANTIAIR } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL * categories.AIR}},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
   
}

####

BuilderGroup {
    BuilderGroupName = 'NCMobileAirExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
	#Air T4 builders for 20x20 and larger maps
    Builder {
        BuilderName = 'NC T3 Air Exp1 Engineer 1 nutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 965,
 InstanceCount = 2,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
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
        BuilderName = 'NC T3 Air after lots of resources',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 975,
 InstanceCount = 5,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.9} },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
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
        BuilderName = 'NC T3 Air seph',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 985,
 InstanceCount = 7,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
{ MIBC, 'FactionIndex', {4}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
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
        BuilderName = 'NC T3 Air aeon with lots of resources',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1100,
 InstanceCount = 10,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.9} },
{ MIBC, 'FactionIndex', {2}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
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
	#Air T4 builders for 10x10 and smaller maps
    Builder {
        BuilderName = 'NC T3 Air Exp1 Engineer 1 - Small Map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 949,
        BuilderConditions = {
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'MapLessThan', { 1000, 1000 }},
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
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
        BuilderName = 'NC T2 Engineer Assist Experimental Mobile Air',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 960,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 500,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Experimental Mobile Air',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 965,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.AIR * categories.MOBILE}},
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
				AssistUntilFinished = true,
                AssistRange = 500,
                BeingBuiltCategories = {'EXPERIMENTAL MOBILE AIR'},
                Time = 60,
            },
        
         }
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCMobileAirExperimentalForm',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T4 Exp Air nutcracker',
        PlatoonTemplate = 'T4ExperimentalAirNC',
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        Priority = 10000,
        InstanceCount = 50,
        FormRadius = 2000,
        BuilderType = 'Any',
        BuilderConditions = {
            #{ SIBC, 'HaveLessThanUnitsWithCategory', { 7, 'EXPERIMENTAL MOBILE AIR'}},
			#{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'FACTORY TECH1, FACTORY TECH2' } },
			{ T4AirAttackCondition, { 'LocationType', 250 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			ThreatSupport = 300,
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'EXPERIMENTAL', 'COMMAND', 'STRUCTURE ARTILLERY EXPERIMENTAL', 'TECH3 STRATEGIC STRUCTURE', 'ENERGYPRODUCTION', 'MASSFABRICATION', 'STRUCTURE' }, # list in order
        },
    },
    Builder {
        BuilderName = 'NC T4 Exp Air Unit Capnutcracker',
        PlatoonTemplate = 'T4ExperimentalAirNC',
        PlatoonAddPlans = {'NameUnitsSorian', 'DistressResponseAISorian', 'PlatoonCallForHelpAISorian'},
        Priority = 800,
        InstanceCount = 50,
        FormRadius = 250,
        BuilderType = 'Any',
        BuilderConditions = {
            #{ SIBC, 'HaveLessThanUnitsWithCategory', { 7, 'EXPERIMENTAL MOBILE LAND, EXPERIMENTAL MOBILE AIR'}},
			#{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'FACTORY TECH1, FACTORY TECH2' } },
			{ UCBC, 'UnitCapCheckGreater', { .95 } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			ThreatSupport = 300,
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'EXPERIMENTAL', 'COMMAND', 'STRUCTURE ARTILLERY EXPERIMENTAL', 'TECH3 STRATEGIC STRUCTURE', 'ENERGYPRODUCTION', 'MASSFABRICATION', 'STRUCTURE' }, # list in order
        },
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCEconomicExperimentalEngineers',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Econ Exper Engineer nutcracker',
        PlatoonTemplate = 'AeonT3EngineerBuilder',
        Priority = 1950,
		InstanceCount = 1,
        BuilderConditions = {
		{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH3}},
		#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.ECONOMIC}},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
        
		
			{ IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
			{ SBC, 'EnemyThreatLessThanValueAtBase', { 'LocationType', 1, 'Air', 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 14,
            Construction = {
                BuildClose = false,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4EconExperimental',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T2 Engineer Assist Experimental Economic',
        PlatoonTemplate = 'T2EngineerAssistSorian',
        Priority = 1500,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.4, 0.7} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 600,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Experimental Economic',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1500,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL * categories.ECONOMIC }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.4, 0.7} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 600,
                BeingBuiltCategories = {'EXPERIMENTAL ECONOMIC'},
                Time = 60,
            },
        }
    },
}

####

BuilderGroup {
    BuilderGroupName = 'NCT3ArtilleryGroup',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T3 Artillery Engineer - In rangenutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 1100,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE, 'LocationType', }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconIncome', {15, 750}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.9, 1.2}},
            { IBC, 'BrainNotLowPowerMode', {} },
            #{ UCBC, 'CheckUnitRange', { 'LocationType', 'T3Artillery', categories.STRUCTURE } },
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
			{ SBC, 'EnemyInT3ArtilleryRange', { 'LocationType', true } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 2,
            Construction = {
                BuildClose = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T3Artillery',
                },
                Location = 'LocationType',
            }
        }
    },
  
  
    Builder {
        BuilderName = 'NC Rapid T3 Artillery Engineernutcracker',
        PlatoonTemplate = 'AeonT3EngineerBuilderSorian',
        Priority = 975,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 20, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE, 'LocationType', }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE * categories.PRODUCTSC1}},
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconIncome', {6, 750}},
            { SIBC, 'GreaterThanEconEfficiency', { 1.0, 2.0}},
			{ SBC, 'MapLessThan', { 4000, 4000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
            #{ UCBC, 'CheckUnitRange', { 'LocationType', 'T3RapidArtillery', categories.STRUCTURE, 2 } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 12,
            Construction = {
                BuildClose = true,
				#T4 = true,
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
'T3StrategicMissileDefense',
                    'T3RapidArtillery',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T3EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 950,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.9, 1.2}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 550,
                BeingBuiltCategories = {'ARTILLERY TECH3 STRUCTURE'},
                Time = 120,
            },
        }
    },
}

#####

BuilderGroup {
    BuilderGroupName = 'NCExperimentalArtillery',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T4 Artillery Engineernutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 1100,
		InstanceCount = 1,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.STRUCTURE}},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.STRUCTURE * categories.ARTILLERY}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL'} }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
         
            { SIBC, 'GreaterThanEconEfficiency', { 0.2, 0.4}},
			{ SBC, 'MapLessThan', { 4000, 4000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
            { MIBC, 'FactionIndex', {1,4} },
            #{ UCBC, 'CheckUnitRange', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
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
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
	Builder {
        BuilderName = 'NC T4 Artillery Engineer - Cybrannutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
		PlatoonAddPlans = {'NameUnitsSorian'},
        Priority = 2500,
		InstanceCount = 1,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ARTILLERY * categories.OVERLAYINDIRECTFIRE}},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.EXPERIMENTAL * categories.ARTILLERY * categories.OVERLAYINDIRECTFIRE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE', 'TECH3 ARTILLERY STRUCTURE'} }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
          
            { SIBC, 'GreaterThanEconEfficiency', { 0.4, 0.5}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
			#{ SIBC, 'T4BuildingCheck', {} },
            { MIBC, 'FactionIndex', {3} },
            #{ UCBC, 'CheckUnitRange', { 'LocationType', 'T4Artillery', categories.STRUCTURE } },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 5,
            Construction = {
                BuildClose = true, #false
				#T4 = true,
                #BaseTemplate = ExBaseTmpl,
                #NearMarkerType = 'Rally Point',
				AdjacencyCategory = 'SHIELD STRUCTURE',
                BuildStructures = {
                    'T4LandExperimental2',
'T3ShieldDefense',
'T3ShieldDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'NC T4EngineerAssistBuildHLRA',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 1500,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.ARTILLERY * categories.TECH3 * categories.STRUCTURE}},
            { SIBC, 'GreaterThanEconEfficiency', { 0.9, 1.2}},
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

#####

BuilderGroup {
    BuilderGroupName = 'NCNukeBuildersEngineerBuilders',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC Seraphim Exp Nuke Engineernutcracker',
        PlatoonTemplate = 'SeraphimT3EngineerBuilderSorian',
        Priority = 5000,
		InstanceCount = 1,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.TECH3 * categories.ARTILLERY * categories.STRUCTURE}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.NUKE * categories.STRUCTURE * categories.TECH3}},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.EXPERIMENTAL * categories.STRUCTURE * categories.NUKE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
			{ SIBC, 'EngineerNeedsAssistance', { false, 'LocationType', {'EXPERIMENTAL', 'NUKE STRUCTURE'} }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            { SIBC, 'GreaterThanEconIncome', {2, 150}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.2, 0.2}},
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
        BuilderName = 'NC T3 Nuke Engineer all innutcracker',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 980,
		InstanceCount = 2,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { MIBC, 'FactionIndex', {2}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            #{ SIBC, 'GreaterThanEconIncome', {15, 950}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.5, 1.9}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
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
        BuilderName = 'NC T3 Nuke Engineer cyb',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 970,
		InstanceCount = 10,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { MIBC, 'FactionIndex', {3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
            #{ SIBC, 'GreaterThanEconIncome', {10, 650}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
			MinNumAssistees = 6,
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
        BuilderName = 'NC T3 Nuke Engineer regular',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 940,
		InstanceCount = 1,
        BuilderConditions = {
			#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.NUKE * categories.STRUCTURE}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { MIBC, 'FactionIndex', {1,2,3}},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSPRODUCTION * categories.TECH3 } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL}},
                       
            #{ SIBC, 'GreaterThanEconIncome', {15, 750}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2}},
			{ SBC, 'MapGreaterThan', { 1000, 1000 }},
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
        BuilderName = 'NC T3 Engineer Assist Build Nuke',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 850,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingGreater', { 'LocationType', 0, categories.STRUCTURE * categories.NUKE}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 150,
                BeingBuiltCategories = {'STRUCTURE NUKE'},
                Time = 120,
            },
        }
    },
    Builder {
        BuilderName = 'NC T3 Engineer Assist Build Nuke Missile',
        PlatoonTemplate = 'T3EngineerAssistSorian',
        Priority = 250,
        InstanceCount = 3,
        BuilderConditions = {
			{ UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, 'NUKE STRUCTURE'}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.2}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'NonUnitBuildingStructure',
                AssistRange = 150,
                AssisteeCategory = 'STRUCTURE NUKE',
                Time = 120,
            },
        }
    },
}

#####

BuilderGroup {
    BuilderGroupName = 'NCAirScoutFormBuilders',
    BuildersType = 'PlatoonFormBuilder',
    
     Builder {
        BuilderName = 'NC T3 Air Scout',
        PlatoonTemplate = 'T3AirScoutFormNC',
        Priority = 751,
        BuilderConditions = {
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        PlatoonAddPlans = { 'AirIntelToggle' },
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        InstanceCount = 30,
        BuilderType = 'Any',
    },
}
