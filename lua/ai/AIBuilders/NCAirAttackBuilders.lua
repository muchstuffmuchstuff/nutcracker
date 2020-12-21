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
        BuilderName = 'NC kill navy with air',
        PlatoonTemplate = 'navalhunters',
            PlatoonAddBehaviors = { 'AirUnitRefitSorian' },
            PlatoonAddPlans = { 'AirIntelToggle', 'DistressResponseAISorian'  },
            Priority = 10,
            FormRadius = 500,
            InstanceCount = 10,
            AggressiveMove = true,
            BuilderType = 'Any',
            BuilderConditions = {
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NAVAL * categories.FACTORY,  'Enemy' }},
                         { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * categories.ANTINAVY * categories.MOBILE - categories.BOMBER - categories.GROUNDATTACK } },
                { SBC, 'NoRushTimeCheck', { 0 }},
            },
            BuilderData = {
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                   
                    'MOBILE NAVAL',
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
        BuilderName = 'NC t1bomber lots of cash',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 100,
        BuilderType = 'Air',
        InstanceCount = 30,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1800 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'FACTORY AIR TECH3' }},
                      
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 1.1, 1.1 }},
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t1bomber coinflip',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 100,
        BuilderType = 'Air',
        InstanceCount = 30,
        BuilderConditions = {
            { CF, 'CoinFlipAirExperimental', {5} },
                        { MIBC, 'LessThanGameTime', { 1500 } },
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.65, 1.0 }},
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t3bomber air dominance small map',
        PlatoonTemplate = 'T3AirBomber',
        Priority = 600,
        BuilderType = 'Air',
       
        BuilderConditions = {
            { SBC, 'MapLessThan', { 1000, 1000 }},
                        { MIBC, 'GreaterThanGameTime', { 1200} },
                        { SBC, 'NoRushTimeCheck', { 600 }},
                        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
           
           
			
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
                        { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t1bomber early game for defense',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 500,
        BuilderType = 'Air',
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 360 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'FACTORY AIR TECH3' }},
                       
                        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.AIR * categories.GROUNDATTACK * categories.BOMBER * categories.MOBILE - categories.ANTIAIR } },
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
           
           
			
        },
        
    },
    Builder {
        BuilderName = 'NC t1bomber protect expansion',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 1000,
        BuilderType = 'Air',
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'FACTORY AIR TECH3' }},
            { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 0, categories.ENGINEER, 40 } },
                        { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.AIR * categories.GROUNDATTACK * categories.BOMBER * categories.MOBILE - categories.ANTIAIR } },
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
           { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
           
           
			
        },
        
    },
}



