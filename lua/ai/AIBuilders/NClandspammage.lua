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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local SUtils = import('/lua/AI/sorianutilities.lua')

local T1masshunterNC = 0.05


--spam amphib
BuilderGroup {
    BuilderGroupName = 'NCspammage',
    BuildersType = 'FactoryBuilder',

    Builder {
        BuilderName = 'NC fake builder for coinflip',
        PlatoonTemplate = 'T1aphib',
        Priority = 1,
    
    
        BuilderConditions = {
           
     {CF,'CoinFlip2',{100}},
     
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'NC T1 land aphib standard small',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
    
        BuilderConditions = {
           
      
       { SBC, 'MapLessThan', { 1000, 1000 }}, 
      
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            
   ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'NC T1 land aphib standard',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
    
        BuilderConditions = {
           
       {CF,'Standardlandpush',{}},
       
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            
   ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land aphib late 1',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            {CF,'Standardlandpushstartlate1',{}},
            { MIBC, 'GreaterThanGameTime', { 1200 } }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land aphib late 2',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
    
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
       {CF,'Standardlandpushstartlate2',{}},
       { MIBC, 'GreaterThanGameTime', { 1800} },   
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } }, 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            
   ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land aphib late 3',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
    
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
       {CF,'Standardlandpushstartlate3',{}},
       { MIBC, 'GreaterThanGameTime', { 2800 } },  
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
           
   ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'NC T1 land aphib limited',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
        { SBC, 'MapGreaterThan', { 1000, 1000 }},  
        BuilderConditions = {
           
       {CF,'Standardlandpushlimittime',{}},
       { MIBC, 'LessThanGameTime', { 1600 } },  
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            
           
   ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },


    

    Builder {
        BuilderName = 'NC T1 land aphib ratio',
        PlatoonTemplate = 'T1aphib',
        Priority = 700,
        --
    
        BuilderConditions = {
           
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.LAND * categories.TECH1 * categories.MOBILE }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
  
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib standard small',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib standard',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            {CF,'Standardlandpush',{}},
          
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib  late 1',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            {CF,'Standardlandpushstartlate1',{}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib late 2',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            {CF,'Standardlandpushstartlate2',{}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'GreaterThanGameTime', { 1800} },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib late 3',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            {CF,'Standardlandpushstartlate3',{}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'GreaterThanGameTime', { 2800 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land aphib limited',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            {CF,'Standardlandpushlimittime',{}},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'LessThanGameTime', { 1600 } }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
			
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
     

    Builder {
        BuilderName = 'NC T2 land aphib ratio',
        PlatoonTemplate = 'T2aphib',
        Priority = 720,
        --
   
        BuilderConditions = {
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
			{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib standard small',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
           
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib standard',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
            {CF,'Standardlandpush',{}},
           
            { SBC, 'MapGreaterThan', { 1000, 1000 }},  
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib late 1',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate1',{}},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib late 2',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate2',{}},
            { MIBC, 'GreaterThanGameTime', { 1800} },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib late 3',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate3',{}},
            { MIBC, 'GreaterThanGameTime', { 2800 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib limited',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
            {CF,'Standardlandpushlimittime',{}},
            { MIBC, 'LessThanGameTime', { 1600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land aphib ratio',
        PlatoonTemplate = 'T3aphib',
        Priority = 750,
        --
      
        BuilderConditions = {
         
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  
{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND  - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'NC T1 land spammage standard small',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
        
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            ---
           
          

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage standard',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
            {CF,'Standardlandpush',{}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            ---
           
          

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage REGARDLESS',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', { 600 } }, 
            { SBC, 'MapLessThan', { 1000, 1000 }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.LAND * categories.TECH1 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
         

            { EBC, 'GreaterThanEconStorageCurrent', { 2, 30 } }, 
-- 
			{ SBC, 'NoRushTimeCheck', { 0 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage late 1',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
            {CF,'Standardlandpushstartlate1',{}},
            { MIBC, 'GreaterThanGameTime', { 1200 } },  
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            ---
            

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage late 2',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
            {CF,'Standardlandpushstartlate2',{}},
            { MIBC, 'GreaterThanGameTime', { 1800} }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            ---
            

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T1 land spammage limited',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
            {CF,'Standardlandpushlimittime',{}},
            { MIBC, 'LessThanGameTime', { 1600 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
 
    Builder {
        BuilderName = 'NC T1 land spammage ratio',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        --
    
        BuilderConditions = {
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.LAND * (categories.TECH2 + categories.TECH3) }},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  

-- 
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
   
    
    Builder {
        BuilderName = 'NC T2 land attack  standard small',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
        
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 

            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack  standard',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
            {CF,'Standardlandpush',{}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { MIBC, 'GreaterThanGameTime', { 600 } },
            ---
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 

            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack late 1',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
            {CF,'Standardlandpushstartlate1',{}},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } }, 

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack late 2',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
            {CF,'Standardlandpushstartlate2',{}},
            { MIBC, 'GreaterThanGameTime', { 1800} },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } }, 

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack late 3',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
            {CF,'Standardlandpushstartlate3',{}},
            { MIBC, 'GreaterThanGameTime', { 2800 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 

            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } }, 
{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack limited',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
            {CF,'Standardlandpushlimittime',{}},
            { MIBC, 'LessThanGameTime', { 1600 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 

            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },
{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 land attack ratio',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 749,
        --
   
        BuilderConditions = {
            
           
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.LAND * categories.TECH3 }},
            ---
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
            { EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  
{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<', categories.MASSEXTRACTION } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    
    Builder {
        BuilderName = 'NC T3 land attack standard small',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            
            { SBC, 'MapLessThan', { 1000, 1000 }}, 
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },   

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack standard',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            {CF,'Standardlandpush',{}},
             
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },   

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack late 1',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate1',{}},
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack late 2',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate2',{}},
            { MIBC, 'GreaterThanGameTime', { 1800} },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack late 3',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate3',{}},
            { MIBC, 'GreaterThanGameTime', { 2800 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack limited',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
            {CF,'Standardlandpushstartlate3',{}},
            { MIBC, 'LessThanGameTime', { 1600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 land attack group ratio',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
      
        BuilderConditions = {
         
            {CF,'Standardlandpushlimittime',{}},
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  
{ WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },

}

BuilderGroup {
    BuilderGroupName = 'NCdefense_onisland',
    BuildersType = 'FactoryBuilder',

    Builder {
        BuilderName = 'NC T1 base defense on island against t1',
        PlatoonTemplate = 'T1spammage',
        Priority = 700,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 10, categories.LAND * categories.MOBILE * categories.TECH1 - categories.ENGINEER, 150 } },
           
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 base defense on island against t2',
        PlatoonTemplate = 'T2attackgroup',
        Priority = 740,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 6, categories.LAND * categories.MOBILE * (categories.TECH1 + categories.TECH2) - categories.ENGINEER, 270 } },
            
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 base defense on island against t3',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
        InstanceCount = 2,
    
        BuilderConditions = {
           
       
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.LAND * categories.MOBILE * (categories.TECH2 + categories.TECH3) - categories.ENGINEER, 270 } },
            
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 base defense on island against EXP',
        PlatoonTemplate = 'T3attackgroup',
        Priority = 750,
        InstanceCount = 2,
    
        BuilderConditions = {

            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.LAND * categories.MOBILE * categories.EXPERIMENTAL, 300 } },
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', false } },  

{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
}

BuilderGroup {
    BuilderGroupName = 'NCdefense_antiair',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 base defense against t1 air',
        PlatoonTemplate = 'T1antiairland',
        Priority = 800,
        InstanceCount = 2,
    
        BuilderConditions = {
           
            { UCBC, 'HaveLessThanUnitsWithCategory', {5, categories.MOBILE * categories.ANTIAIR * categories.LAND } },
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.AIR * categories.MOBILE * categories.TECH1 - categories.SCOUT - categories.TRANSPORTFOCUS, 100 } },
           
            
		
            ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  
-- 
          
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 defense against t2 air',
        PlatoonTemplate = 'T2antiairland',
        Priority = 840,
        InstanceCount = 2,
    
        BuilderConditions = {
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', {40, categories.MOBILE * categories.ANTIAIR * categories.LAND * (categories.TECH2 + categories.TECH3) } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 1.5, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },

{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 defense against t3 air',
        PlatoonTemplate = 'T3antiairland',
        Priority = 850,
        InstanceCount = 2,
    
        BuilderConditions = {
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', {40, categories.MOBILE * categories.ANTIAIR * categories.LAND * categories.TECH3 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 1.5, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '<=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
{ EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},
       --
        },
        BuilderType = 'Land',
    },
   
    Builder {
        BuilderName = 'NC T3 base defense against enemy buildings',
        PlatoonTemplate = 'T1spammage',
        Priority = 650,
     
    
        BuilderConditions = {
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 5, categories.MOBILE * categories.LAND, 100 } },

{ EBC, 'GreaterThanEconStorageCurrent', { 8, 150 } },  

			{ SBC, 'NoRushTimeCheck', { 600 }},

        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T2 mobile missle',
        PlatoonTemplate = 'T2mobileturtlecracker',
        Priority = 660,
        BuilderConditions = {
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 8, categories.STRUCTURE * (categories.TECH2 + categories.TECH3) * (categories.ARTILLERY + categories.DIRECTFIRE), 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
{ EBC, 'GreaterThanEconStorageCurrent', { 16, 450 } },  
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC T3 mobile missle',
        PlatoonTemplate = 'T3mobileturtlecracker',
        Priority = 761,
        BuilderConditions = {
            { WRC, 'CanPathToCurrentEnemyNC', { 'LocationType', true } },  
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 8, categories.STRUCTURE * (categories.TECH2 + categories.TECH3) * (categories.ARTILLERY + categories.DIRECTFIRE), 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '>=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
            { EBC, 'GreaterThanEconStorageCurrent', { 24, 750 } },  
			{ SBC, 'NoRushTimeCheck', { 600 }},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'NC lots of RAS',
        PlatoonTemplate = 'NC RAS',
        Priority = 950,
        DelayEqualBuildPlattons = {'Ras', 10},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Ras' }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            {CF,'TeleportStrategyNotRunning',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 1500, 4000 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.SUBCOMMANDER } },
            
            
        },
        BuilderType = 'Gate',
    },
    

  
}


