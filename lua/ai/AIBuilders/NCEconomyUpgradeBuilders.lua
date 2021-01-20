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
local Tech2MassExtractortoTech1ExtractorRatio = 0.80
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')
local T1landspamnearlymaxedoutNC = 0.19



BuilderGroup {
    BuilderGroupName = 'NCmassupgrade',
    BuildersType = 'PlatoonFormBuilder',
 Builder {
        BuilderName = 'NC mass upgrades tech2',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
   
        
       { MIBC, 'GreaterThanGameTime', { 200 } },
            
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.MASSEXTRACTION * categories.TECH1} },
           
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 incomeupgrade',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 1500, 2000 } },
       { MIBC, 'GreaterThanGameTime', { 400 } },
       { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 3, categories.MASSEXTRACTION * categories.TECH1} },
            
           
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 incomeupgrade2',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
       --
       { EBC, 'GreaterThanEconStorageCurrent', { 2500, 5000 } },
       { MIBC, 'GreaterThanGameTime', { 750 } },
    
       { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 4, categories.MASSEXTRACTION * categories.TECH1} },
           
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 incomeupgrade3 many',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
       --
       
       { MIBC, 'GreaterThanGameTime', { 1200 } },
       { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.MASSEXTRACTION * categories.TECH1 } },     
       { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 6, categories.MASSEXTRACTION * categories.TECH1} },
           
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech2 incomeupgrade3 full control',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
       --
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 7.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
       { MIBC, 'GreaterThanGameTime', { 1200 } },
         
       { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 6, categories.MASSEXTRACTION * categories.TECH1} },
           
		
         
            
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
       --
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            
          
          
           
          
         
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.MASSEXTRACTION * categories.TECH2}},
            
                   
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO_income',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
       --
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 15000 } },
          
          
           
          
          
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.MASSEXTRACTION * categories.TECH2}},
            
                   
	
       
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC mass upgrades tech3 RATIO_FULL_CONTROL',
        PlatoonTemplate = 'T2MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 10000,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1600 } },
       --
            { UCBC, 'HaveUnitRatio', { Tech2MassExtractortoTech1ExtractorRatio, categories.MASSEXTRACTION * categories.TECH2, '>=', categories.MASSEXTRACTION * categories.TECH1 } },
           
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 7.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
          
           
          
       
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 3, categories.MASSEXTRACTION * categories.TECH2}},
            
                   
	
       
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
            { MIBC, 'GreaterThanGameTime', { 400 } },
          
      
               
            { EBC, 'GreaterThanEconStorageCurrent', { 25, 100 } },
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.AIR }},
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase MANY',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
           
               
             
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.FACTORY * categories.AIR} },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.AIR * categories.FACTORY}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC Air t1 to t2mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
           
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
            --- 
             
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 4, categories.AIR * categories.FACTORY } },
         
           
           
           --
            },
        BuilderType = 'Any',
    },
   

    Builder {
        BuilderName = 'NC Air t2 to t3mainbase',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1050,
        InstanceCount = 1,
        BuilderConditions = {
            
            
        

            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.ENERGYPRODUCTION * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.AIR * categories.TECH3 } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.FACTORY * categories.AIR}},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3mainbase MANY',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
            
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ENERGYPRODUCTION * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.AIR * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.FACTORY * categories.AIR}},
           
           
           --
            },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC Air t2 to t3mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1001 } },
        
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 4, categories.AIR * categories.FACTORY } },
              
           
           
           --
            },
        BuilderType = 'Any',
    },
    
 
Builder {
        BuilderName = 'NC land t1 to t2mainbase',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
 
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 25, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.LAND * categories.FACTORY } },
            
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
            
           
              
               
              
          
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2mainbase 2ND OPTION',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
 
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 9, categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.LAND } },
            
           
              
               
              
          
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2mainbase maxed out t1 units',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 10,
 
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 10000, 20000 } },
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamnearlymaxedoutNC , '>', categories.TECH1 * categories.MOBILE * categories.LAND - categories.ENGINEER} }, 
           
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 5, categories.FACTORY  } },
            
           
              
               
              
          
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2mainbase island for uef and cyb',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
 
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1,3} },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },
            { MIBC, 'GreaterThanGameTime', { 300 } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.LAND * categories.FACTORY } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.LAND * categories.TECH2  } },
            
           
              
               
              
          
           
           
           --
            },
        BuilderType = 'Any',
    },
    
 
    