BuilderGroup {
    BuilderGroupName = 'NCt3emergencybuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Exp Response build fast',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 850,
        InstanceCount = 100,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200} },
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, 'EXPERIMENTAL AIR', 'Enemy'}},
			
			
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			
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
			SearchRadius = 6000,
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL AIR',
                                'TRANSPORTFOCUS',
                                'AIR',
                                
				
				
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
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL AIR',
                                'TRANSPORTFOCUS',
                                'AIR',
                                
				
				
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
			SearchRadius = 6000,
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL AIR',
                                'TRANSPORTFOCUS',
                                'AIR',
                                
				
				
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
			
			
            PrioritizedCategories = {    

                                'EXPERIMENTAL AIR',
                                'TRANSPORTFOCUS',
                                'AIR',
                                
				
				
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
                SearchRadius = 5000,
                
                PrioritizedCategories = {    
    
                                    'EXPERIMENTAL AIR',
                                    'MOBILE AIR',
                    
                    
                },
            },
        },
    }


    

    BuilderGroup {
        BuilderGroupName = 'NCacusnipe',
        BuildersType = 'FactoryBuilder',
        Builder {
            BuilderName = 'NC T3 Air Gunship air control snipe',
            PlatoonTemplate = 'T3AirGunship',
            Priority = 750,
   
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 1000, 1000 }},
                { MIBC, 'GreaterThanGameTime', { 1800 } },
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 25, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                
               
            },
        },
        Builder {
            BuilderName = 'NC T3 Air Gunship air control snipe small map',
            PlatoonTemplate = 'T3AirGunship',
            Priority = 750,
   
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapLessThan', { 1000, 1000 }},
                { MIBC, 'GreaterThanGameTime', { 1200 } },
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                
               
            },
        },
    Builder {
            BuilderName = 'NC T2 Air Gunship air control',
            PlatoonTemplate = 'T2AirGunship',
            Priority = 749,
         
            BuilderType = 'Air',
            BuilderConditions = {
                { MIBC, 'GreaterThanGameTime', { 1800 } },
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 25, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                
                
            },
        },
        Builder {
            BuilderName = 'NC T3 Air bomber air control',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 750,
        
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 1000, 1000 }},
                { MIBC, 'GreaterThanGameTime', { 1800 } },
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 25, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                
               
            },
        },
        Builder {
            BuilderName = 'NC T3 Air bomber air control small map',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 750,
        
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapLessThan', { 1000, 1000 }},
                { MIBC, 'GreaterThanGameTime', { 1200 } },
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                
               
            },
        },
    
    }


    BuilderGroup {
        BuilderGroupName = 'NCAntiLandQuickBuild',
        BuildersType = 'FactoryBuilder',
        Builder {
            BuilderName = 'NC T3 Air Gunship anti land',
            PlatoonTemplate = 'T3AirGunship',
            Priority = 750,
            BuilderType = 'Air',
            BuilderConditions = {
            
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 40, categories.LAND * categories.MOBILE - categories.ENGINEER,  'Enemy' }},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.MOBILE *  categories.GROUNDATTACK * categories.TECH3 } },
            },
        },
     Builder {
            BuilderName = 'NC T2 Air Gunship anti land',
            PlatoonTemplate = 'T2AirGunship',
            Priority = 759,
            BuilderType = 'Air',
            BuilderConditions = {
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 40, categories.LAND * categories.MOBILE - categories.ENGINEER,  'Enemy' }},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
                
                { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.MOBILE * categories.GROUNDATTACK * categories.TECH3 } },
            },
        },
    Builder {
            BuilderName = 'NC t1bomber anti factory rush',
            PlatoonTemplate = 'T1AirBomber',
            Priority = 1000,
            InstanceCount = 30,
            BuilderType = 'Air',
            BuilderConditions = {
                { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'FACTORY AIR TECH3' }},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 200 } },
              
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
                
             
            },
        },  
        Builder {
            BuilderName = 'NC t3bomber anti factory rush',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 1000,
           
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapGreaterThan', { 1000, 1000 }},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 200 } },
              
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
                
             
            },
        },   
        Builder {
            BuilderName = 'NC t3bomber anti factory rush small map',
            PlatoonTemplate = 'T3AirBomber',
            Priority = 1000,
           
            BuilderType = 'Air',
            BuilderConditions = {
                { SBC, 'MapLessThan', { 1000, 1000 }},
                { IBC, 'BrainNotLowPowerMode', {} },
                { SBC, 'NoRushTimeCheck', { 600 }},
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 30, categories.MOBILE * categories.AIR * categories.TECH3 * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
                { SBC, 'GreaterThanEnemyUnitsAroundBase', { 'LocationType', 1, categories.FACTORY * categories.STRUCTURE, 200 } },
              
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.01 }},
                
             
            },
        },   
    }


    
  

 
