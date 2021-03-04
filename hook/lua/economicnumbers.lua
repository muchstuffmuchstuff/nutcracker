---muchstuff

---nutcracker

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

function CheckBuildPlattonDelayNC(aiBrain, PlatoonName)
    if aiBrain.DelayEqualBuildPlattons[PlatoonName] then
        LOG('Delay Platoon Name exist' ..aiBrain.DelayEqualBuildPlattons[PlatoonName])
    end
    if aiBrain.DelayEqualBuildPlattons[PlatoonName] and aiBrain.DelayEqualBuildPlattons[PlatoonName] > GetGameTimeSeconds() then
        LOG('Builder Delay false')
        return false
    end
   LOG('Builder delay true')
    return true
end

function LessThanEconStorageCurrentNC(aiBrain, mStorage, eStorage)
    local econ = AIUtils.AIGetEconomyNumbers(aiBrain)
    if (econ.MassStorage < mStorage and econ.EnergyStorage < eStorage) then
        return true
    end
    return false
end

