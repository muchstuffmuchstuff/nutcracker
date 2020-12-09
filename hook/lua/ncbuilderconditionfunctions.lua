function EnemyInT3ArtilleryRangeNC(aiBrain, locationtype, inrange)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end

    local start = engineerManager:GetLocationCoords()
    local factionIndex = aiBrain:GetFactionIndex()
    local radius = 0
    local offset = 0
    if factionIndex == 1 then
        radius = 825 + offset
    elseif factionIndex == 2 then
        radius = 825 + offset
    elseif factionIndex == 3 then
        radius = 825 + offset
    elseif factionIndex == 4 then
        radius = 825 + offset
    end
    for k,v in ArmyBrains do
        if not v.Result == "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsEnemy(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            local estartX, estartZ = v:GetArmyStartPos()
            if (VDist2Sq(start[1], start[3], estartX, estartZ) <= radius * radius) and inrange then
                return true
            elseif (VDist2Sq(start[1], start[3], estartX, estartZ) > radius * radius) and not inrange then
                return true
            end
        end
    end
    return false
end

function EnemyInT3RapidArtilleryRangeNC(aiBrain, locationtype, inrange)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end

    local start = engineerManager:GetLocationCoords()
    local factionIndex = aiBrain:GetFactionIndex()
    local radius = 0
    local offset = 0
    if factionIndex == 1 then
        radius = 1700 + offset
    elseif factionIndex == 2 then
        radius = 1700 + offset
    elseif factionIndex == 3 then
        radius = 1700 + offset
    elseif factionIndex == 4 then
        radius = 1700 + offset
    end
    for k,v in ArmyBrains do
        if not v.Result == "defeat" and not ArmyIsCivilian(v:GetArmyIndex()) and IsEnemy(v:GetArmyIndex(), aiBrain:GetArmyIndex()) then
            local estartX, estartZ = v:GetArmyStartPos()
            if (VDist2Sq(start[1], start[3], estartX, estartZ) <= radius * radius) and inrange then
                return true
            elseif (VDist2Sq(start[1], start[3], estartX, estartZ) > radius * radius) and not inrange then
                return true
            end
        end
    end
    return false
end