#### Nut Cracker Expansion Base
--muchstuff

BaseBuilderTemplate {
    BaseTemplateName = 'NutCrackerExpansionBase',
    Builders = {


        # ==== ECONOMY ==== #
        'NCEngineerMassBuildersLowerPri',
        'NCEngineerEnergyBuildersExpansions',
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
   


        # Engineer Builders
        'NCEngineerFactoryBuilders',
    
    
        'NCEngineerFactoryConstruction',
		
	        
        # Engineer Support buildings
        
        
           
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
        'NC Tele SCU Strategy',
        'NCT1_expansionprotect',
        'NClandbehavior_expansion',
     
        'NCUpgradeBuildersLand',
        'NCT1LandFactoryBuildersemergency',
     
        'NCT1LandFactoryBuilders',
        'NCT2LandFactoryBuilders',
        'NCT3LandFactoryBuilders',
        'NCExtraLandFactory',
      
        'NCT3LandResponseBuilders',
        'NCAntiLandQuickBuild',
        'NCT3ReactionDF',
        'NCT2Shields',
        'NCShieldUpgrades',
        'NCT3Shields',
      
        'NClandbehavior',

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
      
        'NCTransportFactoryBuilders',
       
        'NCexcessairunitsbehavior',
        'NCT2AirFactoryBuilders',
        
        
        'NCt3emergencybuilders',
        'NCmasshuntairbehavior',
        'NCexcessresourcest1bomberbuild',
        'NCacusnipebehavior',
        
        'NCacusnipe',
        'NCengihuntairbehavior',
    
    

        # ==== EXPERIMENTALS ==== #
        'NCMobileAirExperimentalEngineers',
        'ncMobileAirExperimentalbehavior',
      
    
		
      
		
	
		
		
        # ==== ARTILLERY BUILDERS ==== #
    
      'NCNukebehavior',
      'ncNukeBuildersEngineerBuilders',
      'NCartyinrange',
        
  
        
		
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
            Land = 8,
            Air = 10,
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
        if not (personality == 'nut_cracker' or personality == 'nut_crackercheat') then
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