Builder {
        BuilderName = 'NC land t2 to t3mainbase',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
 
        InstanceCount = 1,
        BuilderConditions = {
        
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
        
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.LAND * categories.FACTORY } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
          
           
           
           --
            },
        BuilderType = 'Any',
    },
 
 
    Builder {
        BuilderName = 'NC land t2 to t3mainbase ENEMY HAS T3',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },

            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.TECH3 * categories.LAND * categories.MOBILE, 'Enemy'}},
  
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.LAND * categories.TECH2 * categories.FACTORY } },
    
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3mainbase MAXED OUT SPAM',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
 
        InstanceCount = 10,
        BuilderConditions = {
        
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamnearlymaxedoutNC , '>', categories.TECH1 * categories.MOBILE * categories.LAND - categories.ENGINEER } }, 
          
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 5, categories.FACTORY * categories.LAND} },
          
           
           
           --
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
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
         
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
         
              
             
           
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2 MAXED OUT SPAM',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
          
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamnearlymaxedoutNC , '>', categories.TECH1 * categories.MOBILE * categories.LAND - categories.ENGINEER }}, 
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 5, categories.LAND *  categories.FACTORY } },
         
              
             
           
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2 ISLAND MAP uef  and cyb',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'FactionIndex', {1,3} },
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.LAND *  categories.FACTORY } },
           
              
             
           
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t1 to t2 many',
        PlatoonTemplate = 'T1LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH2 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.LAND * categories.FACTORY} },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.LAND *  categories.FACTORY } },
         
              
             
           
           
           
           --
            },
        BuilderType = 'Any',
    },
 
   
    Builder {
        BuilderName = 'NC land t2 to t3',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
           
            
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH3 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.LAND * categories.FACTORY } },
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
            
              
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3 MAXED OUT SPAM',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
           
            { UCBC, 'HaveUnitRatioVersusCap', { T1landspamnearlymaxedoutNC , '>', categories.TECH1 * categories.MOBILE * categories.LAND - categories.ENGINEER }}, 
           
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 5, categories.LAND *  categories.FACTORY } },
            
              
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC land t2 to t3 many',
        PlatoonTemplate = 'T2LandFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
          
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.LAND * categories.FACTORY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.FACTORY * categories.TECH3 } },
           
            { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.LAND * categories.FACTORY } },
            
              
           
           
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
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            
               
             
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.AIR * categories.FACTORY}},
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.FACTORY * categories.AIR }},
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2 many',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1000,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 400 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
            
               
             
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.AIR * categories.FACTORY } },
              { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.AIR * categories.FACTORY}},
              
           
           
           --
            },
        BuilderType = 'Any',
    },
   
    
    Builder {
        BuilderName = 'NC Air t1 to t2 ENEMY HAS T3',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
           
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
            --- 
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR}},
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.AIR * categories.TECH2 * categories.FACTORY } },
         
         
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t1 to t2 ENEMY HAS T3 many',
        PlatoonTemplate = 'T1AirFactoryUpgrade',
        Priority = 1200,
     
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 800 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 60, 100 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
            --- 
           
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.FACTORY * categories.AIR}},
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.AIR * categories.TECH2 * categories.FACTORY } },
             
         
           
           
           --
            },
        BuilderType = 'Any',
    },
   

    Builder {
        BuilderName = 'NC Air t2 to t3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            
            { EBC, 'GreaterThanEconStorageCurrent', { 50, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR}},
            
           
           
           --
            },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC Air t2 to t3 many',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1000,
        InstanceCount = 1,
        BuilderConditions = {
            
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 100 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 2, categories.AIR * categories.TECH2 * categories.FACTORY } },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.FACTORY * categories.AIR}},
            
           
           
           --
            },
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NC Air t2 to t3 ENEMY HAS T3',
        PlatoonTemplate = 'T2AirFactoryUpgrade',
        Priority = 1200,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1001 } },
        
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE * (categories.TECH3 + categories.EXPERIMENTAL), 'Enemy'}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2}},
            --- 
       
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.AIR * categories.TECH2 * categories.FACTORY } },
             
              
           
           
           --
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
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.FACTORY * categories.NAVAL } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 4, 'MASSEXTRACTION TECH2, MASSEXTRACTION TECH3'}},
               
              
                
           --
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 } },
                
            },
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC Balanced T2 Sea Factory Upgrade',
        PlatoonTemplate = 'T2SeaFactoryUpgrade',
        Priority = 800,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE, 'Enemy'}},
                { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 3, 'FACTORY TECH3, FACTORY TECH2' } },
				#{ SIBC, 'HaveGreaterThanUnitsWithCategory', { 3, 'FACTORY TECH3, FACTORY TECH2'}},
                { EN, 'HaveLessThanUnitsInCategoryBeingUpgradeNC', { 1, categories.NAVAL * categories.TECH2 * categories.FACTORY } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, 'MASSEXTRACTION TECH3'}},
          
               
           --
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.25 }},
                
            },
        BuilderType = 'Any',
    },
}





