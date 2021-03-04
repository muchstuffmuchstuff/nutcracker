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
local T1landspamNC = 0.20














BuilderGroup {
    BuilderGroupName = 'NClandbehavior',
    BuildersType = 'PlatoonFormBuilder',


    
    Builder {
        BuilderName = 'NCtransportattackforce',
        PlatoonTemplate = 'NC all in',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian',},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = { 
            
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 6,  categories.LAND * categories.MOBILE - categories.ENGINEER - categories.SCOUT} },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AggressiveMove = false,
            AttackEnemyStrength = 1000,  
            TargetSearchCategory = categories.ALLUNITS,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NCt3mobilearty',
        PlatoonTemplate = 'NC arty attack mobile',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian',},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = { 
            
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5,  categories.LAND * categories.MOBILE - categories.ENGINEER - categories.SCOUT} },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = true,
            AggressiveMove = false,
            AttackEnemyStrength = 1000,  
            TargetSearchCategory = categories.ALLUNITS - categories.ENGINEER,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
   

    Builder {
        BuilderName = 'NClandaa',
        PlatoonTemplate = 'nc land anti air',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 1,
        InstanceCount = 50,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 600 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3,  categories.LAND * categories.MOBILE * categories.ANTIAIR -categories.TECH1 - categories.INSIGNIFICANTUNIT} },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 1000,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },

    Builder {
        BuilderName = 'NClandbaseguard',
        PlatoonTemplate = 'landbaseguardNC',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.LAND * categories.MOBILE - categories.EXPERIMENTAL - categories.ENGINEER - categories.SUBCOMMANDER - categories.COMMAND }},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = {


            'EXPERIMENTAL LAND',
                'ALLUNITS',
            },
        },    
      
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NClandbaseguardt3',
        PlatoonTemplate = 'landbaseguardNCt3',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 5, categories.LAND * categories.MOBILE - categories.EXPERIMENTAL - categories.ENGINEER - categories.SUBCOMMANDER - categories.COMMAND }},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH3 - categories.ENGINEER - categories.EXPERIMENTAL } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = {


            'EXPERIMENTAL LAND',
                'ALLUNITS',
            },
        },    
      
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC anti air mobile',
        PlatoonTemplate = 'NC antiairland',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
        PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 102,
        InstanceCount = 4,
        BuilderConditions = { 
        
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.ANTIAIR - categories.EXPERIMENTAL  } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
        
          
                       
			ThreatSupport = 40,
            PrioritizedCategories = { categories.MOBILE * categories.AIR


            
            },
        },    
      
        BuilderType = 'Any',
    },
    
    
       
    
    Builder {
        BuilderName = 'NC t1 spammage all game',
        PlatoonTemplate = 'NC t1spammage',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
            { MIBC, 'GreaterThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t1 spammage all game early',
        PlatoonTemplate = 'NC t1spammagesmall',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
           
            { MIBC, 'LessThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t1 aphib',
        PlatoonTemplate = 'NC t1aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
            { MIBC, 'GreaterThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH1 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t1 aphib early',
        PlatoonTemplate = 'NC t1aphibhuntai',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
            { MIBC, 'LessThanGameTime', { 1000 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH1 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t2 all game land attack',
        PlatoonTemplate = 'NC t2 ground attack', 
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        FormRadius = 300,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 450} },
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 30,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t2 aphib',
        PlatoonTemplate = 'NC t2aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH2 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },
    
    Builder {
        BuilderName = 'NC t3 all game land attack',
        PlatoonTemplate = 'NC t3 ground attack',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        FormRadius = 300,
        
        BuilderConditions = { 
            { MIBC, 'GreaterThanGameTime', { 1000} },
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 15,
           
        },    
       
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'NC t3 aphib',
        PlatoonTemplate = 'NC t3aphib',
		PlatoonAddPlans = {'PlatoonCallForHelpAISorian', 'DistressResponseAISorian'},
		PlatoonAddBehaviors = { 'AirLandToggleSorian' },
        Priority = 100,
        InstanceCount = 50,
        
        BuilderConditions = { 
        
           
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.LAND * categories.TECH3 * (categories.HOVER + categories.AMPHIBIOUS) - categories.ENGINEER } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            RequireTransport = false,
            AttackEnemyStrength = 100,  
            TargetSearchCategory = categories.STRUCTURE - categories.WALL,
            MoveToCategories = {                                               
                categories.STRUCTURE,
                
            },
            SearchRadius = 6000,
			ThreatSupport = 40,
           
        },    
       
        BuilderType = 'Any',
    },

   
    
    
}






    
    

