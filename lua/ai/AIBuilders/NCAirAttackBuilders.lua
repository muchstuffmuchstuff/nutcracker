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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local transporttolandforceratio = 0.05
local Tech3airfactoryrelativetotech2and1 = 0.30


local SUtils = import('/lua/AI/sorianutilities.lua')




BuilderGroup {
    BuilderGroupName = 'NCexcessairunitsbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC Torpedo Bombers',
        PlatoonTemplate = 'NCt2t3TorpedoBomber',
        PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        Priority = 100,
        InstanceCount = 50,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, 'ANTINAVY AIR MOBILE' } },
            { SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC kill navy with air',
        PlatoonTemplate = 'navalhunters',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10,
            FormRadius = 500,
            InstanceCount = 50,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.ANTINAVY * categories.MOBILE } },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                   
                    'NAVAL MOBILE',
                    'FACTORY NAVAL',
                                   
    
                    
                    
                },
            },
        },  
    
    Builder {
        BuilderName = 'NC clenseexcess bombersT1T2 mex',
        PlatoonTemplate = 'clenseNCt1t2',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10,
            FormRadius = 500,
            InstanceCount = 50,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
                {CF,'bomberallowed',{}},
                { MIBC, 'LessThanGameTime', { 1000} },
                { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.uea0103 + categories.uaa0103 + categories.ura0103 + categories.xsa0103} },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                AvoidBases = true,
                AvoidBasesRadius = 100,
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                    'EXPERIMENTAL LAND',
                    'EXPERIMENTAL STRUCTURE',
                    'MASSEXTRACTION',
                   
                                   
    
                    
                    
                },
            },
        },
        Builder {
            BuilderName = 'NC clenseexcess bombersT1T2',
            PlatoonTemplate = 'clenseNCt1t2',
                PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                Priority = 10,
                FormRadius = 500,
                InstanceCount = 50,
                AggressiveMove = true,
                BuilderType = 'Any',
                BuilderConditions = {
                    {CF,'bomberallowed',{}},
                    { MIBC, 'GreaterThanGameTime', { 600} },
                             { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.uea0103 + categories.uaa0103 + categories.ura0103 + categories.xsa0103} },
                    { SBC, 'NoRushTimeCheck', { 0 }},
                },
                BuilderData = {
                    AvoidBases = true,
                    AvoidBasesRadius = 100,
                    SearchRadius = 5000,
                    
                    PrioritizedCategories = {    
        
                        'EXPERIMENTAL LAND',
                        'EXPERIMENTAL STRUCTURE',
                        'MASSEXTRACTION',
                                       
        
                        
                        
                    },
                },
            },

            Builder {
                BuilderName = 'NC clenseexcess bombersT3 no nuke',
                PlatoonTemplate = 'clenseNCt3',
                    PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                    PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                    Priority = 10,
                    FormRadius = 500,
                    InstanceCount = 100,
                    AggressiveMove = true,
                    BuilderType = 'Any',
                    BuilderConditions = {
                        {CF,'bomberallowed',{}},
                        { MIBC, 'GreaterThanGameTime', { 900} },
                        { UCBC, 'HaveLessThanUnitsWithCategory', {1, categories.NUKE * categories.STRUCTURE } },
                        
                                 { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * categories.TECH3 * categories.BOMBER  * categories.MOBILE - categories.TRANSPORTFOCUS -  categories.GROUNDATTACK - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                        { SBC, 'NoRushTimeCheck', { 0 }},
                    },
                    BuilderData = {
                        SearchRadius = 5000,
                        
                        PrioritizedCategories = {    
            
                                         
                            'EXPERIMENTAL LAND',
                            'EXPERIMENTAL STRUCTURE',
                            'MASSEXTRACTION TECH3',
                            'MASSEXTRACTION TECH2',
                            
                                           
            
                            
                            
                        },
                    },
                },


            

        Builder {
            BuilderName = 'NC clenseexcess bombersT3',
            PlatoonTemplate = 'clenseNCt3',
                PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                Priority = 10,
                FormRadius = 500,
                InstanceCount = 100,
                AggressiveMove = true,
                BuilderType = 'Any',
                BuilderConditions = {
                    {CF,'bomberallowed',{}},
                    { MIBC, 'GreaterThanGameTime', { 900} },
                    { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.SHIELD, 'Enemy'}},
                    { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.NUKE * categories.STRUCTURE } },
                    { WRC, 'HaveUnitRatioVersusEnemyNC', { 0.99, categories.STRUCTURE * categories.NUKE, '<=', categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE } },
                             { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * categories.TECH3 * categories.BOMBER  * categories.MOBILE - categories.TRANSPORTFOCUS -  categories.GROUNDATTACK - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                    { SBC, 'NoRushTimeCheck', { 0 }},
                },
                BuilderData = {
                    SearchRadius = 5000,
                    
                    PrioritizedCategories = {    
        
                                     
                        'EXPERIMENTAL LAND',
                        'EXPERIMENTAL STRUCTURE',
                        'MASSEXTRACTION TECH3',
                        'MASSEXTRACTION TECH2',
   
                    },
                },
            },
            
            Builder {
                BuilderName = 'NC clenseexcess bombersT3 anti cmd',
                PlatoonTemplate = 'clenseNCt3_cmdsnipe',
                    PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                    PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                    Priority = 10,
                    FormRadius = 500,
                    InstanceCount = 100,
                    AggressiveMove = true,
                    BuilderType = 'Any',
                    BuilderConditions = {
                        {CF,'bomberallowed',{}},
                        { MIBC, 'GreaterThanGameTime', { 900} },
                        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 1, categories.SHIELD, 'Enemy'}},
                                 { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * categories.TECH3 * categories.BOMBER  * categories.MOBILE - categories.TRANSPORTFOCUS -  categories.GROUNDATTACK - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                        { SBC, 'NoRushTimeCheck', { 0 }},
                    },
                    BuilderData = {
                        SearchRadius = 5000,
                        
                        PrioritizedCategories = {    
            
                            'COMMAND,'    
                           
                            
                                           
            
                            
                            
                        },
                    },
                },
            Builder {
                BuilderName = 'NC clenseexcess bombersT3 anti nuke',
                PlatoonTemplate = 'clenseNCt3',
                    PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                    PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                    Priority = 10,
                    FormRadius = 500,
                    InstanceCount = 100,
                    AggressiveMove = true,
                    BuilderType = 'Any',
                    BuilderConditions = {
                        {CF,'bomberallowed',{}},
                        { MIBC, 'GreaterThanGameTime', { 900} },
                        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.SHIELD, 'Enemy'}},
                        { UCBC, 'HaveGreaterThanUnitsWithCategory', {0, categories.NUKE * categories.STRUCTURE } },
                        { WRC, 'HaveUnitRatioVersusEnemyNC', { 1, categories.STRUCTURE * categories.NUKE, '>=', categories.STRUCTURE * categories.TECH3 * categories.ANTIMISSILE } },
                                 { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * categories.TECH3 * categories.BOMBER  * categories.MOBILE - categories.TRANSPORTFOCUS -  categories.GROUNDATTACK - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                        { SBC, 'NoRushTimeCheck', { 0 }},
                    },
                    BuilderData = {
                        SearchRadius = 5000,
                        
                        PrioritizedCategories = {    
            
                            'ANTIMISSILE TECH3',
                            'EXPERIMENTAL LAND',
                            'EXPERIMENTAL STRUCTURE',
                            'MASSEXTRACTION TECH3',
                            'MASSEXTRACTION TECH2',      
                           
                            
                                           
            
                            
                            
                        },
                    },
                },
        Builder {
            BuilderName = 'NC clenseexcess gunshipsT1t2',
            PlatoonTemplate = 'clensegunshipsNCt1t2',
                PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                Priority = 10,
                FormRadius = 500,
                InstanceCount = 50,
                AggressiveMove = true,
                BuilderType = 'Any',
                BuilderConditions = {
                    {CF,'gunshipallowed',{}},
                             { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR * (categories.TECH1 + categories.TECH2) * categories.GROUNDATTACK  * categories.MOBILE  - categories.BOMBER - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                    { SBC, 'NoRushTimeCheck', { 0 }},
                },
                BuilderData = {
                    SearchRadius = 5000,
                    
                    PrioritizedCategories = {    
        
                        'EXPERIMENTAL LAND',
                        'EXPERIMENTAL STRUCTURE',
                        'MOBILE LAND',
                                     
                                       
        
                        
                        
                    },
                },
            },
            Builder {
                BuilderName = 'NC clenseexcess gunshipst3',
                PlatoonTemplate = 'clensegunshipsNCt3',
                    PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
                    PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
                    Priority = 10,
                    FormRadius = 500,
                    InstanceCount = 50,
                    AggressiveMove = true,
                    BuilderType = 'Any',
                    BuilderConditions = {
                        {CF,'gunshipallowed',{}},
                        { MIBC, 'GreaterThanGameTime', { 1200} },
                                 { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR * categories.TECH3  * categories.MOBILE * categories.GROUNDATTACK  - categories.TRANSPORTFOCUS - categories.BOMBER - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                        { SBC, 'NoRushTimeCheck', { 0 }},
                    },
                    BuilderData = {
                        SearchRadius = 5000,
                        
                        PrioritizedCategories = {    
            
                            'EXPERIMENTAL LAND',
                            'EXPERIMENTAL STRUCTURE',
                            'MASSEXTRACTION TECH3',
                            'MASSEXTRACTION TECH2',
                            
             
                        },
                    },
                },
    }


   

  

BuilderGroup {
    BuilderGroupName = 'NCexcessresourcest1bomberbuild',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC t1bomber lots of cash big map',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 10,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { SBC, 'MapLessThan', { 3000, 3000 }},
            {CF,'bomberallowed',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
            { UCBC, 'HaveUnitRatio', { Tech3airfactoryrelativetotech2and1, categories.FACTORY * categories.AIR * categories.TECH3, '<=', categories.FACTORY * categories.AIR * (categories.TECH1 + categories.TECH2) } },
            
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
        }, 
    },
    Builder {
        BuilderName = 'NC t1bomber continuous',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 10,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { SBC, 'NoRushTimeCheck', { 0 }},
            { SBC, 'MapLessThan', { 3000, 3000 }},
            {CF,'bomberallowed',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
            { SIBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.BOMBER * categories.AIR * categories.TECH1 }},
      
           
        }, 
    },
    Builder {
        BuilderName = 'NC t1bomber fight for control',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 10,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { SBC, 'NoRushTimeCheck', { 0 }},
            { SBC, 'MapLessThan', { 3000, 3000 }},
            {CF,'bomberallowed',{}},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
            { UCBC, 'HaveUnitRatio', { Tech3airfactoryrelativetotech2and1, categories.FACTORY * categories.AIR * categories.TECH3, '<=', categories.FACTORY * categories.AIR * (categories.TECH1 + categories.TECH2) } }, 
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '<=', categories.MASSEXTRACTION } },
           
        }, 
    },

}

