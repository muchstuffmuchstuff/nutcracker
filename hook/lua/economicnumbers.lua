local AIUtils = import('/lua/ai/aiutilities.lua')
local ScenarioFramework = import('/lua/scenarioframework.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local BuildingTemplates = import('/lua/BuildingTemplates.lua')




function IncomeBeyondSpendingNC(aiBrain, numReq, numReq2)
    local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
    local MassSpreadRealTime = econ.MassIncome - econ.MassUsage
    local EnergySpreadRealTime = econ.EnergyIncome - econ.EnergyUsage
    if HaveGreaterThanUnitsWithCategory(aiBrain, 0, 'ENERGYPRODUCTION EXPERIMENTAL STRUCTURE') then
        #LOG('*AI DEBUG: Found Paragon')
        return false
    end
   
    if (numReq > MassSpreadRealTime and numReq2 > EnergySpreadRealTime) then
        #LOG('!!!!!!!!air stage facility building!!!!!!!!!!!')
        return true
    end
    
    return false
    
end

function HaveGreaterThanUnitsWithCategory(aiBrain, numReq, category, idleReq)
    local numUnits
    local total = 0
    if type(category) == 'string' then
        category = ParseEntityCategory(category)
    end
    if not idleReq then
        numUnits = aiBrain:GetListOfUnits(category, false)
    else
        numUnits = aiBrain:GetListOfUnits(category, true)
    end
    for k,v in numUnits do
        if v:GetFractionComplete() == 1 then
            total = total + 1
            if total > numReq then
                return true
            end
        end
    end
    if total > numReq then
        return true
    end
    return false
end