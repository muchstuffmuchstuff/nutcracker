#***************************************************************************
#*
#**  File     :  /lua/ai/SorianEconomyUpgradeBuilders.lua
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




BuilderGroup {
    BuilderGroupName = 'NCmassupgrade',
    BuildersType = 'PlatoonFormBuilder',
 Builder {
        BuilderName = 'NC mass upgrades tech2',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
        
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 }},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'MASSEXTRACTION' }},
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2_incomesupported',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 15000 } },
            { IBC, 'BrainNotLowPowerMode', {} },
         
           
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'MASSEXTRACTION' }},
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
 Builder {
        BuilderName = 'NC mass upgrades tech2 plenty',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
          { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 }},
            
       { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2'} },
        
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
   
   Builder {
        BuilderName = 'NC mass upgrades tech3',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH3 + categories.TECH2)  * categories.ENERGYPRODUCTION } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3) }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 6000, 10000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.ANTIMISSILE * categories.TECH3 }},
            
                        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3' } },
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 SURROUNDED',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE * (categories.TECH3 + categories.TECH2)  * categories.ENERGYPRODUCTION } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6, categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3) }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 10000 } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.STRUCTURE  * categories.ANTIMISSILE * categories.TECH3 }},
            
                        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3' } },
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3_incomesupported',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 300,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25000, 10000 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.20 }},
      
         
            
                        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH3' } },
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC mass upgrades tech3 plenty',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 301,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 10000 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 14, 'MASSEXTRACTION TECH3' }},
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.99, 1.20 }},
            
                     
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCUpgradeBuilders_mainbase',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase allow for landfactory to upgrade',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {800 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH2 * categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
           
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.TECH3 * categories.AIR * categories.ANTIAIR, 'Enemy'}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 } },
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.AIR *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
         
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase_incomesupported',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25000, 15000 } },
         
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.AIR *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
             
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC Air t2 to t3mainbase ALLOW FOR LANDFACTORY TO UPGRADE',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.00 } },
       
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.TECH3 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3mainbase',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1001 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.00 } },
       
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * categories.TECH3 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1201,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1001 } },
        
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.TECH3 * categories.AIR * categories.ANTIAIR, 'Enemy'}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.00 } },
       
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.AIR * categories.TECH3 * categories.FACTORY } },
              
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3mainbase_incomesupported',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25000, 15000 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.AIR * categories.TECH3 * categories.FACTORY } },
            
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
 
Builder {
        BuilderName = 'NC land t1 to t2mainbase',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1050,
        InstanceCount = 1,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.0, 0.3 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.LAND * categories.FACTORY } },
            
           
              
               
              
          
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    
   
    Builder {
        BuilderName = 'NC land t1 to t2mainbase_incomesupported',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageCurrent', { 1000, 15000 } },
             
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
         
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC land t2 to t3mainbase',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1050,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        InstanceCount = 1,
        BuilderConditions = {
        
            { EBC, 'GreaterThanEconStorageRatio', { 0.0, 0.3 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2 } },
          
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3mainbase_incomesupported',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageCurrent', { 5000, 15000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                
            
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.LAND * categories.TECH3 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'LAND FACTORY'}},
          
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCUpgradeBuildersLand',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC land t1 to t2',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.LAND * categories.MOBILE - categories.ENGINEER } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY LAND TECH2' } },
             { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'FACTORY LAND'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
            
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 2, 'FACTORY LAND TECH2' }},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
}



BuilderGroup {
    BuilderGroupName = 'NCUpgradeBuilders_airfactories',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Air t1 to t2',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * (categories.TECH2 + categories.TECH3)* categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.AIR * categories.FACTORY}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC Air t1 to t2 accelerator',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.20, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
              
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, categories.AIR * (categories.TECH2 + categories.TECH3)* categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.AIR * categories.FACTORY}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * (categories.TECH2 + categories.TECH3)* categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.AIR * categories.FACTORY}},
             
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
   Builder {
        BuilderName = 'NC Air t2 to t3 accelerator',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 1.0 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC Balanced T1 Sea Factory Upgrade Expansion',
        PlatoonTemplate = 'T1SeaFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'NAVAL FACTORY TECH2' } },
               
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NAVAL FACTORY', 'Enemy'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'NAVAL FACTORY' } },
               
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
                
          
			
				
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2 bigmap',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 3000, 3000 }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC Air t1 to t2 accelerator bigmap',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 3000, 3000 }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
              
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 10, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3 big map',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 3000, 3000 }},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
                
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 2, 'FACTORY AIR TECH2' }},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
   Builder {
        BuilderName = 'NC Air t2 to t3 accelerator bigmap',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 999,
        InstanceCount = 5,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 3000, 3000 }},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
            
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 10, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCEmergencyUpgrade_airfactories',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Air t1 to t2 emergency',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
                
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3 emergency',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.05, 1.0 } },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
                
               { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
}




			
		
           









BuilderGroup {
    BuilderGroupName = 'NCSeaFactoryUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    
    Builder {
        BuilderName = 'NC Balanced T1 Sea Factory Upgrade',
        PlatoonTemplate = 'T1SeaFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE, 'Enemy'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
               
              
                
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 } },
                
            },
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC Balanced T2 Sea Factory Upgrade',
        PlatoonTemplate = 'T2SeaFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE, 'Enemy'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
          
               
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 }},
                
            },
        BuilderType = 'Any',
    },
}