BuilderGroup {
    BuilderGroupName = 'NCfindenemyfightersbehavior',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NC T4Guard',
        PlatoonTemplate = 'NCGuardT4',
        PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
        PlatoonAddPlans = { 'AirIntelToggle' },
        Priority = 400,
        InstanceCount = 1,
        BuilderData = {
            NeverGuardEngineers = true,
        },
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'FactionIndex', {2, 3}},
            { SIBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.EXPERIMENTAL * categories.AIR}},
            { SBC, 'NoRushTimeCheck', { 0 }},
        },
    },
    Builder {
        BuilderName = 'NC finding enemy fighters',
        PlatoonTemplate = 'NCfighterhuntert1',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 5,
       
       
        BuilderType = 'Any',
     
        BuilderConditions = {
                       
                        { MIBC, 'LessThanGameTime', { 1319} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            AvoidBases = true,
            AvoidBasesRadius = 100,
            SearchRadius = 6000,
            PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
            categories.TRANSPORTFOCUS,
            categories.BOMBER,
            categories.GROUNDATTACK,
            categories.ANTIAIR * categories.AIR,
            categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                
       
		
            },
        },
    },
    Builder {
        BuilderName = 'NC finding enemy fighters t1 late',
        PlatoonTemplate = 'NCfighterhuntert1_late',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 5,
       
       
        BuilderType = 'Any',
     
        BuilderConditions = {
                       
            { MIBC, 'GreaterThanGameTime', { 1320} },
         
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            AvoidBases = true,
            AvoidBasesRadius = 100,
            SearchRadius = 6000,
            PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
            categories.TRANSPORTFOCUS,
            categories.BOMBER,
            categories.GROUNDATTACK,
            categories.ANTIAIR * categories.AIR,
            categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                
       
		
            },
        },
    },
  
    Builder {
        BuilderName = 'NC finding enemy fighters t3',
        PlatoonTemplate = 'NCfighterhuntert3',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 5,
       
       
        BuilderType = 'Any',
     
        BuilderConditions = {
                       
                        { MIBC, 'LessThanGameTime', { 1319} },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            AvoidBases = true,
            AvoidBasesRadius = 100,
            SearchRadius = 6000,
            PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
            categories.TRANSPORTFOCUS,
            categories.BOMBER,
            categories.GROUNDATTACK,
            categories.ANTIAIR * categories.AIR,
            categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                
       
		
            },
        },
    },
    Builder {
        BuilderName = 'NC finding enemy fighters t3 late',
        PlatoonTemplate = 'NCfighterhuntert3_late',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 8,
       
       
        BuilderType = 'Any',
     
        BuilderConditions = {
                       
            { MIBC, 'GreaterThanGameTime', { 1320} },
           
         
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			
        },
        BuilderData = {
            AvoidBases = true,
            AvoidBasesRadius = 100,
            SearchRadius = 6000,
            PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
            categories.ANTIAIR * categories.AIR * categories.TECH3,
            categories.ANTIAIR * categories.AIR * categories.TECH2,
            categories.ANTIAIR * categories.AIR * categories.TECH1,
            categories.TRANSPORTFOCUS,
            categories.BOMBER,
            categories.GROUNDATTACK,
            categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                
       
		
            },
        },
    },

    
   
   

   
    Builder {
        BuilderName = 'NC guard the base fighters',
        PlatoonTemplate = 'ncguardbaseair',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 500,
        
        InstanceCount = 1,
       
        BuilderType = 'Any',
        BuilderConditions = {
                       
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.AIR * categories.MOBILE * categories.ANTIAIR - categories.EXPERIMENTAL }},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			
			
         

                PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
                categories.TRANSPORTFOCUS,
                categories.ANTIAIR * categories.AIR,
                categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                                
				
				
            },
        },
    },
    Builder {
        BuilderName = 'NC guard the base gunships',
        PlatoonTemplate = 'ncguardbasegroundgunship',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 10,
        
        InstanceCount = 1,
       
        BuilderType = 'Any',
        BuilderConditions = {
            {CF,'gunshipallowed',{}},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.AIR * categories.MOBILE * categories.GROUNDATTACK - categories.EXPERIMENTAL }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.MOBILE * categories.LAND * categories.EXPERIMENTAL, 'Enemy'}},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.GROUNDATTACK * categories.TECH3 - categories.ANTIAIR - categories.EXPERIMENTAL  - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL LAND',
                                'MOBILE LAND',
                                
                                
				
				
            },
        },
    },
    Builder {
        BuilderName = 'NC guard the base bombers',
        PlatoonTemplate = 'ncguardbasegroundbomber',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 10,
        
        InstanceCount = 1,
       
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.AIR * categories.MOBILE * categories.BOMBER * categories.TECH3 - categories.EXPERIMENTAL }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.MOBILE * categories.LAND * categories.EXPERIMENTAL, 'Enemy'}},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.BOMBER * categories.TECH3  - categories.ANTIAIR - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
			
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL LAND',
                                'MOBILE LAND',
                                
                                
				
				
            },
        },
    },
}

    BuilderGroup {
        BuilderGroupName = 'NCt4airsnipebehavior',
        BuildersType = 'PlatoonFormBuilder',
        Builder {
            BuilderName = 'NC building to kill t4 air',
            PlatoonTemplate = 'NCt4snipe',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian','PlatoonCallForHelpAISorian'},
            Priority = 5000,
            InstanceCount = 50,
            FormRadius = 500,
            BuilderType = 'Any',
            BuilderConditions = {
                           
                            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
                            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.SCOUT } },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                AvoidBases = true,
        AvoidBasesRadius = 100,
                SearchRadius = 5000,
                
            
    
                    PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
                  
                    categories.ANTIAIR * categories.AIR,
                    categories.AIR - categories.SCOUT,
                    
                    
                },
            },
        },
       
    }


    

    BuilderGroup {
        BuilderGroupName = 'NCacusnipe',
        BuildersType = 'FactoryBuilder',
        
        Builder {
            BuilderName = 'NC T3 Air bomber air control',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 750,
        
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 500, 500 }},
                { MIBC, 'GreaterThanGameTime', { 800 } },
                {CF,'bomberallowed',{}}, 
                
                { SBC, 'LessThanThreatAtEnemyBase', { 'AntiAir', 100 }},
                { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
                
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  

            },
        },
        Builder {
            BuilderName = 'NC T3 Air bomber adaptive',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 1000,
        
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 500, 500 }},
                { MIBC, 'GreaterThanGameTime', { 800 } },
                { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
              
                { WRC, 'HaveUnitRatioVersusEnemyNC', { 5.0, categories.MASSEXTRACTION, '>=', categories.MASSEXTRACTION } },
                
                { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR  - categories.SCOUT - categories.TRANSPORTFOCUS } },
           
            },
        },

    }


    BuilderGroup {
        BuilderGroupName = 'NCAntiLandQuickBuild',
        BuildersType = 'FactoryBuilder',
        
    Builder {
            BuilderName = 'NC t1bomber anti factory rush',
            PlatoonTemplate = 'T1AirBomberantispam',
            Priority = 1000,
         
            BuilderType = 'Air',
            BuilderConditions = {
                {CF,'bomberallowed',{}},
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.AIR * (categories.TECH2 + categories.TECH3) }},
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 }},
                
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 250 } },
              
                { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } }, 
                
             
            },
        },  
     
     
    }


    
  

 
