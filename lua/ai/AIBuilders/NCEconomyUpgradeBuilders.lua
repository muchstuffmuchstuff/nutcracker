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
         
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.35 }},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2'} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, 'MASSEXTRACTION' }},
		
         
            
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
          { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.35 }},
            
       { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2'} },
        
		
         
            
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
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.35 }},
            
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
            { IBC, 'BrainNotLowPowerMode', {} },
        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 14, 'MASSEXTRACTION TECH3' }},
        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH3' } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.35 }},
            
                     
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCUpgradeBuilders_mainbase',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
         
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
             
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'AIR FACTORY'}},
           
           
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
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.00 } },
       
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * categories.TECH3 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'AIR FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
 
Builder {
        BuilderName = 'NC land t1 to t2mainbase',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
          
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAND *(categories.TECH2 + categories.TECH3)*categories.FACTORY } },
             { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'LAND FACTORY'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
Builder {
        BuilderName = 'NC land t2 to t3mainbase',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 999,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
            
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAND * categories.TECH3 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'LAND FACTORY'}},
          
           
           
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
    
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
               
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'AIR FACTORY'}},
           
           
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
       
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
              
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 12, 'AIR FACTORY'}},
           
           
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
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
                
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'AIR FACTORY TECH2, AIR FACTORY TECH3' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 2, 'FACTORY AIR TECH2' }},
           
           
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
        
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'NAVAL FACTORY TECH2' } },
               
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NAVAL FACTORY', 'Enemy'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'NAVAL FACTORY' } },
               
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.20 } },
                
          
			
				
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 } },
                
               { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
           
           
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
}




			
		
           

BuilderGroup {
    BuilderGroupName = 'NCTime Exempt Extractor Upgrades Expansion',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC T1 Mass Extractor Upgrade Timeless Single Expansion',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 3.5, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'MAIN', 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless Single Expansion',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 20, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'MAIN', 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },    
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless Multiple Expansion',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 4,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 35, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'MAIN', 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },       
}
   
BuilderGroup {
    BuilderGroupName = 'NCTime Exempt Extractor Upgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NCT1 Mass Extractor Upgrade Storage Based',
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
        BuilderName = 'NCT1 Mass Extractor Upgrade Bleed Off',
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
        BuilderName = 'NC T1 Mass Extractor Upgrade Timeless Single',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 2.2, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NCT1 Mass Extractor Upgrade Timeless Two',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 6, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC T1 Mass Extractor Upgrade Timeless LOTS',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 4,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 15, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 4, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NCT2 Mass Extractor Upgrade Storage Based',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 0, #200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageCurrent', { 3000, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NCT2 Mass Extractor Upgrade Bleed Off',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { EBC, 'GreaterThanEconStorageRatio', { 1.0, 0 } },
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0, 1.2 }},
			#{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },            
            { SIBC, 'GreaterThanEconIncome', { 13, 50 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },  
    
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless Multiple',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 3,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },			
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { SIBC, 'GreaterThanEconIncome',  { 20, 50 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
			{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 5, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3' }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 2, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },      
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless - Later',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },            
            { SIBC, 'GreaterThanEconIncome', { 13, 50 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },    
    Builder {
        BuilderName = 'NC T2 Mass Extractor Upgrade Timeless Multiple - Later',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        Priority = 200,
        InstanceCount = 3,
        BuilderConditions = {
            #{ UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'ENERGYPRODUCTION TECH2, ENERGYPRODUCTION TECH3' } },			
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { SIBC, 'GreaterThanEconIncome',  { 20, 50 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}







BuilderGroup {
    BuilderGroupName = 'NCT1BalancedUpgradeBuilders',
    BuildersType = 'PlatoonFormBuilder',
    
    Builder {
        BuilderName = 'NC Balanced T1 Sea Factory Upgrade',
        PlatoonTemplate = 'T1SeaFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NAVAL FACTORY', 'Enemy'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'NAVAL FACTORY' } },
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'GreaterThanEconIncome',  { 3.5, 75}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 } },
                
            },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT2BalancedUpgradeBuilders',
    BuildersType = 'PlatoonFormBuilder',
    
    Builder {
        BuilderName = 'NC Balanced T2 Sea Factory Upgrade',
        PlatoonTemplate = 'T2SeaFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'NAVAL FACTORY', 'Enemy'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 }},
                
            },
        BuilderType = 'Any',
    },
}





