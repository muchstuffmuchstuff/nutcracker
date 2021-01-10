local AIUtils = import('/lua/ai/aiutilities.lua')
local ScenarioFramework = import('/lua/scenarioframework.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local BuildingTemplates = import('/lua/BuildingTemplates.lua')
local GetEconomyTrend = import('/lua/aibrain.lua')
local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
local Utils = import('/lua/utilities.lua')
local HaveGreaterThanUnitsWithCategory = import('/lua/editor/UnitCountBuildConditions.lua')



local GetEconomyTrend = moho.aibrain_methods.GetEconomyTrend
local GetListOfUnits = moho.aibrain_methods.GetListOfUnits

function IncomeBeyondSpendingNC(aiBrain, numReq, numReq2)
    local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
    local MassSpreadRealTime = econ.MassIncome - econ.MassUsage
    local EnergySpreadRealTime = econ.EnergyIncome - econ.EnergyUsage
    if HaveGreaterThanUnitsWithCategoryNC(aiBrain, 0, 'ENERGYPRODUCTION EXPERIMENTAL STRUCTURE') then
        #LOG('*AI DEBUG: Found Paragon')
        return false
    end
   
    if (numReq > MassSpreadRealTime and numReq2 > EnergySpreadRealTime) then
        #LOG('!!!!!!!!air stage facility building!!!!!!!!!!!')
        return true
    end
    
    return false
    
end

function HaveGreaterThanUnitsWithCategoryNC(aiBrain, numReq, category, idleReq)
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

function CompareBodyNC(numOne, numTwo, compareType)
    if compareType == '>' then
        if numOne > numTwo then
            return true
        end
    elseif compareType == '<' then
        if numOne < numTwo then
            return true
        end
    elseif compareType == '>=' then
        if numOne >= numTwo then
            return true
        end
    elseif compareType == '<=' then
        if numOne <= numTwo then
            return true
        end
    else
       error('*AI ERROR: Invalid compare type: ' .. compareType)
       return false
    end
    return false
end

function HaveUnitRatioVersusCapNC(aiBrain, ratio, compareType, categoryOwn)
    local numOwnUnits = aiBrain:GetCurrentUnits(categoryOwn)
    local cap = GetArmyUnitCap(aiBrain:GetArmyIndex())
    --LOG(aiBrain:GetArmyIndex()..' CompareBody {World} ( '..numOwnUnits..' '..compareType..' '..cap..' ) -- ['..ratio..'] -- '..repr(DEBUG)..' :: '..(numOwnUnits / cap)..' '..compareType..' '..cap..' return '..repr(CompareBody(numOwnUnits / cap, ratio, compareType)))
    return CompareBodyNC(numOwnUnits / cap, ratio, compareType)
end

function GreaterThanEconTrendNC(aiBrain, MassTrend, EnergyTrend)
    local econ = {}
    econ.MassTrend = GetEconomyTrend(aiBrain, 'MASS')
    econ.EnergyTrend = GetEconomyTrend(aiBrain, 'ENERGY')
  
    if aiBrain.HasParagon and econ.MassTrend >= 0 and econ.EnergyTrend >= 0 then
        return true
    elseif econ.MassTrend >= MassTrend and econ.EnergyTrend >= EnergyTrend then
        return true
    end
    return false
end



function HaveUnitRatioNC(aiBrain, ratio, categoryOne, compareType, categoryTwo)
    local numOne = aiBrain:GetCurrentUnits(categoryOne)
    local numTwo = aiBrain:GetCurrentUnits(categoryTwo)
    return CompareBodyNC(numOne / numTwo, ratio, compareType)
end

function HavePoolUnitInArmyNC(aiBrain, unitCount, unitCategory, compareType)
    local poolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local numUnits = poolPlatoon:GetNumCategoryUnits(unitCategory)
    --LOG('* HavePoolUnitInArmy: numUnits= '..numUnits) 
    return CompareBodyNC(numUnits, unitCount, compareType)
end

function HaveLessThanArmyPoolWithCategoryNC(aiBrain, unitCount, unitCategory)
    return HavePoolUnitInArmyNC(aiBrain, unitCount, unitCategory, '<')
end
function HaveGreaterThanArmyPoolWithCategoryNC(aiBrain, unitCount, unitCategory)
    return HavePoolUnitInArmyNC(aiBrain, unitCount, unitCategory, '>')
end

function LessThanEconStorageCurrentNC(aiBrain, mStorage, eStorage)
    local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
    if (econ.MassStorage < mStorage and econ.EnergyStorage < eStorage) then
        return true
    end
    return false
end

function HaveUnitsInCategoryBeingUpgradeNC(aiBrain, numunits, category, compareType)
    -- get all units matching 'category'
    local unitsBuilding = aiBrain:GetListOfUnits(category, false)
    local numBuilding = 0
    -- own armyIndex
    local armyIndex = aiBrain:GetArmyIndex()
    -- loop over all units and search for upgrading units
    for unitNum, unit in unitsBuilding do
        if not unit.Dead and not unit:BeenDestroyed() and unit:IsUnitState('Upgrading') and unit:GetAIBrain():GetArmyIndex() == armyIndex then
            numBuilding = numBuilding + 1
        end
    end
    --LOG(aiBrain:GetArmyIndex()..' HaveUnitsInCategoryBeingUpgrade ( '..numBuilding..' '..compareType..' '..numunits..' ) --  return '..repr(CompareBody(numBuilding, numunits, compareType))..' ')
    return CompareBodyNC(numBuilding, numunits, compareType)
end

function HaveLessThanUnitsInCategoryBeingUpgradeNC(aiBrain, numunits, category)
    return HaveUnitsInCategoryBeingUpgradeNC(aiBrain, numunits, category, '<')
end
function HaveGreaterThanUnitsInCategoryBeingUpgradeNC(aiBrain, numunits, category)
    return HaveUnitsInCategoryBeingUpgradeNC(aiBrain, numunits, category, '>')
end



function GreaterThanEconIncomeNC(aiBrain, MassIncome, EnergyIncome)
   
    local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
    if (econ.MassIncome*10 >= MassIncome and econ.EnergyIncome >= EnergyIncome) then
        LOG('ECONOMIC INCOME IS NOW GREATER THAN '..aiBrain.GreaterThanEconIncomeNC )
        return true
    end
    return false
end
