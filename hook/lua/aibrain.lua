
NutCrackerAIBrainClass = AIBrain
AIBrain = Class(NutCrackerAIBrainClass) {

    -- Hook NutCracker AI, set self.NutCracker = true
    OnCreateAI = function(self, planName)
        NutCrackerAIBrainClass.OnCreateAI(self, planName)
        local per = ScenarioInfo.ArmySetup[self.Name].AIPersonality
        if string.find(per, 'nut_cracker') then
            LOG('* AI-NutCracker: OnCreateAI() found AI-NutCracker  Name: ('..self.Name..') - personality: ('..per..') ')
            self.NutCracker = true
        end
    end,

}
