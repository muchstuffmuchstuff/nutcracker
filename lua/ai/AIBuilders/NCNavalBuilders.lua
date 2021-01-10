#***************************************************************************
#*
#**  File     :  /lua/ai/SorianNavalBuilders.lua
#**
#**  Summary  : Default Naval structure builders for skirmish
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
        Priority = 905,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
         
		
           
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory island map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            
         
			
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
        
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
     
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory non island map',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
        
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T3AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Naval factory island map giant',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 905,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
           

            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            
         
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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
        BuilderName = 'NC T2 Naval factory island map giant',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
        
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
         
		
           
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory island map giant',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { SBC, 'IsIslandMap', { true } },
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
        
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T3AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T1 Naval factory non island map giant',
        PlatoonTemplate = 'EngineerBuilderSorian',
        Priority = 905,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
            
         
			
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T1NavalDefense',
				'T1AADefense',
				'T1Sonar',
			
                }
            }
        }
    },
    
    Builder {
        BuilderName = 'NC T2 Naval factory non island map giant',
        PlatoonTemplate = 'T2EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
        
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
		
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
     
			
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T2AADefense',
				'T2Sonar',
                }
            }
        }
    },
    Builder {
        BuilderName = 'NC T3 Naval factory non island map giant',
        PlatoonTemplate = 'T3EngineerBuilderSorian',
        Priority = 922,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'NavalBaseCheck', { } },
            { SBC, 'MapGreaterThan', { 1000, 1000 }},
            { SBC, 'MapLessThan', { 2000, 2000 }},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY,  'Enemy' }},
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { SBC, 'MapGreaterThan', { 2000, 2000 }},
            { MIBC, 'GreaterThanGameTime', { 1000 } },
        
           
            { UCBC, 'NavalAreaNeedsEngineer', { 'LocationType', 600, -1000, 10, 1, 'AntiSurface' } },
			
            { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.95, 1.05 }},
            
           
		
            
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                NearMarkerType = 'Naval Area',
                LocationRadius = 600,
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

				'T2NavalDefense',
				'T3AADefense',
				'T2Sonar',
                }
            }
        }
    },
    
}




