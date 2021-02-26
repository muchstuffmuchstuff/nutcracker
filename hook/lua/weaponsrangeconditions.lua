local AIUtils = import('/lua/ai/aiutilities.lua')
local mapSizeX, mapSizeZ = GetMapSize()
local CanPathToEnemyNC = {}

local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
local Utils = import('/lua/utilities.lua')




function CheckUnitRangeNC(aiBrain, locationType, unitType, category, factionIndex)

    local template = import('/lua/BuildingTemplates.lua').BuildingTemplates[factionIndex or aiBrain:GetFactionIndex()]
    local buildingId = false
    for k,v in template do
        if v[1] == unitType then
            buildingId = v[2]
            break
        end
    end
    if not buildingId then
        WARN('*AI ERROR: Invalid building type - ' .. unitType)
        return false
    end

    local bp = __blueprints[buildingId]
    if not bp.Economy.BuildTime or not bp.Economy.BuildCostMass then
        WARN('*AI ERROR: Unit for EconomyCheckStructure is missing blueprint values - ' .. unitType)
        return false
    end

    local range = false
    for k,v in bp.Weapon do
        if not range or v.MaxRadius > range then
            range = v.MaxRadius
        end
    end
    if not range then
        WARN('*AI ERROR: No MaxRadius for unit type - ' .. unitType)
        return false
    end

    local basePosition
    if aiBrain.BuilderManagers[locationType] then
    basePosition = aiBrain:GetLocationPosition(locationType)
    end

    # Check around basePosition for StructureThreat
    local unit = AIUtils.AIFindBrainTargetAroundPoint(aiBrain, basePosition, range, category)

    if unit then
        return true
    end
    return false
end

function CanPathToCurrentEnemyNC(aiBrain, locationType, bool) 
    local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')

    local locPos = aiBrain.BuilderManagers[locationType].Position 
    
    if not locPos then
        locPos = aiBrain.BuilderManagers['MAIN'].Position
    end
    local enemyX, enemyZ
    if aiBrain:GetCurrentEnemy() then
        enemyX, enemyZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
    
        if not enemyX then
            return false
        end
    else
       
        return false
    end

 
    local EnemyIndex = ArmyBrains[aiBrain:GetCurrentEnemy():GetArmyIndex()].Nickname
    local OwnIndex = ArmyBrains[aiBrain:GetArmyIndex()].Nickname

   
    CanPathToEnemyNC[OwnIndex] = CanPathToEnemyNC[OwnIndex] or {}
    CanPathToEnemyNC[OwnIndex][EnemyIndex] = CanPathToEnemyNC[OwnIndex][EnemyIndex] or {}
  
    if CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'LAND' then
        return true == bool
    elseif CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'WATER' then
        return false == bool
    end
    
    
    local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Land', locPos, {enemyX,0,enemyZ}, 1000)
  
    if path then
      
        CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'LAND'
 
    else

        if reason == 'NoPath' then
 
            CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'WATER'
 
        elseif reason == 'NoGraph' then
    
            if aiBrain:GetMapWaterRatio() < 0.60 then
             
                CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'LAND'
            else
        
                CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'WATER'
            end
        end
    end
    if CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'LAND' then
        return true == bool
    elseif CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'WATER' then
        return false == bool
    end
    CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'WATER'
    return false == bool
end



function RandomizePositionNC(position)
    local Posx = position[1]
    local Posz = position[3]
    local X = -1
    local Z = -1
    while X <= 0 or X >= ScenarioInfo.size[1] do
        X = Posx + Random(-10, 10)
    end
    while Z <= 0 or Z >= ScenarioInfo.size[2] do
        Z = Posz + Random(-10, 10)
    end
    local Y = GetTerrainHeight(Posx, Posz)
    if GetSurfaceHeight(Posx, Posz) > Y then
        Y = GetSurfaceHeight(Posx, Posz)
    end
    return {X, Y, Z}
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

function HaveUnitRatioVersusEnemyNC(aiBrain, ratio, categoryOwn, compareType, categoryEnemy)
    local numOwnUnits = aiBrain:GetCurrentUnits(categoryOwn)
    local numEnemyUnits = aiBrain:GetNumUnitsAroundPoint(categoryEnemy, Vector(mapSizeX/2,0,mapSizeZ/2), mapSizeX+mapSizeZ , 'Enemy')
    return CompareBodyNC(numOwnUnits / numEnemyUnits, ratio, compareType)
    
end

function EnemyInTMLRangeNC(aiBrain, locationtype, inrange)
    local engineerManager = aiBrain.BuilderManagers[locationtype].EngineerManager
    if not engineerManager then
        return false
    end

    local start = engineerManager:GetLocationCoords()
    local factionIndex = aiBrain:GetFactionIndex()
    local radius = 0
    local offset = 0
    if factionIndex == 1 then
        radius = 250 + offset
    elseif factionIndex == 2 then
        radius = 250 + offset
    elseif factionIndex == 3 then
        radius = 250 + offset
    elseif factionIndex == 4 then
        radius = 250 + offset
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

function SubCmdrHasUpgradeNC(aiBrain, upgrade, has)
    local units = aiBrain:GetListOfUnits(categories.SUBCOMMANDER, false)
    for k,v in units do
        if v:HasEnhancement(upgrade) and has then
            return true
        elseif not v:HasEnhancement(upgrade) and not has then
            return true
        end
    end
    return false
end





