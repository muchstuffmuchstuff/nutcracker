#### Nut Cracker Main Base
---muchstuff

 --randomizer numbers
 --1 teleport
 --2 land experimental
 --3 nuke
 --4 arty
 --5 t1 bomber spam
 --6 air experimental
 --7 landrush


BaseBuilderTemplate {
    BaseTemplateName = 'NutCrackerMainBase',
    Builders = {
        'NCparagoncoinflip',
        'NC paragon coinflip landupgrades',
        'ncdukehukemcoinflip',
        'NC_coinflip_factoryupgrade',
          
        'NCt1bomberunitsbehavior',
--starting acu for coinflip


        
----landrush
'NCTtankandartyspamcoinflip',
'NClandfactoryrushcoinflip',

---COINFLIP STRATEGIES MAIN BASE --- there are more in expansion
'NCquantumgatecoinflip',
'NCeconomicupgradesfortelecoinflip',
'NCsubcommander_teleport_coinflip',
'NC Tele SCU Strategy',



'NCt1bombercoinflip',
--
'ncNukecoinflip',
'NC nuke rush landupgrades',

--
'NCairexpcoinflipbehavior',
'NCairexpcoinflip',
--
'NClandexpcoinflipbehavior',
'NClandexpcoinflip',




        # ==== ECONOMY ==== #
        'NCT3Engineerassistmex',
        'NCEngineerMassBuildersLowerPri',
        'NCEngineerEnergyBuilders',
        'NCemergencyenergy',
      
        'NC Initial ACU Builders',
        'NCT1EngineerBuilders',
        'NCT2EngineerBuilders',
        'NCT3EngineerBuilders',
      
        
        'NCMassFabPause',
        'NCmassupgrade',
        'NCt1masscontinuation',
       'NCUpgradeBuilders_mainbase',
    
    'NCsubcommander_ras',
        
        # Factory upgrades
       
        
       


        # Engineer Builders
        'NCEngineerFactoryBuilders',
    
       
        'NCEngineerFactoryConstruction',
		
		# SCU Upgrades
		'NCSCUUpgrades',
        
     
       
        
        # Build Mass high pri at this base
        'NCEngineerMassBuildersHighPri',
        
       
      
        
      
      
        'NCACUBuilders',
        'NCACUUpgrades',
  
 
        
        
        # ==== EXPANSION ==== #
        'NCEngineerExpansionBuildersFull',
        'NCEngineerExpansionBuildersSmall',
   
      
		
        
        # ==== DEFENSES ==== #
      
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
		
		
	
        
        # ==== NAVAL EXPANSION ==== #
        'NCT2NavalDefenses',
        'NCNaval Factories',
        'NCT1SeaFactoryBuilders',
        'NCSeaFactoryUpgrades',
        'ncSeaHunterFormBuilders',
        'NCT2SeaFactoryBuilders',
        
     

        
        # ==== LAND UNIT BUILDERS ==== #
        'NCdefense_antiair',
        'NCdefense_onisland',
        'NCspammage',
        'NCExpansionExtraFactory',
       
       
        
       
       
       
      
      
     
       
        'NCAntiLandQuickBuild',
     
        'NCT2Shields',
        'NCT2ShieldsExpansion',
        'NCT3Shields',
    
        'NClandbehavior',

        # ==== AIR UNIT BUILDERS ==== #
      
        'NCairstaging',
        'NCT1AntiAirBuilders',
        'NCT3AntiAirBuilders',
        'NCT3AirFactoryBuilders',
        
        'NCAntiNavyQuickBuild',
      
        'NCfindenemyfightersbehavior',
        'NCt4airsnipebehavior',
        'NCTransportFactoryBuilders',
       
        'NCexcessairunitsbehavior',
      
     
       
        'NCt3emergencybuilders',
        
        'NCexcessresourcest1bomberbuild',
  
     
        'NCacusnipe',
      
    
    

        # ==== EXPERIMENTALS ==== #
        'NCMobileAirExperimentalEngineers',
        'ncMobileAirExperimentalbehavior',
        'NCExperimentalArtillery',
        'ncMobileLandExperimentalbehavior',
        'NCMobileLandExperimental',
        'NC Satelite',
        'NC Satelite Behavior',
    
		
      
		
		'NCEconomicExperimentalEngineers',
		
		
        # ==== ARTILLERY BUILDERS ==== #
       
    
      'NCNukebehavior',
      'ncNukeBuildersEngineerBuilders',
      
        
  
        
		
		# ======== Strategies ======== #
	
		
		# ===== Strategy Platoons ===== #
		
    },
    NonCheatBuilders = {
        'NCAirScoutFactoryBuilders',
        'NClandscout',
        'NClandscoutbehavior',
        'NCextrat3scout',
        'NCAirScoutbehavior',
        'NCRadarUpgradeBuildersMain',
        'NCRadarEngineerBuilders',
      
      
        
        
       
        
        
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 15,
            Tech2 = 10,
            Tech3 = 45, #30,
            SCU = 40,
        },
        FactoryCount = {
            Land = 8,
            Air = 10,
            Sea = 3,
            Gate = 5,
        },
        MassToFactoryValues = {
            T1Value = 6, #8
            T2Value = 15, #20
            T3Value = 22.5, #27.5 
        },
    },
    ExpansionFunction = function(aiBrain, location, markerType)
        return 0
    end,
    FirstBaseFunction = function(aiBrain)
        local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        --LOG('Personality is '..per)
        if not per then 
            --LOG('No Per')
            return -1
        end
        
        if per != 'nut_cracker' and per != 'nut_crackercheat' then
            --LOG('Not NutCracker')
            return -1
        end

        local mapSizeX, mapSizeZ = GetMapSize()
        
        local startX, startZ = aiBrain:GetArmyStartPos()
        local isIsland = import('/lua/editor/SorianBuildConditions.lua').IsIslandMap(aiBrain)
        
        if per == 'nut_cracker' or per == 'nut_crackercheat' then
            --LOG('Returning NutCracker')
            return 1000, 'nut_cracker'
        end
        
        #If we're playing on an island map, do not use this plan often
        if isIsland then
            return Random(25, 50), 'nut_cracker'

        elseif mapSizeX > 256 and mapSizeZ > 256 and mapSizeX <= 512 and mapSizeZ <= 512 then
            return Random(75, 100), 'nut_cracker'

        elseif mapSizeX >= 512 and mapSizeZ >= 512 and mapSizeX <= 1024 and mapSizeZ <= 1024 then
            return Random(50, 100), 'nut_cracker'

        else
            return Random(25, 75), 'nut_cracker'
        end
    end,
}