BuilderGroup {
    BuilderGroupName = 'NCairstaging',
    BuildersType = 'EngineerBuilder',
Builder {
        BuilderName = 'NC T2 Air Staging Engineer',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 1925,
        BuilderConditions = {
            { EN, 'IncomeBeyondSpendingNC', { 100,2500} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
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
        InstanceCount = 2,
        
        BuilderConditions = {
       
           
            { MIBC, 'LessThanGameTime', { 330 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'TRANSPORTFOCUS' } },
         
         
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 } },
		
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T1 Air Transport',
        PlatoonTemplate = 'T1AirTransport',
        Priority = 700,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 15, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
            { MIBC, 'ArmyNeedsTransports', {} },
          
		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, 'TRANSPORTFOCUS' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTFOCUS' } },
            { IBC, 'BrainNotLowPowerMode', {} },
           
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
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
           
            { IBC, 'BrainNotLowPowerMode', {} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 35, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
        },
        BuilderType = 'Air',
    },
   
    Builder {
        BuilderName = 'NC T2 Air Transport',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 758,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, 'TRANSPORTFOCUS' } },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 20, categories.MOBILE * categories.AIR * categories.ANTIAIR - categories.GROUNDATTACK - categories.BOMBER} },
         
			
		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
            
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH2 } },
		
	
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
           
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'NC T2 Air Transport lots of cover',
        PlatoonTemplate = 'T2AirTransport',
        Priority = 758,
        BuilderConditions = {
       
          
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
          
            { IBC, 'BrainNotLowPowerMode', {} },
	
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * (categories.TECH2 + categories.TECH3) * categories.AIR  } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 40, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
        },
        BuilderType = 'Air',
    },

   
  
    Builder {
        BuilderName = 'NC T3 Air Transport Default',
        PlatoonTemplate = 'T3AirTransport',
        Priority = 700,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, 'TRANSPORTFOCUS TECH2, TRANSPORTFOCUS TECH3' } },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 1, 'TRANSPORTFOCUS' } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
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
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
            { UCBC, 'HaveLessThanUnitsWithCategory', { 100, categories.AIR * categories.GROUNDATTACK * categories.TECH3 } },
        },
    },
     Builder {
        BuilderName = 'NC T3 torp bomber',
        PlatoonTemplate = 'T3TorpedoBomber',
        Priority = 750,
        BuilderType = 'Air',
        BuilderConditions = {
        
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
            { UCBC, 'HaveLessThanUnitsWithCategory', { 80, categories.AIR * categories.ANTINAVY * categories.TECH3 } },
        },
    },
    
    Builder {
        BuilderName = 'NC T2 torp bomber',
        PlatoonTemplate = 'T2AirTorpedoBomber',
        Priority = 749,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 700 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
            { UCBC, 'HaveLessThanUnitsWithCategory', { 40, categories.AIR * categories.ANTINAVY * categories.TECH3 } },
        },
    },
}





BuilderGroup {
    BuilderGroupName = 'NCT1AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Interceptors',
        PlatoonTemplate = 'T1AirFighter',
        Priority = 660,
        InstanceCount = 15,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
           
        { UCBC, 'HaveLessThanUnitsWithCategory', { 30, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
         
            
			
       
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
         
            
			
        },
        
    },
Builder {
        BuilderName = 'NC T1 Interceptors ISLANDMAP',
        PlatoonTemplate = 'T1AirFighter',
        Priority = 760,
        BuilderType = 'Air',
        InstanceCount = 30,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { SBC, 'IsIslandMap', { true } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
           
        { UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.AIR * categories.MOBILE* categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
            
           
			
        
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
          
        },
        
    },
    Builder {
        BuilderName = 'NC T1 Interceptors - Enemy Air',
        PlatoonTemplate = 'T1AirFighter',
        Priority = 761,
        BuilderType = 'Air',
        InstanceCount = 30,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 35, categories.AIR * categories.MOBILE * categories.ANTIAIR  - categories.BOMBER - categories.GROUNDATTACK } },
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 9, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
 
            
 

            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
     
			
			
        },
        
    },
  
 
}

BuilderGroup {
    BuilderGroupName = 'NCT3AntiAirBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3AntiAirPlanes Initial',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 791,
        BuilderType = 'Air',
InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
           
            { UCBC, 'HaveLessThanUnitsWithCategory', { 30, categories.AIR * categories.MOBILE * categories.ANTIAIR * categories.TECH3 - categories.BOMBER - categories.GROUNDATTACK } },
		
	
            
        },
     
    },
