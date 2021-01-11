#***************************************************************************
#*
#**  File     :  /lua/ai/SorianAirAttackBuilders.lua
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
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'



local SUtils = import('/lua/AI/sorianutilities.lua')

function AirAttackCondition(aiBrain, locationType, targetNumber )
	local UC = import('/lua/editor/UnitCountBuildConditions.lua')
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
	if not engineerManager then
        return true
    end
	if aiBrain:GetCurrentEnemy() then
		local estartX, estartZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
		targetNumber = aiBrain:GetThreatAtPosition( {estartX, 0, estartZ}, 1, true, 'AntiAir' )
	end
	
    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager:GetLocationRadius()
    
    --local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE, position, radius )
	local surfaceThreat = pool:GetPlatoonThreat( 'AntiSurface', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE)
    local airThreat = 0 #pool:GetPlatoonThreat( 'AntiAir', categories.MOBILE * categories.AIR - categories.EXPERIMENTAL - categories.SCOUT - categories.INTELLIGENCE, position, radius )
    if ( surfaceThreat + airThreat ) >= targetNumber then
        return true
	elseif UC.UnitCapCheckGreater(aiBrain, .95) then
		return true
	elseif SUtils.ThreatBugcheck(aiBrain) then -- added to combat buggy inflated threat
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.AIR * categories.TECH3 * (categories.GROUNDATTACK + categories.BOMBER)) and surfaceThreat > 120 then #8 Units x 15
		return true
	elseif UC.PoolGreaterAtLocation(aiBrain, locationType, 0, categories.MOBILE * categories.AIR * categories.TECH2 * (categories.GROUNDATTACK + categories.BOMBER))
	and UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.AIR * categories.TECH3 * (categories.GROUNDATTACK + categories.BOMBER)) and surfaceThreat > 25 then #5 Units x 5
		return true
	elseif UC.PoolLessAtLocation(aiBrain, locationType, 1, categories.MOBILE * categories.AIR * (categories.GROUNDATTACK + categories.BOMBER) - categories.TECH1) and surfaceThreat > 6 then #3 Units x 2
		return true
    end
    return false
end


BuilderGroup {
    BuilderGroupName = 'NCexcessairunitsbehavior',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'NC kill land exp with torp bombers',
        PlatoonTemplate = 'navalhunters',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10,
            FormRadius = 500,
            InstanceCount = 10,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
     
                { SBC, 'IsIslandMap', { true } },
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.LAND * categories.EXPERIMENTAL * categories.MOBILE,  'Enemy' }},
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.ANTINAVY * categories.MOBILE} },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = { 

                    'EXPERIMENTAL LAND MOBILE',
                    'ALLUNITS',
    
                   
                   
                                   
    
                    
                    
                },
            },
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
        BuilderName = 'NC clenseexcess bombersT1T2',
        PlatoonTemplate = 'clenseNCt1t2',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10,
            FormRadius = 500,
            InstanceCount = 25,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * (categories.TECH1 + categories.TECH2) * categories.BOMBER   * categories.MOBILE - categories.TRANSPORTFOCUS - categories.ANTINAVY - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102} },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                    'EXPERIMENTAL LAND',
                    'MOBILE LAND',
                                   
    
                    
                    
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
                InstanceCount = 10,
                AggressiveMove = true,
                BuilderType = 'Any',
                BuilderConditions = {
                    { MIBC, 'GreaterThanGameTime', { 1200} },
                             { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR  * categories.TECH3 * categories.BOMBER  * categories.MOBILE - categories.TRANSPORTFOCUS -  categories.GROUNDATTACK - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                    { SBC, 'NoRushTimeCheck', { 0 }},
                },
                BuilderData = {
                    SearchRadius = 5000,
                    
                    PrioritizedCategories = {    
        
                                     
                                        'EXPERIMENTAL LAND',
                                        'MASSEXTRACTION TECH3',
                                        'MASSEXTRACTION TECH2',
                                        'MASSEXTRACTION TECH1',
                                        'COMMAND',
                                       
        
                        
                        
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
                InstanceCount = 20,
                AggressiveMove = true,
                BuilderType = 'Any',
                BuilderConditions = {
                             { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR * (categories.TECH1 + categories.TECH2) * categories.GROUNDATTACK  * categories.MOBILE  - categories.BOMBER - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                    { SBC, 'NoRushTimeCheck', { 0 }},
                },
                BuilderData = {
                    SearchRadius = 5000,
                    
                    PrioritizedCategories = {    
        
                                        'EXPERIMENTAL LAND',
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
                    InstanceCount = 10,
                    AggressiveMove = true,
                    BuilderType = 'Any',
                    BuilderConditions = {
                        { MIBC, 'GreaterThanGameTime', { 1200} },
                                 { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.AIR * categories.TECH3  * categories.MOBILE * categories.GROUNDATTACK  - categories.TRANSPORTFOCUS - categories.BOMBER - categories.ANTINAVY - categories.SCOUT - categories.uea0303 - categories.uaa0303 - categories.ura0303 - categories.xsa0303 - categories.uea0102 - categories.uaa0102 - categories.ura0102 - categories.xsa0102 } },
                        { SBC, 'NoRushTimeCheck', { 0 }},
                    },
                    BuilderData = {
                        SearchRadius = 5000,
                        
                        PrioritizedCategories = {    
            
                            'EXPERIMENTAL LAND',
                            'MASSEXTRACTION TECH3',
                            'MASSEXTRACTION TECH2',
                            'MASSEXTRACTION TECH1',
                            'COMMAND',
                                           
            
                            
                            
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
        Priority = 100,
        BuilderType = 'Air',
       
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
           
           ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
          
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 15, categories.ANTIAIR * categories.AIR, 'Enemy'}},
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.MOBILE * categories.AIR  * categories.BOMBER * categories.TECH1} },
           
                      
			
			
            
			
			
           
           
           
			
        },
        
    },
 
    

    Builder {
        BuilderName = 'NC t3bomber air dominance',
        PlatoonTemplate = 'T3AirBomber',
        Priority = 600,
        BuilderType = 'Air',
       
        BuilderConditions = {
                        { SBC, 'MapGreaterThan', { 1000, 1000 }},
                        { MIBC, 'GreaterThanGameTime', { 1800} },
                        { SBC, 'NoRushTimeCheck', { 600 }},
                        { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			
			
            
			
			
         ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t1bomber early game for defense',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 500,
        BuilderType = 'Air',
      
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 360 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 0, categories.ANTIAIR * categories.AIR * categories.TECH3, 'Enemy'}},
            
                       
                        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.AIR * categories.GROUNDATTACK * categories.BOMBER * categories.MOBILE - categories.ANTIAIR } },
			
			
            
			
			
         ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t1bomber protect expansion',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 700,
        BuilderType = 'Air',
    
        BuilderConditions = {
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { false, 0, categories.ANTIAIR * categories.AIR * categories.TECH3, 'Enemy'}},
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.ENGINEER, 40 } },
                        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.AIR * categories.GROUNDATTACK * categories.BOMBER * categories.MOBILE - categories.ANTIAIR } },
			
			
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
         ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
           
           
			
        },
        
    },
}





