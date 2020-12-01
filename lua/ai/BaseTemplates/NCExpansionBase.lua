#### Nut Cracker Expansion Base
--muchstuff

BaseBuilderTemplate {
    BaseTemplateName = 'NutCrackerExpansionBase',
    Builders = {


        # ==== ECONOMY ==== #
        'NCemergencyenergy',
        'NCT1EngineerBuilders',
        'NCT2EngineerBuilders',
        'NCT3EngineerBuilders',
        'NCT1BalancedUpgradeBuilders',
        'NCT2BalancedUpgradeBuilders',
        'NCMassFabPause',
        'NCmassupgrade',
        'NCt1masscontinuation',
       
      
        
        # Factory upgrades
        'NCEmergencyUpgrade_airfactories',
        'NCUpgradeBuilders_airfactories',
        'NCEmergencyUpgradeBuilders_landfactories',


        # Engineer Builders
        'NCEngineerFactoryBuilders',
    
        'NCEngineerFactoryConstruction Balance',
        'NCEngineerFactoryConstruction',
		
	        
        # Engineer Support buildings
        'NCEngineeringSupportBuilder',
        
           
        # Build Mass high pri at this base
        'NCEngineerMassBuildersHighPri',
        
        # Extractors
        'NCTime Exempt Extractor Upgrades',
                     
       	        
        # ==== DEFENSES ==== #
		'NCT1BaseDefenses',
		'NCT2BaseDefenses',
		'NCT3BaseDefenses',
        'NCt4airemergencyreaction',
		'NCT2PerimeterDefenses',
		'NCT3PerimeterDefenses',
        'NCTMLandTMDantinavy',
        'NCemergencybuildersearlygame',
		'NCT2Artillerybehavior',
		'NCT3Artillerybehavior',
		'NCT4Artillerybehavior',
        'NCT3NukeDefenses',
        'NCT3NukeDefenseBehaviors',
		
	      
            
        # ==== LAND UNIT BUILDERS ==== #
        'NCUpgradeBuildersLand',
        'NCT1LandFactoryBuildersemergency',
        'NCengihuntlandbehavior',
        'NCmasshuntlandbehavior',
        'NCT1LandFactoryBuilders',
        'NCT2LandFactoryBuilders',
        'NCT3LandFactoryBuilders',
        'NCExtraLandFactory',
        'NCattackexpansionbehavior',
        'NCT3LandResponseBuilders',
        'NCAntiLandQuickBuild',
        'NCT3ReactionDF',
        'NCT2Shields',
        'NCShieldUpgrades',
        'NCT3Shields',
		'NCEngineeringUpgrades',

        # ==== AIR UNIT BUILDERS ==== #
        'NCstopfactoryrushwithbombersbehavior',
        'NCairstaging',
        'NCT1AntiAirBuilders',
        'NCT3AntiAirBuilders',
        'NCT3AirFactoryBuilders',
        'NCExtraAirFactory',
        'NCAntiNavyQuickBuild',
        'NCAntiNavyAirbehavior',
        'NCfindenemyfightersbehavior',
        'NCt4airsnipebehavior',
        'NCTransportFactoryBuilders',
        'NCt1buildonce',
        'NCexcessairunitsbehavior',
        'NCT2AirFactoryBuilders',
        'NCBaseGuardonebuildbehavior',
        'NCguardt4airbehavior',
        'NCt3emergencybuilders',
        'NCmasshuntairbehavior',
        'NCexcessresourcest1bomberbuild',
        'NCacusnipebehavior',
        'NCT2AntiAirBuilders',
        'NCacusnipe',
        'NCengihuntairbehavior',
    
    

        # ==== EXPERIMENTALS ==== #
        'NCMobileAirExperimentalEngineers',
        'ncMobileAirExperimentalbehavior',
      
    
		
      
		
	
		
		
        # ==== ARTILLERY BUILDERS ==== #
    
      'NCNukebehavior',
      'ncNukeBuildersEngineerBuilders',
        
  
        
		
		# ======== Strategies ======== #
	
		
		# ===== Strategy Platoons ===== #
		
    },
    NonCheatBuilders = {
     
        
    
        
        
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 10,
            Tech2 = 15,
            Tech3 = 20,
            SCU = 10,
        },
        FactoryCount = {
            Land = 5,
            Air = 8,
            Sea = 6,
            Gate = 0, #1,
        },
        MassToFactoryValues = {
            T1Value = 6, #8
            T2Value = 15, #20
            T3Value = 22.5, #27.5 
        },
    },
    ExpansionFunction = function(aiBrain, location, markerType)
        if markerType != 'Start Location' and markerType != 'Expansion Area' then
            return 0
        end
        
        local personality = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        if not (personality == 'sorian' or personality == 'sorianadaptive') then
            return 0
        end
		
        local threatCutoff = 10 # value of overall threat that determines where enemy bases are
        local distance = import('/lua/ai/AIUtilities.lua').GetThreatDistance( aiBrain, location, threatCutoff )
        if not distance or distance > 1000 then
            return 500
        elseif distance > 500 then
            return 750
        elseif distance > 250 then
            return 1000
        else # within 250
            return 250
        end

        return 0
    end,
}