#****************************************************************************
#**
#**  File     :  /lua/AI/AIBuilders/SorianExpansionBuilders.lua
#**
#**  Summary  : Builder definitions for expansion bases
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
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
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'

local ExtractorToFactoryRatio = 3



BuilderGroup {
    BuilderGroupName = 'NCEngineerExpansionBuildersFull',
    BuildersType = 'EngineerBuilder',
    
    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer_islandmap ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 985,
        InstanceCount = 2,
        
       
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 5, 0, 'StructuresNotMex' } },
            { SBC, 'IsIslandMap', { true } },
            { SBC, 'LessThanGameTime', { 600 } },
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
       
  
            #{ EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 5,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1AirFactory',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1AirFactory',
                    

					'T1Radar',
                                        

                }               
            },
            NeedGuard = true,
        }
    }, 
    
    Builder {
        BuilderName = 'NC T1VacantStartingAreaEngineer_islandmap',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 980,
       
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 100, 0, 'StructuresNotMex' } },
          
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
          
      
          
            
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1AirFactory',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1AirFactory',
                   

					'T1Radar',
                }
            },
            NeedGuard = true,
        }
    },       
    Builder {
        BuilderName = 'NC T2VacantStartingAreaEngineer_islandmap',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 982,
       
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { SBC, 'IsIslandMap', { true } },
			{ SIBC, 'LessThanExpansionBases', { } },
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
          
         
            
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1AirFactory',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1AirFactory',
               

					'T1Radar',
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T3VacantStartingAreaEngineer_islandmap',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 982,
      
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
	
        
           
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1AirFactory',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1AirFactory',
                  

					'T1Radar',			
                }
            },
            NeedGuard = true,
        }
    },
      

    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 985,
       
       
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 5, 0, 'StructuresNotMex' } },
       
            { SBC, 'LessThanGameTime', { 600 } },
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
       
  
            #{ EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 5,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                 
               
                
					'T1AirFactory',
					'T1LandFactory',
					'T1AADefense',
					'T1Radar',
                                      

                }               
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T1VacantStartingAreaEngineer',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 980,
       
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 100, 0, 'StructuresNotMex' } },
          
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
          
      
          
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                 
               
                
					'T1AirFactory',
					'T1LandFactory',
					'T1AADefense',
					'T1Radar',
                }
            },
            NeedGuard = true,
        }
    },       
    Builder {
        BuilderName = 'NC T2VacantStartingAreaEngineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 982,
      
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
          
			{ SIBC, 'LessThanExpansionBases', { } },
			
			{ SBC, 'NoRushTimeCheck', { 0 }},
          
         
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                 
               
                
					'T1AirFactory',
					'T1LandFactory',
					'T1AADefense',
					'T1Radar',
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T3VacantStartingAreaEngineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 982,
      
        BuilderConditions = {
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
			{ SIBC, 'LessThanExpansionBases', { } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
	
        
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
			RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Start Location',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                 
               
                
					'T1AirFactory',
					'T1LandFactory',
					'T1AADefense',
					'T1Radar',		
                }
            },
            NeedGuard = true,
        }
    },
      
}

