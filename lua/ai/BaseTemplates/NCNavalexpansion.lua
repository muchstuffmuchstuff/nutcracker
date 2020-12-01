

BaseBuilderTemplate {
    BaseTemplateName = 'NCNavalExpansionLarge',
    Builders = {

'ncSeaHunterFormBuilders',
'NCNavalExpansionBuildersFast',
'NCT1SeaFactoryBuilders',
'NCT2SeaFactoryBuilders',

        # ==== ECONOMY ==== #
        # Factory upgrades
    
		
        # Pass engineers to main as needed
        #'Engineer Transfers',
        
        # Engineer Builders
        'NCEngineerFactoryBuilders',
        'NCT1EngineerBuilders',
        'NCT2EngineerBuilders',
        'NCT3EngineerBuilders',
        'SorianEngineerNavalFactoryBuilder',
        
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
        'SorianSonarEngineerBuilders',
        'SorianSonarUpgradeBuilders',
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
            Sea = 2,
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
		
		local isIsland = false
        local startX, startZ = aiBrain:GetArmyStartPos()
        local islandMarker = import('/lua/AI/AIUtilities.lua').AIGetClosestMarkerLocation(aiBrain, 'Island', startX, startZ)
        if islandMarker then
            isIsland = true
        end
        
        local personality = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
		local base = ScenarioInfo.ArmySetup[aiBrain.Name].AIBase
		
		if personality == 'sorian' and base == 'SorianMainBalanced' then
			return 250
		end
	
               
        return 0
    end,
}