Builder {
        BuilderName = 'NC T3AntiAirPlanes islandmap',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 791,
        BuilderType = 'Air',
InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 30, categories.AIR * categories.MOBILE * categories.ANTIAIR * categories.TECH3 - categories.BOMBER - categories.GROUNDATTACK } },
		{ SBC, 'IsIslandMap', { true } },
	
            
        },
       
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 792,
        InstanceCount = 20,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 9, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
     
			
		
            
        },
        
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air Extra',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 793,
        BuilderType = 'Air',
        InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 15, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
          
			
            
        },
        
    },
    Builder {
        BuilderName = 'NC T3AntiAirPlanes - Enemy Air Extra huge',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 794,
        BuilderType = 'Air',
        InstanceCount = 20,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 20, categories.MOBILE * categories.AIR - categories.SCOUT, 'Enemy'}},
            { UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
          
			
           
        },
        
    },
 
}

BuilderGroup {
    BuilderGroupName = 'NCT2AirFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T2 Air Gunship',
        PlatoonTemplate = 'T2AirGunship',
        Priority = 600,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 5, 'FACTORY TECH3' }},
        },
    },

   

    Builder {
        BuilderName = 'NC T2 Air Gunship2',
        PlatoonTemplate = 'T2AirGunship',
        Priority = 600,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 300 } },
            { SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH2 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryLessAtLocation', { 'LocationType', 5, 'FACTORY TECH3' }},
        },
    },
   
}


BuilderGroup {
    BuilderGroupName = 'NCT1AirFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T1 Air Bomber',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 500,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY AIR TECH3' }},
			
        },
    },
  
    Builder {
        BuilderName = 'NC T1Gunship',
        PlatoonTemplate = 'T1Gunship',
        Priority = 500,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY TECH3' }},
			
        },
    },
  
    Builder {
        BuilderName = 'NC T1 Air Bomber 2',
        PlatoonTemplate = 'T1AirBomber',
        Priority = 500,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.FACTORY * categories.AIR, 'Enemy'}},
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY AIR TECH3' }},
			
        },
    },
    Builder {
        BuilderName = 'NC T1Gunship2',
        PlatoonTemplate = 'T1Gunship',
        Priority = 500,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 280 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.FACTORY * categories.AIR * categories.TECH3}},
            { IBC, 'BrainNotLowPowerMode', {} },
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH1 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'HaveLessThanUnitsWithCategory', { 2, 'FACTORY TECH3' }},
			
        },
    },
}






  

    
    

BuilderGroup {
    BuilderGroupName = 'NCT3AirFactoryBuilders',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'NC T3 Air Gunship',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 700,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
        },
    },
    Builder {
        BuilderName = 'NC T3 Air Gunship - Anti Navy',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 705,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
			{ UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 1, categories.STRUCTURE * categories.DEFENSE * categories.ANTINAVY, 'Enemy'}},
        },
    },


    Builder {
        BuilderName = 'NC T3 Air Gunship2',
        PlatoonTemplate = 'T3AirGunship',
        Priority = 700,
        BuilderType = 'Air',
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
        },
    },
  
   
    Builder {
        BuilderName = 'NC T3 Air Fighter t4 guard',
        PlatoonTemplate = 'T3AirFighter',
        Priority = 750,
        InstanceCount = 30,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1500 } },
            { IBC, 'BrainNotLowPowerMode', {} },
			{ SBC, 'NoRushTimeCheck', { 600 }},
            { UCBC, 'HaveGreaterThanUnitsInCategoryBeingBuilt', { 0, 'EXPERIMENTAL AIR' }},
			{ UCBC, 'FactoryGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.AIR * categories.TECH3 } },
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            
         
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, categories.ANTIAIR * categories.AIR - categories.BOMBER - categories.GROUNDATTACK} },
        },
        BuilderType = 'Air',
    },

}