BuilderGroup {
    BuilderGroupName = 'NCEngineerExpansionBuildersSmall',
    BuildersType = 'EngineerBuilder',


      Builder {
        BuilderName = 'NC`nsion Area Engineer(Full Base)',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 722,
       
        BuilderConditions = {
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 100, 2, 'StructuresNotMex' } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 100, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .8 } },
            { SIBC, 'LessThanExpansionBases', { } },
            { SBC, 'NoRushTimeCheck', { 0 }},
            #{ EBC, 'MassIncomeToUnitRatio', { 10, '>=', 'FACTORY TECH1 STRUCTURE' } },
            #{ EBC, 'MassIncomeToUnitRatio', { 20, '>=', 'FACTORY TECH2 STRUCTURE' } },
            #{ EBC, 'MassIncomeToUnitRatio', { 30, '>=', 'FACTORY TECH3 STRUCTURE' } },
            #{ UCBC, 'HaveUnitRatio', { ExtractorToFactoryRatio, 'MASSEXTRACTION', '>=','FACTORY' } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AADefense',
                    'T1Radar',
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T1 Vacant Expansion Area Engineer(Fire base)',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 722,
      
        BuilderConditions = {
            { SIBC, 'ExpansionPointNeedsStructure', { 'LocationType', 1000, 'DEFENSE TECH1 STRUCTURE', 20, 3, 0, 1, 2, 'StructuresNotMex' } },
            #{ UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .7 } },
            
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                BuildClose = false,
                MarkerRadius = 20,
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = 0,
                ThreatMax = 1,
                ThreatRings = 2,
                MarkerUnitCount = 3,
                ThreatType = 'StructuresNotMex',
                MarkerUnitCategory = 'DEFENSE TECH1 STRUCTURE',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1GroundDefense',
                    'T1AADefense',
                    'T1AADefense',
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T2VacantExpansiongAreaEngineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 722,
    
        BuilderConditions = {
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .7 } },
            { SIBC, 'LessThanExpansionBases', { } },
            { SBC, 'NoRushTimeCheck', { 0 }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2 } },
            { UCBC, 'HaveUnitRatio', { ExtractorToFactoryRatio, 'MASSEXTRACTION', '>=','FACTORY' } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T2GroundDefense',
                    'T1LandFactory',
                    'T2AADefense',
                    'T2Radar',
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T3VacantExpansionAreaEngineer',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 722,
      
        BuilderConditions = {
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .7 } },
            { SIBC, 'LessThanExpansionBases', { } },
            { SBC, 'NoRushTimeCheck', { 0 }},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH3 } },
            { UCBC, 'HaveUnitRatio', { ExtractorToFactoryRatio, 'MASSEXTRACTION', '>=','FACTORY' } },
            { EBC, 'MassToFactoryRatioBaseCheck', { 'LocationType' } },
        },
        BuilderType = 'Any',
        BuilderData = {
            RequireTransport = true,
            Construction = {
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T2GroundDefense',
                    'T1LandFactory',
                    'T3AADefense',
                    'T2Radar',
                }
            },
            NeedGuard = true,
        }
    },
}



BuilderGroup {
    BuilderGroupName = 'NCbuildmissileclose',
    BuildersType = 'EngineerBuilder',
Builder {
        BuilderName = 'NCgetinclosewithmissile',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 3,
        NeedGuard = true,
        BuilderConditions = {
         { SBC, 'CanBuildFirebase', { 'LocationType', 280, 'Defensive Point', -10000, 5, 1, 'AntiSurface', 1, 'STRUCTURE ARTILLERY TECH3', 20} },
     
		
		
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.1 }},
            
			{ SBC, 'MapGreaterThan', { 500, 500 }},
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
        BuilderData = {
          RequireTransport = true,
			
            Construction = {
                BuildClose = true,
                BaseTemplate = ExBaseTmpl,
                FireBase = true,
                FireBaseRange = 280,
                NearMarkerType = 'Expansion Area',
                LocationType = 'LocationType',
                ThreatMin = -10000,
                ThreatMax = 5,
                ThreatRings = 1,
                MarkerUnitCount = 1,
                MarkerUnitCategory = 'STRUCTURE ARTILLERY TECH3',
                MarkerRadius = 20,
                BuildStructures = {
					
'T2GroundDefense',
'T3AADefense',                 
'T2MissileDefense',
'T2StrategicMissile',
'T2MissileDefense',
'T2StrategicMissile',
'T2MissileDefense',
'T2StrategicMissile',
'T2MissileDefense',
'T2StrategicMissile',
'T2StrategicMissile',
'T2StrategicMissile',
'T2StrategicMissile',
'T2StrategicMissile',
'T2StrategicMissile',

                }
            }
        }
    },
}



