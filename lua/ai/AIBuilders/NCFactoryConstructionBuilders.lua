#***************************************************************************
#*
#**  File     :  /lua/ai/SorianFactoryConstructionBuilders.lua
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
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')
local airtolandfactoryratio = 1.0
local landtoairfactoryratio = 1.70
local ExtractorToFactoryRatio = 3.2
local MaxCapFactoryNC = 0.02



BuilderGroup {
    BuilderGroupName = 'NCExtraLandFactory',
    BuildersType = 'EngineerBuilder',
Builder {        
        BuilderName = 'NC T1 Land Factory Builder extra',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
            
            
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
         
            
        
          
          
            
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Land Factory Builder emergency',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
           
            
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
          
            
          
           
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 30, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
          
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder extra big',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
           
           
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
         
            
        
          
          
            
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Land Factory Builder emergency big',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
          
        
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
          
            
          
          
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.MOBILE * categories.LAND - categories.ENGINEER, 'Enemy'}},
          
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
    Builder {        
        BuilderName = 'NC income escalation land factory',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH3 * categories.FACTORY * categories.LAND } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
       --
          
     

            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
          
            
          
            
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
}

BuilderGroup {
BuilderGroupName = 'NCExtraAirFactory',
BuildersType = 'EngineerBuilder',
Builder {        
        BuilderName = 'NC T1 Air Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
          
    
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
          
         
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Air Factory Builder emergency',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
           
            
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
          
           
          
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder big map',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
         
       { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
       { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
         
     
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
          
           
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'AIR FACTORY' }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
  Builder {        
        BuilderName = 'NC T1 Air Factory Builder emergency big map',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 961,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
     
          
            { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
          
    
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
          
            
      
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'AIR FACTORY', 'LocationType', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                
            }
        }
    },
    Builder {        
        BuilderName = 'NC income escalation air factory',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 901,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
           
           
       --
          
       { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } }, 

            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.AIR } },  
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
          
            
          
            
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
}


BuilderGroup {
    BuilderGroupName = 'NCEngineerFactoryConstruction',
    BuildersType = 'EngineerBuilder',
    # =============================
    #     Land Factory Builders
    # =============================
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
        
       --
          
        
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
           
{ UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
{ UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
 
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
    Builder {
        BuilderName = 'NC CDR T1 Land Factory',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {landtoairfactoryratio , categories.LAND * categories.FACTORY, '<=', categories.AIR * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
           
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
        
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
            
         
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                },
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Land Factory Builder - Dead ACU',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 10000,

        BuilderConditions = {
         
       --
        
            
       
 
			{ UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'LAND FACTORY', 'LocationType', }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'COMMAND', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1LandFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        },
    },
    
    # ============================
    #     Air Factory Builders
    # ============================
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder regular',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
       --
           
           
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
     
       
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {
        BuilderName = 'NC CDR T1 Air Factory',
        PlatoonTemplate = 'CommanderBuilderSorian',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
            { UCBC, 'HaveUnitRatio', {airtolandfactoryratio , categories.AIR * categories.FACTORY, '<=', categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveUnitRatioVersusCap', { MaxCapFactoryNC , '<', categories.STRUCTURE * categories.FACTORY * categories.LAND } },  
        
{ EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
      
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
         
         
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                },
            }
        }
    },
    Builder {        
        BuilderName = 'NC T1 Air Factory Builder - Dead ACU',
        PlatoonTemplate = 'AnyEngineerBuilderNC',
        Priority = 900,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * categories.TECH1 * categories.FACTORY } },
         
       --
          
       
            
            { UCBC, 'UnitCapCheckLess', { 0.95 } },
          
			
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'COMMAND', }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                },
                Location = 'LocationType',
                #AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

   
   
    Builder {
       
        BuilderName = 'NC Gate Engineer first',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1, 2, 3}},
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)  * categories.ENERGYPRODUCTION } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
        

            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 15000 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.GATE * categories.TECH3 * categories.STRUCTURE}},
         
       --
         
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {
       
        BuilderName = 'NC Gate Engineer more',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1, 2, 3}},
         
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
            { EBC, 'GreaterThanEconTrend', { 0, 0 } },  

            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 15000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SUBCOMMANDER}},
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'GATE TECH3 STRUCTURE' }},
         
       --
         
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },
    Builder {
       
        BuilderName = 'NC Gate lots of juice',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 950,
        DelayEqualBuildPlattons = {'Factories', 5},
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1, 2, 3}},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'GATE TECH3 STRUCTURE'}},
            { EBC, 'GreaterThanEconTrend', { 0, 0 } },  

            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 10000 } },
            { UCBC, 'FactoryLessAtLocation', { 'LocationType', 3, 'GATE TECH3 STRUCTURE' }},
         
       --
         
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                },
                Location = 'LocationType',
                AdjacencyCategory = 'ENERGYPRODUCTION',
            }
        }
    },

}



