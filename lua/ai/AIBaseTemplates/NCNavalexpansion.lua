

BaseBuilderTemplate {
    BaseTemplateName = 'NCNavalExpansionLarge',
    Builders = {
      
        'NCT2NavalDefenses',
        'NCNaval Factories',
        'NCT1SeaFactoryBuilders',
        'NCSeaFactoryUpgrades',
        'ncSeaHunterFormBuilders',
        'NCT2SeaFactoryBuilders',
        'NCT3SeaFactoryBuilders',

        # ==== ECONOMY ==== #
        # Factory upgrades
    
		
        # Pass engineers to main as needed
    
        
        # Engineer Builders
        'NCEngineerFactoryBuilders',
        'NCT1EngineerBuilders',
        'NCT2EngineerBuilders',
        'NCT3EngineerBuilders',
  
        
        # Mass
     
        
        # ==== EXPANSION ==== #
       'NCEngineerExpansionBuildersFull',
        
        # ==== DEFENSES ==== #
     
        
        # ==== ATTACKS ==== #
      
		
		
		
		     
		
		# ===== STRATEGIES ====== #
		
	
		
		# == STRATEGY PLATOONS == #
		
		
        
        # ==== NAVAL EXPANSION ==== #
       
		
        # ==== EXPERIMENTALS ==== #
    
    },
    NonCheatBuilders = {
    
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 3,
            Tech2 = 3,
            Tech3 = 3,
            SCU = 0,
        },
        FactoryCount = {
            Land = 0,
            Air = 0,
            Sea = 3,
            Gate = 0,
        },
        MassToFactoryValues = {
            T1Value = 8, #6
            T2Value = 20, #15
            T3Value = 30, #22.5 
        },
    },
    

    ExpansionFunction = function(aiBrain, location, markerType)
        if markerType != 'Naval Area' then
            return 0
        end
		        
        local personality = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
	    local base = 'nut_cracker'
		
		if personality == 'nut_cracker' and base == 'nut_cracker' then
			return 250
		end
	
               
        return 0
    end,
}