BuilderGroup {
    BuilderGroupName = 'NCfindenemyfightersbehavior',
    BuildersType = 'PlatoonFormBuilder',

    Builder {
        BuilderName = 'NC finding enemy fighters',
        PlatoonTemplate = 'NCfighterhunter',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 50,
       
       
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
        BuilderName = 'NC finding enemy fighters late',
        PlatoonTemplate = 'NCfighterhunterlate',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 300,
        FormRadius = 1000,
        InstanceCount = 10,
       
        BuilderType = 'Any',
        BuilderConditions = {
                     
                        { MIBC, 'GreaterThanGameTime', { 1320} },
                        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.AIR * categories.FACTORY * categories.TECH3 } },
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            SearchRadius = 6000,
            AvoidBases = true,
        AvoidBasesRadius = 100,
			
            

                PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
                categories.TRANSPORTFOCUS,
                categories.ANTIAIR * categories.AIR,
                categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                                
				
				
            },
        },
    },
    Builder {
        BuilderName = 'NC finding enemy fighters verylate',
        PlatoonTemplate = 'NCfighterhunterverylate',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 400,
        FormRadius = 1000,
        InstanceCount = 10,
       
        BuilderType = 'Any',
        BuilderConditions = {
          
            { MIBC, 'GreaterThanGameTime', { 2900} },
                        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 10, categories.AIR * categories.FACTORY * categories.TECH3} },
                        
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            AvoidBases = true,
        AvoidBasesRadius = 100,
			SearchRadius = 6000,
			
           
                PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
                categories.TRANSPORTFOCUS,
                categories.ANTIAIR * categories.AIR,
                categories.AIR - categories.SCOUT - categories.INSIGNIFICANTUNIT - categories.POD,
                                
				
				
            },
        },
    },
    Builder {
        BuilderName = 'NC finding enemy fighters GIANT',
        PlatoonTemplate = 'NCfighterhunterGIANT',
		PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
		PlatoonAddPlans = { 'AirIntelToggle','DistressResponseAISorian'},
        Priority = 5000,
        FormRadius = 1000,
        InstanceCount = 1,
       
        BuilderType = 'Any',
        BuilderConditions = {
            
            { MIBC, 'GreaterThanGameTime', { 1800} },
                     
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.SCOUT, 'Enemy'}},
                        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK - categories.EXPERIMENTAL - categories.TRANSPORTFOCUS - categories.SCOUT } },
			{ SBC, 'NoRushTimeCheck', { 0 }},
        },
        BuilderData = {
            AvoidBases = true,
        AvoidBasesRadius = 100,
			SearchRadius = 6000,
			
        

                              
                PrioritizedCategories = { categories.EXPERIMENTAL * categories.AIR,
                categories.TRANSPORTFOCUS,
                categories.ANTIAIR * categories.AIR,
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
        Priority = 500,
        
        InstanceCount = 3,
       
        BuilderType = 'Any',
        BuilderConditions = {
                       
                       
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
        Priority = 500,
        
        InstanceCount = 3,
       
        BuilderType = 'Any',
        BuilderConditions = {
                       
                       
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
            InstanceCount = 20,
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
                { SBC, 'MapGreaterThan', { 1000, 1000 }},
                { MIBC, 'GreaterThanGameTime', { 1800 } },
           --
                { SBC, 'NoRushTimeCheck', { 600 }},
                { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
              ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
                
                
               
            },
        },
 
    
    }


    BuilderGroup {
        BuilderGroupName = 'NCAntiLandQuickBuild',
        BuildersType = 'FactoryBuilder',
        
    Builder {
            BuilderName = 'NC t1bomber anti factory rush',
            PlatoonTemplate = 'T1AirBomber',
            Priority = 1000,
         
            BuilderType = 'Air',
            BuilderConditions = {
               
              
                { SBC, 'NoRushTimeCheck', { 600 }},
                
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 200 } },
              
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
                
             
            },
        },  
        Builder {
            BuilderName = 'NC t3bomber anti factory rush',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 750,
           
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 1000, 1000 }},
           --
                { SBC, 'NoRushTimeCheck', { 600 }},
                { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 200 } },
              
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
                
             
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
         
          
{ EBC, 'GreaterThanEconStorageCurrent', { 2, 50 } },  
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
    Builder {
        BuilderName = 'NC T2 Air Staging later on',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 925,
        BuilderConditions = {
         
            { MIBC, 'GreaterThanGameTime', { 1200 } },
{ EBC, 'GreaterThanEconStorageCurrent', { 2, 50 } },  
--
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.AIRSTAGINGPLATFORM * categories.STRUCTURE}},
            
            
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
        BuilderName = 'NC T1 Air Transport early game',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 800,
      
        
        BuilderConditions = {
       
           
            { MIBC, 'LessThanGameTime', { 330 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'TRANSPORTFOCUS' } },
         
         
            
		
		
			
          ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
            
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T1 Air Transport',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 700,
        BuilderConditions = {
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR  - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR   - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { MIBC, 'ArmyNeedsTransports', {} },
          
		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'TRANSPORTFOCUS' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTFOCUS' } },
       --
           
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.85, 1.05 }},
            
        },
        BuilderType = 'Air',
    },
   

    Builder {
        BuilderName = 'NC T1 Air Transport lots of cover',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 700,
        BuilderConditions = {
            
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'TRANSPORTFOCUS' } },
		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, 'TRANSPORTFOCUS' } },
           
       --
       { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
        },
        BuilderType = 'Air',
    },
   
    Builder {
        BuilderName = 'NC T2 Air Transport',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 708,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTFOCUS' } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
         
			
		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
            
            
		
		
	
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
           
        },
        BuilderType = 'Air',
    },
    

   
  
    Builder {
        BuilderName = 'NC T3 Air Transport Default',
        PlatoonTemplate = 'T3AirTransport',
        Priority = 700,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'TRANSPORTFOCUS' } },
       --
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
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
         
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20 , categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
          ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
            
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.GROUNDATTACK * categories.TECH3 } },
        },
    },
    
    
   
 
    
   
}








  

    
    

BuilderGroup {
    BuilderGroupName = 'NCT3AirFactoryBuilders',
    BuildersType = 'FactoryBuilder',
 
    Builder {
        BuilderName = 'NC T3 Air Gunship - Anti Navy',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 705,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { WRC, 'HaveUnitRatioVersusEnemyNC', { 3.0, categories.MOBILE * categories.AIR * categories.ANTIAIR * categories.TECH3 - categories.GROUNDATTACK - categories.BOMBER, '>=', categories.MOBILE * categories.AIR * (categories.TECH2 + categories.TECH3)  - categories.SCOUT - categories.TRANSPORTFOCUS } },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
          ---
{ EBC, 'GreaterThanEconStorageCurrent', { 8, 60 } },  
--
            
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.STRUCTURE * categories.DEFENSE * categories.ANTINAVY, 'Enemy'}},
        },
    },


  
  
   


}

