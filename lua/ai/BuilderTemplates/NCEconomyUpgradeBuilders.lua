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
         
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH2'} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 7, 'MASSEXTRACTION' }},
		
         
            
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
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
        
		
         
            
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
           
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 1.2 }},
                        { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'MASSEXTRACTION TECH3' } },
	
       
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
			{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
                     
	
       
        },
        FormRadius = 10000,
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.20 } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.20 } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.20 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2' } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.20 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, 'FACTORY TECH2' } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.20 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.20 } },
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 5, 'FACTORY TECH3' } },
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
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 3, categories.NAVAL * categories.MOBILE,  'Enemy' }},
             
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'NAVAL FACTORY' } },
               
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.20 } },
          
			
				
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 } },
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
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 1.05 } },
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
        BuilderName = 'Sorian T1 Mass Extractor Upgrade Timeless Single Expansion',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 3.5, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH2', 'MASSEXTRACTION' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'MAIN', 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'Sorian T2 Mass Extractor Upgrade Timeless Single Expansion',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 20, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'MAIN', 3, 'MASSEXTRACTION TECH3', 'MASSEXTRACTION' } },
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },    
    Builder {
        BuilderName = 'Sorian T2 Mass Extractor Upgrade Timeless Multiple Expansion',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 4,
        Priority = 200,
        BuilderConditions = {
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconIncome',  { 35, 10}},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.90, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
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
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.2 }},
			{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH3' }},
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
}



# ================================= #
#     EMERGENCY FACTORY UPGRADES
# ================================= #
BuilderGroup {
    BuilderGroupName = 'NCEmergencyUpgradeBuilders_landfactories',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Emergency T1 Factory Upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY TECH2, FACTORY TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2, FACTORY TECH3' } },
                #{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2, FACTORY TECH3' } },
				{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'MOBILE TECH2, FACTORY TECH2', 'Enemy'}},				
                #{ SIBC, 'GreaterThanEconIncome',  { 2.4, 50}},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Emergency T2 Factory Upgrade',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                #{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
				{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'MOBILE TECH3, FACTORY TECH3', 'Enemy'}},				
                #{ SIBC, 'GreaterThanEconIncome',  { 2.4, 50}},
            },
        BuilderType = 'Any',
    },
}

# ================================= #
#     RUSH FACTORY UPGRADES
# ================================= #


# ================================= #
#     BALANCED FACTORY UPGRADES
# ================================= #
BuilderGroup {
    BuilderGroupName = 'NCT1BalancedUpgradeBuilders',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Balanced T1 Land Factory Upgrade Initial',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY LAND TECH2, FACTORY LAND TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2, FACTORY TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2, FACTORY TECH3' } },		            
                #{ SIBC, 'GreaterThanEconIncome',  { 2.4, 50}},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC BalancedT1AirFactoryUpgradeInitial',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        FormDebugFunction = nil,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY AIR TECH2, FACTORY AIR TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2, FACTORY TECH3' } },
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2, FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 3.5, 75}},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T1 Land Factory Upgrade',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, 'FACTORY LAND TECH2, FACTORY LAND TECH3' }},
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'FACTORY LAND TECH2, FACTORY LAND TECH3'}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2, FACTORY TECH3' } },
				{ SIBC, 'FactoryRatioLessOrEqual', { 'LocationType', 1.0, 'FACTORY LAND TECH2', 'FACTORY AIR TECH2', 'FACTORY AIR TECH1'}},
                #{ SIBC, 'GreaterThanEconIncome',  { 4.0, 75}},
                #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 } },
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC BalancedT1AirFactoryUpgrade',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        FormDebugFunction = nil,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, 'FACTORY AIR TECH2, FACTORY AIR TECH3' }},
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'FACTORY AIR TECH2, FACTORY AIR TECH3'}},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2, FACTORY TECH3' } },
				{ SIBC, 'FactoryRatioLessOrEqual', { 'LocationType', 1.0, 'FACTORY AIR TECH2', 'FACTORY LAND TECH2', 'FACTORY LAND TECH1'}},
                { SIBC, 'GreaterThanEconIncome',  { 3.5, 75}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 } },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T1 Sea Factory Upgrade',
        PlatoonTemplate = 'T1SeaFactoryUpgrade',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 1, 'NAVAL FACTORY' } },
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'GreaterThanEconIncome',  { 3.5, 75}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 } },
            },
        BuilderType = 'Any',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCT2BalancedUpgradeBuilders',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Balanced T1 Land Factory Upgrade - T3',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 0, #250,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, 'FACTORY LAND TECH1' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2' } },
				{ UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 } },
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC BalancedT1AirFactoryUpgrade - T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 0, #250,
        InstanceCount = 1,
        FormDebugFunction = nil,
        BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH2' } },
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, 'FACTORY AIR TECH1' }},
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 1, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH2' } },
				{ UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 } },
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T2 Land Factory Upgrade - initial',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
				{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY LAND TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                #{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 7, 'MOBILE LAND'}},
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
				{ SBC, 'AIType', {'sorianrush', false }},
				#{ SBC, 'MapGreaterThan', { 1000, 1000 }},
                #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T2 Air Factory Upgrade - initial',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
				{ UCBC, 'HaveLessThanUnitsWithCategory', { 1, 'FACTORY AIR TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
                #{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
				{ SBC, 'AIType', {'sorianrush', false }},
				#{ SBC, 'MapGreaterThan', { 1000, 1000 }},
                #{ SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T2 Land Factory Upgrade - Large Map',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'FACTORY LAND TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
				{ SIBC, 'FactoryRatioLessOrEqual', { 'LocationType', 1.0, 'FACTORY LAND TECH3', 'FACTORY AIR TECH3', 'FACTORY AIR TECH2'}},
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 7, 'MOBILE LAND'}},
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
				{ SBC, 'AIType', {'sorianrush', false }},
				#{ SBC, 'MapGreaterThan', { 1000, 1000 }},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T2 Air Factory Upgrade - Large Map',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
				{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'FACTORY AIR TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
				{ SIBC, 'FactoryRatioLessOrEqual', { 'LocationType', 1.0, 'FACTORY AIR TECH3', 'FACTORY LAND TECH3', 'FACTORY LAND TECH2'}},
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
				{ SBC, 'AIType', {'sorianrush', false }},
				#{ SBC, 'MapGreaterThan', { 1000, 1000 }},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
   
    Builder {
        BuilderName = 'NC Balanced T2 Air Factory Upgrade - Small Map',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'FACTORY AIR TECH3'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
				{ SIBC, 'FactoryRatioLessOrEqual', { 'LocationType', 1.0, 'FACTORY AIR TECH3', 'FACTORY LAND TECH3', 'FACTORY LAND TECH2'}},
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
				{ SBC, 'AIType', {'sorianrush', true }},
				#{ SBC, 'MapGreaterThan', { 1000, 1000 }},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T2 Sea Factory Upgrade',
        PlatoonTemplate = 'T2SeaFactoryUpgrade',
        Priority = 300,
        InstanceCount = 1,
        BuilderConditions = {
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'FACTORY TECH3' } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
                { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'FACTORY TECH3' } },
                { SIBC, 'GreaterThanEconIncome',  { 7, 180}},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 1.25 }},
            },
        BuilderType = 'Any',
    },
}





