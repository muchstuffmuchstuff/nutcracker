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

function AIFindNearestCategoryTeleportLocationNC(aiBrain, position, maxRange, MoveToCategories, TargetSearchCategory, enemyBrain)
    if type(TargetSearchCategory) == 'string' then
        TargetSearchCategory = ParseEntityCategory(TargetSearchCategory)
    end
    local enemyIndex = false
    if enemyBrain then
        enemyIndex = enemyBrain:GetArmyIndex()
    end
    local TargetUnit = false
    local TargetsInRange, TargetPosition, category, distance, targetRange, AntiteleportUnits

    TargetsInRange = aiBrain:GetUnitsAroundPoint(TargetSearchCategory, position, maxRange, 'Enemy')
    LOG('* AIFindNearestCategoryTeleportLocation: numTargets '..table.getn(TargetsInRange)..'  ')
    --DrawCircle(position, range, '0000FF')
    for _, v in MoveToCategories do
        category = v
        if type(category) == 'string' then
            category = ParseEntityCategory(category)
        end
        distance = maxRange
        for num, Target in TargetsInRange do
            if Target.Dead or Target:BeenDestroyed() then
                continue
            end
            TargetPosition = Target:GetPosition()
            -- check if the target is inside a nuke blast radius
            if IsNukeBlastArea(aiBrain, TargetPosition) then continue end
            -- check if we have a special player as enemy
            if enemyBrain and enemyIndex and enemyBrain ~= enemyIndex then continue end
            -- check if the Target is still alive, matches our target priority and can be attacked from our platoon
            if not Target.Dead and EntityCategoryContains(category, Target) then
                -- yes... we need to check if we got friendly units with GetUnitsAroundPoint(_, _, _, 'Enemy')
                if not IsEnemy( aiBrain:GetArmyIndex(), Target:GetAIBrain():GetArmyIndex() ) then continue end
                targetRange = VDist2(position[1],position[3],TargetPosition[1],TargetPosition[3])
                -- check if the target is in range of the ACU and in range of the base
                if targetRange < distance then
                    -- Check if the target is protected by antiteleporter
                    if categories.ANTITELEPORT then 
                        AntiteleportUnits = aiBrain:GetUnitsAroundPoint(categories.ANTITELEPORT, TargetPosition, 60, 'Enemy')
                        LOG('* AIFindNearestCategoryTeleportLocation: numAntiteleportUnits '..table.getn(AntiteleportUnits)..'  ')
                        local scrambled = false
                        for i, unit in AntiteleportUnits do
                            -- If it's an ally, then we skip.
                            if not IsEnemy( aiBrain:GetArmyIndex(), unit:GetAIBrain():GetArmyIndex() ) then continue end
                            local NoTeleDistance = unit:GetBlueprint().Defense.NoTeleDistance
                            if NoTeleDistance then
                                local AntiTeleportTowerPosition = unit:GetPosition()
                                local dist = VDist2(TargetPosition[1], TargetPosition[3], AntiTeleportTowerPosition[1], AntiTeleportTowerPosition[3])
                                if dist and NoTeleDistance >= dist then
                                    LOG('* AIFindNearestCategoryTeleportLocation: Teleport Destination Scrambled 1 '..repr(TargetPosition)..' - '..repr(AntiTeleportTowerPosition))
                                    scrambled = true
                                    break
                                end
                            end
                        end
                        if scrambled then
                            continue
                        end
                    end
                    LOG('* AIFindNearestCategoryTeleportLocation: Found a target that is not Teleport Scrambled')
                    TargetUnit = Target
                    distance = targetRange
                end
            end
        end
        if TargetUnit then
            return TargetUnit
        end
       coroutine.yield(10)
    end
    return TargetUnit
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
    ---LOG(aiBrain:GetArmyIndex()..' CompareBody {World} ( '..numOwnUnits..' '..compareType..' '..numEnemyUnits..' ) -- ['..ratio..'] -- return '..repr(CompareBodyNC(numOwnUnits / numEnemyUnits, ratio, compareType)))
    return CompareBodyNC(numOwnUnits / numEnemyUnits, ratio, compareType)
    
end