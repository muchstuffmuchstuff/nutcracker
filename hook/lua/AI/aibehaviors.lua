local AIUtils = import('/lua/ai/aiutilities.lua')
local Utilities = import('/lua/utilities.lua')
local AIBuildStructures = import('/lua/ai/aibuildstructures.lua')
local UnitUpgradeTemplates = import('/lua/upgradetemplates.lua').UnitUpgradeTemplates
local StructureUpgradeTemplates = import('/lua/upgradetemplates.lua').StructureUpgradeTemplates
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local AIAttackUtils = import('/lua/ai/aiattackutilities.lua')
local TriggerFile = import('/lua/scenariotriggers.lua')
local UCBC = import('/lua/editor/UnitCountBuildConditions.lua')
local SBC = import('/lua/editor/SorianBuildConditions.lua')
local SUtils = import('/lua/AI/sorianutilities.lua')
local SetLandTargetPriorities = import('/lua/sim/unit.lua')


FindExperimentalTargetNC = function(self)
    local aiBrain = self:GetBrain()
    if not aiBrain.InterestList or not aiBrain.InterestList.HighPriority then
        -- No target
        return
    end

    -- For each priority in SurfacePriorities list, check against each enemy base we're aware of (through scouting/intel),
    -- The base with the most number of the highest-priority targets gets selected. If there's a tie, pick closer
    local enemyBases = aiBrain.InterestList.HighPriority
    for _, priority in SurfacePriorities do
        local bestBase = false
        local mostUnits = 0
        local bestUnit = false
        for _, base in enemyBases do
            local unitsAtBase = aiBrain:GetUnitsAroundPoint(ParseEntityCategory(priority), base.Position, 100, 'Enemy')
            local numUnitsAtBase = 0
            local notDeadUnit = false

            for _, unit in unitsAtBase do
                if not unit.Dead then
                    notDeadUnit = unit
                    numUnitsAtBase = numUnitsAtBase + 1
                end
            end

            if numUnitsAtBase > 0 then
                if numUnitsAtBase > mostUnits then
                    bestBase = base
                    mostUnits = numUnitsAtBase
                    bestUnit = notDeadUnit
                elseif numUnitsAtBase == mostUnits then
                    local myPos = self:GetPlatoonPosition()
                    local dist1 = VDist2(myPos[1], myPos[3], base.Position[1], base.Position[3])
                    local dist2 = VDist2(myPos[1], myPos[3], bestBase.Position[1], bestBase.Position[3])

                    if dist1 < dist2 then
                        bestBase = base
                        bestUnit = notDeadUnit
                    end
                end
            end
        end
        if bestBase and bestUnit then
            return bestUnit, bestBase
        end
    end

    return false, false
end

GetExperimentalUnitNC = function(platoon)
    local unit = nil
    for k, v in platoon:GetPlatoonUnits() do
        if not v.Dead then
            unit = v
            break
        end
    end

    return unit
end

GetHighestThreatClusterLocationNC = function(aiBrain, experimental)
    if not aiBrain or not experimental then
        return nil
    end

    -- Look for commander first
    local position = experimental:GetPosition()
  

    if not aiBrain.InterestList or not aiBrain.InterestList.HighPriority then
        -- No target
        return aiBrain:GetHighestThreatPosition(0, true, 'Economy')
    end

    -- Now look through the bases for the highest economic threat and largest cluster of units
    local enemyBases = aiBrain.InterestList.HighPriority
    local bestBaseThreat = nil
    local maxBaseThreat = 0
    for _, base in enemyBases do
        local threatTable = aiBrain:GetThreatsAroundPosition(base.Position, 1, true, 'Economy')
        if table.getn(threatTable) ~= 0 then
            if threatTable[1][3] > maxBaseThreat then
                maxBaseThreat = threatTable[1][3]
                bestBaseThreat = threatTable
            end
        end
    end

    if not bestBaseThreat then
        -- No threat
        return
    end

    -- Look for a cluster of structures
    local maxUnits = -1
    local bestThreat = 1
    for idx, threat in bestBaseThreat do
        if threat[3] > 0 then
            local unitsAtLocation = aiBrain:GetUnitsAroundPoint(ParseEntityCategory('STRUCTURE'), {threat[1], 0, threat[2]}, ScenarioInfo.size[1] / 16, 'Enemy')
            local numunits = table.getn(unitsAtLocation)

            if numunits > maxUnits then
                maxUnits = numunits
                bestThreat = idx
            end
        end
    end

    if bestBaseThreat[bestThreat] then
        local bestPos = {0, 0, 0}
        local maxUnits = 0
        local lookAroundTable = {-2, -1, 0, 1, 2}
        local squareRadius = (ScenarioInfo.size[1] / 16) / table.getn(lookAroundTable)
        for ix, offsetX in lookAroundTable do
            for iz, offsetZ in lookAroundTable do
                local unitsAtLocation = aiBrain:GetUnitsAroundPoint(ParseEntityCategory('STRUCTURE'), {bestBaseThreat[bestThreat][1] + offsetX*squareRadius, 0, bestBaseThreat[bestThreat][2]+offsetZ*squareRadius}, squareRadius, 'Enemy')
                local numUnits = table.getn(unitsAtLocation)
                if numUnits > maxUnits then
                    maxUnits = numUnits
                    bestPos = table.copy(unitsAtLocation[1]:GetPosition())
                end
            end
        end
        if bestPos[1] ~= 0 and bestPos[3] ~= 0 then
            return bestPos
        end
    end

    return nil
