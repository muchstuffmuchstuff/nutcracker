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
local IBC = '/lua/editor/InstantBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local Tech2MassExtractortoTech1ExtractorRatio = 1.0
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')
local T1landspamnearlymaxedoutNC = 0.19
local CheckBuildPlattonDelayNC = import('/mods/nutcracker/hook/lua/economicnumbers.lua')



BuilderGroup {
    BuilderGroupName = 'NCmassupgrade',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC mass upgrades regardless',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        Priority = 10000,
        DelayEqualBuildPlattons = {'Mexupgrade1', 7},
        InstanceCount = 20,
        BuilderConditions = {
       { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade1' }},
       { MIBC, 'GreaterThanGameTime', { 200 } },
       { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.MASSEXTRACTION * categories.TECH1 } },  
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
 Builder {
        BuilderName = 'NC mass upgrades tech2 a bit of money',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        Priority = 10000,
        DelayEqualBuildPlattons = {'Mexupgrade2', 4},
        InstanceCount = 20,
        BuilderConditions = {
       { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade2' }},
       { MIBC, 'GreaterThanGameTime', { 220 } },
       { EBC, 'GreaterThanEconStorageCurrent', { 150, 1000 } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 more money',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
     
        Priority = 10000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'Mexupgrade3', 7},
        BuilderConditions = {
       { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade3' }},
       { MIBC, 'GreaterThanGameTime', {200 } },
       { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 more money2',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
     
        Priority = 10000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'Mexupgrade4', 7},
        BuilderConditions = {
       { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade4' }},
       { MIBC, 'GreaterThanGameTime', {200 } },
       { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 more money2',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
     
        Priority = 10000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'Mexupgrade5', 7},
        BuilderConditions = {
       { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade5' }},
       { MIBC, 'GreaterThanGameTime', {200 } },
       { EBC, 'GreaterThanEconStorageCurrent', { 4500, 4000 } },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 ',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        DelayEqualBuildPlattons = {'Mexupgrade6', 20},
        Priority = 10000,
        
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade6' }},
            { MIBC, 'GreaterThanGameTime', { 200 } },
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.MASSEXTRACTION * categories.TECH2 } },
            
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO_timed',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        DelayEqualBuildPlattons = {'Mexupgrade7', 20},
        Priority = 10000,
        
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade7' }},
            { MIBC, 'GreaterThanGameTime', { 200 } },
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            { EBC, 'GreaterThanEconStorageCurrent', {1500 , 10000 } },
            
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO_timed2',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        DelayEqualBuildPlattons = {'Mexupgrade8', 20},
        Priority = 10000,
        
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade8' }},
            { MIBC, 'GreaterThanGameTime', { 200 } },
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            { EBC, 'GreaterThanEconStorageCurrent', {4000 , 30000 } },
            
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO_timed2',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        DelayEqualBuildPlattons = {'Mexupgrade9', 20},
        Priority = 10000,
        
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade9' }},
            { MIBC, 'GreaterThanGameTime', { 200 } },
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            { EBC, 'GreaterThanEconStorageCurrent', {10000 , 30000 } },
            
            
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
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
 
        BuilderConditions = {
          
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            
                
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.FACTORY * categories.AIR}},
           
           
           --
            },
        BuilderType = 'Any',
    },

   
 
    
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 6000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.TECH3}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 4, categories.AIR * categories.FACTORY } },

            },
        BuilderType = 'Any',
    },
   

    Builder {
        BuilderName = 'NC Air t2 to t3mainbase',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 12500,
 
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderConditions = {
          
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
       
           
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.FACTORY * categories.AIR}},

            },
        BuilderType = 'Any',
    },
  
    Builder {
        BuilderName = 'NC Air t2 to t3mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.AIR * categories.TECH3}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL) - categories.UNTARGETABLE, 'Enemy'}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                
 
            },
        BuilderType = 'Any',
    },
  
    
 
Builder {
        BuilderName = 'NC land t1 to t2mainbase',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
      
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 200 } },
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.FACTORY * categories.LAND  } },

            },
        BuilderType = 'Any',
    },

   
   
  
    
    Builder {
        BuilderName = 'NC land t1 to t2mainbase island for uef and cyb',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'FactionIndex', {1,3} },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY *  categories.TECH2}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.FACTORY * categories.LAND  } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 300, 4000 } },
 
            },
        BuilderType = 'Any',
    },
    
    
    