BuilderGroup {
    BuilderGroupName = 'NCairstaging',
    BuildersType = 'EngineerBuilder',
Builder {
        BuilderName = 'NC T2 Air Staging get r done',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 1925,
        BuilderConditions = {
         
          
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
--
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.AIRSTAGINGPLATFORM * categories.STRUCTURE}},
            
            
        },
        BuilderType = 'Any',
        BuilderData = {
        
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2AirStagingPlatform',
                },
                Location = 'LocationType',
            }
        }
    },

}



BuilderGroup {
    BuilderGroupName = 'NCTransportFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Air Transport early game mapsize',
        PlatoonTemplate = 'T1AirTransport',
        DelayEqualBuildPlattons = {'Transport', 12},
        Priority = 800,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Transport' }},
            { SIBC, 'HaveLessThanUnitsForMapSize', { {[256] = 2, [512] = 2, [1024] = 3, [2048] = 4, [4096] = 5}, categories.TRANSPORTFOCUS}},
            
            { MIBC, 'LessThanGameTime', { 530 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTFOCUS' } },
        
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'NC T1 Air Transport ratio',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 700,
        DelayEqualBuildPlattons = {'Transport', 12},
        BuilderConditions = {         
            { UCBC, 'CheckBuildPlattonDelay', { 'Transport' }},
            { MIBC, 'GreaterThanGameTime', { 530 } },
       { UCBC, 'HaveUnitRatio', { transporttolandforceratio, categories.TRANSPORTFOCUS, '<=', categories.LAND * categories.MOBILE - categories.ENGINEER - categories.SCOUT - categories.EXPERIMENTAL - categories.ANTIAIR } },
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
       { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },   
       {EN, 'HaveLessThanArmyPoolWithCategoryNC', {3, categories.TRANSPORTFOCUS}},
        },
        BuilderType = 'Air',
    },
   
    Builder {
        BuilderName = 'NC T2 Air Transport',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 788,
        DelayEqualBuildPlattons = {'Transport', 12},
        BuilderConditions = {
         
            { UCBC, 'CheckBuildPlattonDelay', { 'Transport' }},
            { UCBC, 'HaveUnitRatio', { transporttolandforceratio, categories.TRANSPORTFOCUS, '<=', categories.LAND * categories.MOBILE - categories.ENGINEER - categories.SCOUT - categories.EXPERIMENTAL - categories.ANTIAIR } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },   
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {3, categories.TRANSPORTFOCUS}},


           
        },
        BuilderType = 'Air',
    },

    Builder {
        BuilderName = 'NC T3 Air Transport Default',
        PlatoonTemplate = 'T3AirTransport',
        Priority = 790,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Transport' }},
            { UCBC, 'HaveUnitRatio', { transporttolandforceratio, categories.TRANSPORTFOCUS, '<=', categories.LAND * categories.MOBILE - categories.ENGINEER - categories.SCOUT - categories.EXPERIMENTAL - categories.ANTIAIR } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },   
            {EN, 'HaveLessThanArmyPoolWithCategoryNC', {3, categories.TRANSPORTFOCUS}},
            
        },
        BuilderType = 'Air',
    },  
}