end

local SurfacePriorities_mex = {
   
    'MASSEXTRACTION STRUCTURE',
   
}

local SurfacePriorities_landfocus = {
   
    'TECH3 MOBILE LAND',
    'TECH2 MOBILE LAND',
    'TECH1 MOBILE LAND',
   
}

AssignExperimentalPrioritiesNCmex = function(platoon)
    local experimental = GetExperimentalUnitNC(platoon)
    if experimental then
        experimental:SetLandTargetPriorities(SurfacePriorities_mex)
    end
end

AssignExperimentalPrioritiesNClandfocus = function(platoon)
    local experimental = GetExperimentalUnitNC(platoon)
    if experimental then
        experimental:SetLandTargetPriorities(SurfacePriorities_landfocus)
    end
end



CzarBehavior_mex = function(self)
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.uaa0310, experimental) then
        return
    end

    AssignExperimentalPrioritiesNCmex(self)

    local targetUnit, targetBase = FindExperimentalTargetNC(self)
    local oldTargetUnit = nil
    while not experimental.Dead do
        if targetUnit and targetUnit ~= oldTargetUnit then
            IssueClearCommands({experimental})
            WaitTicks(5)

            -- Move to the target without attacking. This will get it out of your base without the beam on.
            if targetUnit and VDist3(targetUnit:GetPosition(), experimental:GetPosition()) > 50 then
                IssueMove({experimental}, targetUnit:GetPosition())
            else
                IssueAttack({experimental}, experimental:GetPosition())
                WaitTicks(5)

                IssueMove({experimental}, targetUnit:GetPosition())
            end
        end
    end
       
end

CzarBehavior_landfocus = function(self)
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.uaa0310, experimental) then
        return
    end

    AssignExperimentalPrioritiesNClandfocus(self)

    local targetUnit, targetBase = FindExperimentalTargetNC(self)
    local oldTargetUnit = nil
    while not experimental.Dead do
        if targetUnit and targetUnit ~= oldTargetUnit then
            IssueClearCommands({experimental})
            WaitTicks(5)

            -- Move to the target without attacking. This will get it out of your base without the beam on.
            if targetUnit and VDist3(targetUnit:GetPosition(), experimental:GetPosition()) > 50 then
                IssueMove({experimental}, targetUnit:GetPosition())
            else
                IssueAttack({experimental}, experimental:GetPosition())
                WaitTicks(5)

                IssueMove({experimental}, targetUnit:GetPosition())
            end
        end

    end
end

AhwassaBehaviorNC_mex = function(self)
    local aiBrain = self:GetBrain()
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.xsa0402, experimental) then
        return
    end

    AssignExperimentalPrioritiesNCmex(self)

    local targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    local oldTargetLocation = nil
    while not experimental.Dead do
        if targetLocation and targetLocation ~= oldTargetLocation then
            IssueClearCommands({experimental})
            IssueAttack({experimental}, targetLocation)
            WaitSeconds(25)
        end
        WaitSeconds(1)

        oldTargetLocation = targetLocation
        targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    end
end

AhwassaBehaviorNC_landfocus = function(self)
    local aiBrain = self:GetBrain()
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.xsa0402, experimental) then
        return
    end

    AssignExperimentalPrioritiesNClandfocus(self)

    local targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    local oldTargetLocation = nil
    while not experimental.Dead do
        if targetLocation and targetLocation ~= oldTargetLocation then
            IssueClearCommands({experimental})
            IssueAttack({experimental}, targetLocation)
            WaitSeconds(25)
        end
        WaitSeconds(1)

        oldTargetLocation = targetLocation
        targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    end
end

TickBehaviorNC_mex = function(self)
    local aiBrain = self:GetBrain()
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.ura0401, experimental) then
        return
    end

    AssignExperimentalPrioritiesNCmex(self)

    local targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    local oldTargetLocation = nil
    while not experimental.Dead do
        if targetLocation and targetLocation ~= oldTargetLocation then
            IssueClearCommands({experimental})
            IssueAggressiveMove({experimental}, targetLocation)
            WaitSeconds(25)
        end
        WaitSeconds(1)

        oldTargetLocation = targetLocation
        targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    end
end

TickBehaviorNC_landfocus = function(self)
    local aiBrain = self:GetBrain()
    local experimental = GetExperimentalUnitNC(self)
    if not experimental then
        return
    end

    if not EntityCategoryContains(categories.ura0401, experimental) then
        return
    end

    AssignExperimentalPrioritiesNClandfocus(self)

    local targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    local oldTargetLocation = nil
    while not experimental.Dead do
        if targetLocation and targetLocation ~= oldTargetLocation then
            IssueClearCommands({experimental})
            IssueAggressiveMove({experimental}, targetLocation)
            WaitSeconds(25)
        end
        WaitSeconds(1)

        oldTargetLocation = targetLocation
        targetLocation = GetHighestThreatClusterLocationNC(aiBrain, experimental)
    end
end