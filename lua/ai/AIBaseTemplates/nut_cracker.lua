--[[
    File    :   /lua/AI/AIBaseTemplates/nut_cracker.lua
    Author  :   SoftNoob
    Summary :
        Lists AIs to be included into the lobby, see /lua/AI/CustomAIs_v2/SorianAI.lua for another example.
        Loaded in by /lua/ui/lobby/aitypes.lua, this loads all lua files in /lua/AI/CustomAIs_v2/
]]

BaseBuilderTemplate {
    BaseTemplateName = 'nut_cracker',
    Builders = {
    

        'NCEngineerFactoryConstruction',
        'NCEngineerEnergyBuilders',
        'NCTime Exempt Extractor Upgrades',
        'NCEngineerFirebaseBuilders',
        'NCT3NukeDefenses',
        'NCShieldUpgrades',
        'NCT2Shieldsturtle',
        'NCT3Shields',
        'NCExpResponseFormBuilders',
        'NCT3AntiAirBuilders',
        'NCBaseGuardAirFormBuilders',
        'NCMobileAirExperimentalEngineers',
        'NCMobileAirExperimentalForm',
        'NCEconomicExperimentalEngineersturtle',
        'NCT3ArtilleryGroup',
        'NCExperimentalArtillery',
        'NCNukeBuildersEngineerBuilders',


    },
    NonCheatBuilders = {
      

       'NCAirScoutFormBuilders',

    },
    BaseSettings = { 
	EngineerCount = {
            Tech1 = 15,
            Tech2 = 10,
            Tech3 = 45, #30,
            SCU = 40,
        },
        FactoryCount = {
            Land = 3,
            Air = 7,
            Sea = 0,
            Gate = 5,
        },
        MassToFactoryValues = {
            T1Value = 6, #8
            T2Value = 15, #20
            T3Value = 22.5, #27.5 
        },
    }, 
    ExpansionFunction = function(aiBrain, location, markerType)
        -- This is used if you want to make stuff outside of the starting location.
        return 0
    end,
    
    FirstBaseFunction = function(aiBrain)
        local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        if per == 'microai' or per == 'microaicheat' then
            return 1000, 'nut_cracker'
        end
        return -1
    end,
}