BuilderGroup {
    BuilderGroupName = 'NCAntiNavyQuickBuild',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3 Air Gunship',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 750,
        BuilderType = 'Air',
        BuilderConditions = {
         
            { MIBC, 'GreaterThanGameTime', { 600 } },
            {CF,'gunshipallowed',{}},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.MOBILE,  'Enemy' }},
          ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
--
            
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.GROUNDATTACK * categories.TECH3 } },
        },
    },
    
    Builder {
        BuilderName = 'NC Torp Bomber',
        PlatoonTemplate = 'NCtorpbomber',
        Priority = 754,
        BuilderType = 'Air',
        BuilderConditions = {
           
            { SBC, 'NoRushTimeCheck', { 600 }},
            { EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 0.35, categories.MOBILE * categories.AIR * categories.ANTINAVY, '<=', categories.MOBILE * categories.NAVAL } },
            
        },
    }
  
}








  

    
    

BuilderGroup {
    BuilderGroupName = 'NCT3AirFactoryBuilders',
    BuildersType = 'FactoryBuilder',
 
    Builder {
        BuilderName = 'NC T3 Air Gunship - Anti land',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 705,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            {CF,'gunshipallowed',{}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 4.0, categories.MOBILE * categories.LAND - categories.ENGINEER, '<=', categories.MOBILE * categories.LAND - categories.ENGINEER} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
          ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 100 } },  
--
            
			
        },
    },


  
  
   


}

