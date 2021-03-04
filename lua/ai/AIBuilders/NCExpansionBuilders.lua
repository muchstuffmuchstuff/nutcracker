---muchstuff

---nutcracker

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
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'






BuilderGroup {
    BuilderGroupName = 'NCEngineerExpansionBuildersFull',
    BuildersType = 'EngineerBuilder',
    
    
    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer_islandmap 1000 ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1001,
        InstanceCount = 4,
       
     
        
       
        BuilderConditions = {
          
            { SBC, 'IsIslandMap', { true } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 5, 0, 'StructuresNotMex' } },
        
           
		
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
                ThreatMax = 30,
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    

				
                                        

                }               
            },
            NeedGuard = true,
        }
    }, 
    
    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer_islandmap 400 ',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1002,
        InstanceCount = 4,
        DelayEqualBuildPlattons = {'Expansion2', 10},
        
       
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Expansion2' }},
            { SBC, 'IsIslandMap', { true } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 400, -1000, 5, 0, 'StructuresNotMex' } },
        
           
		
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
                LocationRadius = 400,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 30,
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    

				
                                        

                }               
            },
            NeedGuard = true,
        }
    }, 
    
    Builder {
        BuilderName = 'NC T1VacantStartingAreaEngineer_islandmap giant map',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 999,
        InstanceCount = 3,
       
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },

            
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 100, 0, 'StructuresNotMex' } },
          
          
		
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
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                   

                }
            },
            NeedGuard = true,
        }
    },  
   
    Builder {
        BuilderName = 'NC T2VacantStartingAreaEngineer_islandmap',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 3,
       
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
      
		
			
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
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
               

					
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T3VacantStartingAreaEngineer_islandmap',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        InstanceCount = 3,
      
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
		
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
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
                
                    'T1AirFactory',
                    'T1AirFactory',
                  

								
                }
            },
            NeedGuard = true,
        }
    },

    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer 500',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1100,
        InstanceCount = 4,
       
       
        BuilderConditions = {
           
            { SBC, 'IsIslandMap', { false } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 500, -1000, 5, 0, 'StructuresNotMex' } },
           
       
            
			
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
                LocationRadius = 500,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
					
                                      

                }               
            },
            NeedGuard = true,
        }
    },

    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer 500 small',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1000,
       
       
       
        BuilderConditions = {
          
            { SBC, 'IsIslandMap', { false } },
            { SBC, 'MapLessThan', { 1000, 1000 }},   
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {10, categories.MASSEXTRACTION } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 500, -1000, 5, 0, 'StructuresNotMex' } },
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
                LocationRadius = 500,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
              
                    'T1LandFactory',
              
              
				
					
                }               
            },
            NeedGuard = true,
        }
    },

    Builder {
        BuilderName = 'NC T1rushVacantStartingAreaEngineer 900',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 1099,
        InstanceCount = 4,
       
       
        BuilderConditions = {
            { SBC, 'IsIslandMap', { false } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 900, -1000, 5, 0, 'StructuresNotMex' } },
           
       
            
			
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
                LocationRadius = 900,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 0,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',

					
                                      

                }               
            },
            NeedGuard = true,
        }
    },
    
    Builder {
        BuilderName = 'NC T2VacantStartingAreaEngineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 982,
        InstanceCount = 3, 
      
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
          
	
			
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
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {                    
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
					
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
    
        BuilderName = 'NC T3VacantStartingAreaEngineer',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 982,
        InstanceCount = 3, 
      
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
      
			
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
                ThreatMax = 25,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1LandFactory',
                 
               
                
					'T1AirFactory',
					'T1LandFactory',
					'T1AADefense',
						
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
        BuilderName = 'NC expansion Area Engineer(Full Base)',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 3, 
       
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 100, 2, 'StructuresNotMex' } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 100, 2, 'StructuresNotMex' } },
            
            { UCBC, 'UnitCapCheckLess', { .8 } },
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
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 100,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',

					
                }
            },
            NeedGuard = true,
        }
    },
    

    Builder {
        BuilderName = 'NC T2VacantExpansiongAreaEngineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 3,
    
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .7 } },
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
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T1GroundDefense',
                    'T1LandFactory',
                    'T1AirFactory',
                    'T1GroundDefense',
					'T1AADefense',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
                    'T1Resource',
					
                }
            },
            NeedGuard = true,
        }
    },
    Builder {
        BuilderName = 'NC T3VacantExpansionAreaEngineer',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 950,
        InstanceCount = 3,
      
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.TRANSPORTFOCUS } },
            { UCBC, 'ExpansionAreaNeedsEngineer', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'StartLocationsFull', { 'LocationType', 1000, -1000, 0, 2, 'StructuresNotMex' } },
            { UCBC, 'UnitCapCheckLess', { .7 } },
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
                NearMarkerType = 'Expansion Area',
                LocationRadius = 1000,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 0,
                ExpansionRadius = 100,
                ThreatRings = 2,
                ThreatType = 'StructuresNotMex',
                BuildStructures = {
                    'T2GroundDefense',
                    'T1AirFactory',
                    'T1AirFactory',
                 
                    'T3AADefense',
                    
                }
            },
            NeedGuard = true,
        }
    },
}




    



