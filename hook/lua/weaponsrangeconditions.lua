local AIUtils = import('/lua/ai/aiutilities.lua')
local CanPathToEnemyNC = {}
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

    local basePosition = aiBrain:GetLocationPosition(locationType)

    # Check around basePosition for StructureThreat
    local unit = AIUtils.AIFindBrainTargetAroundPoint(aiBrain, basePosition, range, category)

    if unit then
        return true
    end
    return false
end

function CanPathToCurrentEnemyNC(aiBrain, locationType, bool) -- Uveso's function modified to work with expansions
    local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
    --We are getting the current base position rather than the start position so we can use this for expansions.
    local locPos = aiBrain.BuilderManagers[locationType].Position 
    -- added this incase the position came back nil
    if not locPos then
        locPos = aiBrain.BuilderManagers['MAIN'].Position
    end
    local enemyX, enemyZ
    if aiBrain:GetCurrentEnemy() then
        enemyX, enemyZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
        -- if we don't have an enemy position then we can't search for a path. Return until we have an enemy position
        if not enemyX then
            return false
        end
    else
        -- if we don't have a current enemy then return false
        return false
    end

    -- Get the armyindex from the enemy
    local EnemyIndex = ArmyBrains[aiBrain:GetCurrentEnemy():GetArmyIndex()].Nickname
    local OwnIndex = ArmyBrains[aiBrain:GetArmyIndex()].Nickname

    -- create a table for the enemy index in case it's nil
    CanPathToEnemyNC[OwnIndex] = CanPathToEnemyNC[OwnIndex] or {}
    CanPathToEnemyNC[OwnIndex][EnemyIndex] = CanPathToEnemyNC[OwnIndex][EnemyIndex] or {}
    -- Check if we have already done a path search to the current enemy
    if CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'LAND' then
        return true == bool
    elseif CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] == 'WATER' then
        return false == bool
    end
    -- path wit AI markers from our base to the enemy base
    --LOG('Validation GenerateSafePath inputs locPos :'..repr(locPos)..'Enemy Pos: '..repr({enemyX,0,enemyZ}))
    local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Land', locPos, {enemyX,0,enemyZ}, 1000)
    -- if we have a path generated with AI path markers then....
    if path then
        --LOG('* RNG CanPathToCurrentEnemyRNG: Land path to the enemy found! LAND map! - '..OwnIndex..' vs '..EnemyIndex..''..' Location '..locationType)
        CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'LAND'
    -- if we not have a path
    else
        -- "NoPath" means we have AI markers but can't find a path to the enemy - There is no path!
        if reason == 'NoPath' then
            --LOG('* RNG CanPathToCurrentEnemyRNG: No land path to the enemy found! WATER map! - '..OwnIndex..' vs '..EnemyIndex..''..' Location '..locationType)
            CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'WATER'
        -- "NoGraph" means we have no AI markers and cant graph to the enemy. We can't search for a path - No markers
        elseif reason == 'NoGraph' then
            --LOG('* RNG CanPathToCurrentEnemyRNG: No AI markers found! Using land/water ratio instead')
            -- Check if we have less then 50% water on the map
            if aiBrain:GetMapWaterRatio() < 0.60 then
                --lets asume we can move on land to the enemy
                --LOG(string.format('* RNG CanPathToCurrentEnemy: Water on map: %0.2f%%. Assuming LAND map! - '..OwnIndex..' vs '..EnemyIndex..''..' Location '..locationType ,aiBrain:GetMapWaterRatio()*100 ))
                CanPathToEnemyNC[OwnIndex][EnemyIndex][locationType] = 'LAND'
            else
                -- we have more then 60% water on this map. Ity maybe a water map..
                --LOG(string.format('* RNG CanPathToCurrentEnemy: Water on map: %0.2f%%. Assuming WATER map! - '..OwnIndex..' vs '..EnemyIndex..''..' Location '..locationType ,aiBrain:GetMapWaterRatio()*100 ))
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