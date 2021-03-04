#### Nut Cracker Expansion Base
--muchstuff

BaseBuilderTemplate {
    BaseTemplateName = 'NutCrackerExpansionBase',
    Builders = {
      
        'NCMobileNavalExperimentalcoinflip',
        'NCMobileNavalExperimentalbehavior',
        'ncdukehukemcoinflip',
    
   
       
  ----COIN FLIP STRATEGIES
----landrush
'NCTtankandartyspamcoinflip',
'NClandfactoryrushcoinflip',

---teleport sub commanders
  'NCquantumgatecoinflip',
  'NCeconomicupgradesfortelecoinflip',
  'NCsubcommander_teleport_coinflip',
  'NC Tele SCU Strategy',

---arty rush
  'NCartycoinflip',
  ---t1 bomber rush
  'NCt1bombercoinflip',


        # ==== ECONOMY ==== #
        'NCmapcontrolupgrades',
        'NCSCUUpgrades',
     
        'NC tower upgrades',
        'NCT3Engineerassistmex',
        'NCemergencyenergy',
     
       
      
        'NCT1EngineerBuilders',
        'NCT2EngineerBuilders',
        'NCT3EngineerBuilders',
    
       
        'NCmassupgrade',
      
        
       
       
        
        # Factory upgrades
        'NCEngineerFactoryConstruction',
        'NCExpansionExtraFactory',
        'NCUpgradeBuilders_airfactories',
   



        # Engineer Builders
        'NCEngineerFactoryBuilders',
    
    
       
		
	        
        # Engineer Support buildings
        
        
           
        # Build Mass high pri at this base
        'NCEngineerMassBuildersHighPri',
        
        # Extractors
     
                     
       	        
        # ==== DEFENSES ==== #
        'NCdefense_onisland',
        'NCexpansionstandardefense',
		'NCT1BaseDefenses',
	
		'NCT3BaseDefenses',
        'NCt4airemergencyreaction',
		
		
        'NCTMLandTMDantinavy',
        'NCemergencybuildersearlygame',
		'NCT2Artillerybehavior',
		'NCT3Artillerybehavior',
		'NCT4Artillerybehavior',
        'NCT3NukeDefenses',
        'NCT3NukeDefenseBehaviors',
		
	    ---offense
        'NCadaptiveoffense',
        
        ---navy
        'NCT2NavalDefenses',
        'NCNaval Factories',
        'NCT1SeaFactoryBuilders',
        'NCSeaFactoryUpgrades',
        'ncSeaHunterFormBuilders',  
        'NCT2SeaFactoryBuilders',
      
        # ==== LAND UNIT BUILDERS ==== #
        'NCdefense_antiair',
       
        'NCspammage',
       
      
       
     
        'NCUpgradeBuildersLand',
        
     
      
      
       
        
      
   
        'NCAntiLandQuickBuild',
      
      
       
      
      
        'NClandbehavior',

        # ==== AIR UNIT BUILDERS ==== #
        'NCt4airsnipebehavior',
      
        'NCairstaging',
        'NCT1AntiAirBuilders',
        'NCT3AntiAirBuilders',
       
       
        'NCAntiNavyQuickBuild',
       
        'NCfindenemyfightersbehavior',
      
        'NCTransportFactoryBuilders',
       
        'NCexcessairunitsbehavior',
      
        
        
        'NCt3emergencybuilders',
      
        'NCexcessresourcest1bomberbuild',
      
        
        'NCacusnipe',
       
    
    

        # ==== EXPERIMENTALS ==== #
       
        'ncMobileLandExperimentalbehavior',
        'NC Satelite Behavior',
        'ncMobileAirExperimentalbehavior',
		
      
		
	
		
		
        # ==== ARTILLERY BUILDERS ==== #
    
      'NCNukebehavior',
      'ncNukeBuildersEngineerBuilders',
      'NCartyinrange',
        
  
        
		
		# ======== Strategies ======== #
	
		
		# ===== Strategy Platoons ===== #
		
    },
    NonCheatBuilders = {
     
        'NCAirScoutbehavior',
        
        'NCRadarEngineerBuilders',
        'NCRadarUpgradeBuildersexpansion',
    
        
        
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 10,
            Tech2 = 15,
            Tech3 = 20,
            SCU = 40,
        },
        FactoryCount = {
            Land = 8,
            Air = 10,
            Sea = 3,
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