Builder {
        BuilderName = 'NC land t2 to t3mainbase',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
     
        BuilderConditions = {
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENERGYPRODUCTION * categories.TECH2}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.TECH2}},
            
            

            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3mainbase continued',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
     
        BuilderConditions = {
          
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.TECH3}},
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
            

            },
        BuilderType = 'Any',
    },
 
    Builder {
        BuilderName = 'NC land t2 to t3mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.TECH3}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.TECH3 * categories.LAND * categories.MOBILE, 'Enemy'}},
  
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.LAND * categories.TECH2 * categories.FACTORY } },
    
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
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        InstanceCount = 20,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY *  categories.TECH3}},
            { EBC, 'GreaterThanEconStorageCurrent', { 300, 1000 } },
            
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.LAND } },
 
            },
        BuilderType = 'Any',
    },

   
   
    Builder {
        BuilderName = 'NC land t1 to t2 ISLAND MAP uef  and cyb',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'FactionIndex', {1,3} },
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },
            { EBC, 'GreaterThanEconStorageCurrent', { 300, 1000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
           

            },
        BuilderType = 'Any',
    },
   
 
   
    Builder {
        BuilderName = 'NC land t2 to t3',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 450, 1000 } },
           
            
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY *  categories.TECH3}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.FACTORY * categories.LAND  } },
           
            
              
           
           
           --
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
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
                
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY *  categories.TECH3}},
            },
        BuilderType = 'Any',
    },
    
   
    
    Builder {
        BuilderName = 'NC Air t1 to t2 ENEMY HAS T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
     InstanceCount = 20,
     DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
           
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL) - categories.UNTARGETABLE, 'Enemy'}},
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.TECH3}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR}},
                

            },
        BuilderType = 'Any',
    },
 
   

    Builder {
        BuilderName = 'NC Air t2 to t3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
                { EBC, 'GreaterThanEconStorageCurrent', { 2500, 4000 } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.AIR * categories.TECH3}},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
                
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR}},
            

            },
        BuilderType = 'Any',
    },
   

    Builder {
        BuilderName = 'NC Air t2 to t3 ENEMY HAS T3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1200,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { MIBC, 'GreaterThanGameTime', { 1001 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.AIR * categories.TECH3}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL) - categories.UNTARGETABLE, 'Enemy'}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
            
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
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.NAVAL * categories.MOBILE } },
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.NAVAL } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.MASSEXTRACTION * (categories.TECH2 + categories.TECH3)}},
               
              
                
           --
           { EBC, 'GreaterThanEconStorageCurrent', { 300, 4000 } }, 
                
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Balanced T1 Sea Factory Upgrade adaptive',
        PlatoonTemplate = 'T1SeaFactoryUpgrade',
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { WRC, 'HaveUnitRatioVersusEnemyNC',   { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
           { EBC, 'GreaterThanEconStorageCurrent', { 300, 4000 } },  
            },
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC Balanced T2 Sea Factory Upgrade',
        PlatoonTemplate = 'T2SeaFactoryUpgrade',
        Priority = 1000,
        DelayEqualBuildPlattons = {'FactoryUpgrade', 12},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrade' }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE, 'Enemy'}},
                
			
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.NAVAL * categories.TECH2 * categories.FACTORY } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSEXTRACTION * categories.TECH3}},
          
               
           --
           { EBC, 'GreaterThanEconStorageCurrent', { 300, 4000 } }, 
                
            },
        BuilderType = 'Any',
    },
}


BuilderGroup {
    BuilderGroupName = 'NCmapcontrolupgrades',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NC Air t1 to t2 mapcontrol',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc', 20},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 15000 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
           
            
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2 regardless',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc_regardless', 10},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc_regardless' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 15000 } },
           
           
            
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Land t1 to t2 regardless',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc_regardless', 10},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc_regardless' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 15000 } },
           
           
            
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3 mapcontrol',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc', 20},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 15000 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
            },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC Air t2 to t3  regardless',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc_regardless', 10},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc_regardless' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 15000 } },
         
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Land t2 to t3  regardless',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1001,
        InstanceCount = 20,
        DelayEqualBuildPlattons = {'FactoryUpgrademc_regardless', 10},
     
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'FactoryUpgrademc_regardless' }},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 2500, 15000 } },
         
            },
        BuilderType = 'Any',
    },
   
}


