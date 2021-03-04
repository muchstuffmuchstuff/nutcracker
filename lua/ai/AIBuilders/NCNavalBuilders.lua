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
local PlatoonFile = '/lua/platoon.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local CF = '/mods/nutcracker/hook/lua/coinflip.lua'
local WRC = '/mods/nutcracker/hook/lua/weaponsrangeconditions.lua'
local EN = '/mods/nutcracker/hook/lua/economicnumbers.lua'
local AIUtils = import('/lua/ai/aiutilities.lua')


-----island map intial builds
BuilderGroup {
    BuilderGroupName = 'NCNaval Factories',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'NC T1 Naval factory island map',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 950,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', {6, categories.FACTORY * categories.NAVAL } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.NAVAL}},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            
            
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                'T1SeaFactory',
'T1SeaFactory',

				'T1NavalDefense',
				'T1AADefense',
				'T1Sonar',
			
                }
            }
        }
    },
    
    Builder {
        BuilderName = 'NC T2 Naval factory island map',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', {6, categories.FACTORY * categories.NAVAL } },
          
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, categories.FACTORY * categories.NAVAL}},
		
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
         
		
           
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                    'T1SeaFactory',
                    'T1SeaFactory',

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory island map',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.FACTORY * categories.NAVAL}},
			
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                   

				'T2NavalDefense',
				'T3AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Naval factory non island map',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 905,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
        
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 2, categories.FACTORY * categories.NAVAL}},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            
         
			
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                'T1SeaFactory',
                'T1SeaFactory',

				'T1NavalDefense',
				'T1AADefense',
				'T1Sonar',
			
                }
            }
        }
    },
    
    Builder {
        BuilderName = 'NC T2 Naval factory non island map',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', {4, categories.FACTORY * categories.NAVAL } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 3, categories.FACTORY * categories.NAVAL}},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
        
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
		
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
     
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                    'T1SeaFactory',
                    'T1SeaFactory',

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory non island map',
        PlatoonTemplate = 'T3EngineerBuilderNC',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 500, 500 }},
          
            { UCBC, 'HaveLessThanUnitsWithCategory', {5, categories.FACTORY * categories.NAVAL } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 2, categories.FACTORY * categories.NAVAL}},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
        
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 250, -1000, 10, 1, 'AntiSurface' } },
			
            { EBC, 'GreaterThanEconStorageCurrent', { 100,150 } },
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 250,
                LocationType = 'LocationType',
                ThreatMin = -1000,
                ThreatMax = 10,
                ThreatRings = 0,
                ThreatType = 'AntiSurface',
                BuildClose = false,
                BaseTemplate = ExBaseTmpl,
                ExpansionBase = true,
                ExpansionRadius = 50,
                BuildStructures = {
                    'T1SeaFactory',
                    'T1SeaFactory',

				
                }
            }
        }
    },
    
    
    
    
}




