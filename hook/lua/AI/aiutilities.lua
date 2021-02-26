function AIFindUndefendedBrainTargetInRangeNC(aiBrain, platoon, squad, maxRange, atkPri)
    local position = platoon:GetPlatoonPosition()
    if not aiBrain or not position or not maxRange then
        return false
    end

    local numUnits = table.getn(platoon:GetPlatoonUnits())
    local maxShields = math.ceil(numUnits / 7)
    local targetUnits = aiBrain:GetUnitsAroundPoint(categories.ALLUNITS, position, maxRange, 'Enemy')
    for _, v in atkPri do
        local retUnit = false
        local distance = false
        local targetShields = 9999
        for num, unit in targetUnits do
            if not unit.Dead and EntityCategoryContains(v, unit) and platoon:CanAttackTarget(squad, unit) then
                local unitPos = unit:GetPosition()
                local numShields = aiBrain:GetNumUnitsAroundPoint(categories.DEFENSE * categories.SHIELD * categories.STRUCTURE, unitPos, 46, 'Enemy')
                if numShields < maxShields and (not retUnit or numShields < targetShields or (numShields == targetShields and Utils.XZDistanceTwoVectors(position, unitPos) < distance)) then
                    retUnit = unit
                    distance = Utils.XZDistanceTwoVectors(position, unitPos)
                    targetShields = numShields
                end
            end
        end
        if retUnit and targetShields > 0 then
            local platoonUnits = platoon:GetPlatoonUnits()
            for _, w in platoonUnits do
                if not w.Dead then
                    unit = w
                    break
                end
            end
            local closestBlockingShield = AIBehaviors.GetClosestShieldProtectingTargetSorian(unit, retUnit)
            if closestBlockingShield then
                return closestBlockingShield
            end
        end
        if retUnit then
            return retUnit
        end
    end

    return false
end

function AIFindNearestCategoryTargetInRangeNC(aiBrain, platoon, squad, position, maxRange, MoveToCategories, TargetSearchCategory, enemyBrain)
    if not maxRange then
        return false, false, false, 'NoRange'
    end
    if not TargetSearchCategory then
        return false, false, false, 'NoCat'
    end
    if not position then
        return false, false, false, 'NoPos'
    end
    if not platoon then
        return false, false, false, 'NoPlatoon'
    end
    local AttackEnemyStrength = platoon.PlatoonData.AttackEnemyStrength or 300
    local platoonUnits = platoon:GetPlatoonUnits()
    local PlatoonStrength = table.getn(platoonUnits)
    local IgnoreTargetLayerCheck = platoon.PlatoonData.IgnoreTargetLayerCheck
    
    local enemyIndex = false
    local MyArmyIndex = aiBrain:GetArmyIndex()
    if enemyBrain then
        enemyIndex = enemyBrain:GetArmyIndex()
    end

    local RangeList = { [1] = maxRange }
    if maxRange > 512 then
        RangeList = {
            [1] = 64,
            [2] = 128,
            [2] = 192,
            [3] = 256,
            [3] = 384,
            [4] = 512,
            [5] = maxRange,
        }
    elseif maxRange > 256 then
        RangeList = {
            [1] = 64,
            [2] = 128,
            [2] = 192,
            [3] = 256,
            [4] = maxRange,
        }
    elseif maxRange > 64 then
        RangeList = {
            [1] = 64,
            [2] = maxRange,
        }
    end

    local path = false
    local reason = false
    local ReturnReason = 'got no reason'
    local UnitWithPath = false
    local UnitNoPath = false
    local count = 0
    local TargetsInRange, EnemyStrength, TargetPosition, distance, targetRange, success, bestGoalPos
    for _, range in RangeList do
        TargetsInRange = aiBrain:GetUnitsAroundPoint(TargetSearchCategory, position, range, 'Enemy')
        --LOG('* AIFindNearestCategoryTargetInRange: numTargets '..table.getn(TargetsInRange)..'  ')
        for _, category in MoveToCategories do
            distance = maxRange
            for num, Target in TargetsInRange do
                if Target.Dead or Target:BeenDestroyed() then
                    continue
                end
                TargetPosition = Target:GetPosition()
                targetRange = VDist2(position[1],position[3],TargetPosition[1],TargetPosition[3])
                --LOG('* AIFindNearestCategoryTargetInRange: targetRange '..repr(targetRange))
                if targetRange < distance then
                    EnemyStrength = 0
                    -- check if this is the right enemy
                    if not EntityCategoryContains(category, Target) then continue end
                    -- check if the target is on the same layer then the attacker
                    if not IgnoreTargetLayerCheck then
                        if not ValidateAttackLayer(position, TargetPosition) then continue end
                    end
                    -- check if the Target is still alive, matches our target priority and can be attacked from our platoon
                    if not platoon:CanAttackTarget(squad, Target) then continue end
                    --LOG('* AIFindNearestCategoryTargetInRange: canAttack '..repr(canAttack))
                    if platoon.MovementLayer == 'Land' and EntityCategoryContains(categories.AIR, Target) then continue end
                    if not Target.Dead then
                        -- yes... we need to check if we got friendly units with GetUnitsAroundPoint(_, _, _, 'Enemy')
                        if not IsEnemy( MyArmyIndex, Target.Army ) then continue end
                        -- check if the target is inside a nuke blast radius
                        if IsNukeBlastArea(aiBrain, TargetPosition) then continue end
                        -- check if we have a special player as enemy
                        if enemyBrain and enemyIndex and enemyBrain ~= enemyIndex then continue end
                        -- we can't attack units while reclaim or capture is in progress
                        if Target.ReclaimInProgress then continue end
                        if Target.CaptureInProgress then continue end
                        if not aiBrain:PlatoonExists(platoon) then
                            return false, false, false, 'NoPlatoonExists'
                        end
                        if platoon.MovementLayer == 'Land' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE) , TargetPosition, 50, 'Enemy' )
                        elseif platoon.MovementLayer == 'Air' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * categories.ANTIAIR , TargetPosition, 60, 'Enemy' )
                        elseif platoon.MovementLayer == 'Water' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE + categories.ANTINAVY) , TargetPosition, 50, 'Enemy' )
                        elseif platoon.MovementLayer == 'Amphibious' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE + categories.ANTINAVY) , TargetPosition, 50, 'Enemy' )
                        end
                        --LOG('PlatoonStrength / 100 * AttackEnemyStrength <= '..(PlatoonStrength / 100 * AttackEnemyStrength)..' || EnemyStrength = '..EnemyStrength)
                        -- Only attack if we have a chance to win
                        if PlatoonStrength / 100 * AttackEnemyStrength < EnemyStrength then continue end
                        --LOG('* AIFindNearestCategoryTargetInRange: PlatoonGenerateSafePathTo ')
                        path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, platoon.MovementLayer, position, TargetPosition, platoon.PlatoonData.NodeWeight or 10 )
                        -- Check if we found a path with markers
                        if path then
                            UnitWithPath = Target
                            distance = targetRange
                            ReturnReason = reason
                            --LOG('* AIFindNearestCategoryTargetInRange: Possible target with path. distance '..distance..'  ')
                        -- We don't find a path with markers
                        else
                            -- NoPath happens if we have markers, but can't find a way to the destination. (We need transport)
                            if reason == 'NoPath' then
                                UnitNoPath = Target
                                distance = targetRange
                                ReturnReason = reason
                                --LOG('* AIFindNearestCategoryTargetInRange: Possible target no path. distance '..distance..'  ')
                            -- NoGraph means we have no Map markers. Lets try to path with c-engine command CanPathTo()
                            elseif reason == 'NoGraph' then
                                local success, bestGoalPos = AIAttackUtils.CheckPlatoonPathingEx(platoon, TargetPosition)
                                -- check if we found a path with c-engine command.
                                if success then
                                    UnitWithPath = Target
                                    distance = targetRange
                                    ReturnReason = reason
                                    --LOG('* AIFindNearestCategoryTargetInRange: Possible target with CanPathTo(). distance '..distance..'  ')
                                    -- break out of the loop, so we don't use CanPathTo too often.
                                    break
                                -- There is no path to the target.
                                else
                                    UnitNoPath = Target
                                    distance = targetRange
                                    ReturnReason = reason
                                    --LOG('* AIFindNearestCategoryTargetInRange: Possible target failed CanPathTo(). distance '..distance..'  ')
                                end
                            end
                        end
                    end
                end
                count = count + 1
                if count > 300 then -- 300 
                    coroutine.yield(1)
                    count = 0
                end
                -- DEBUG; use the first target we can path to it.
                --if UnitWithPath then
                --    return UnitWithPath, UnitNoPath, path, ReturnReason
                --end
                -- DEBUG; use the first target we can path to it.
            end
            if UnitWithPath then
                return UnitWithPath, false, path, ReturnReason
            end
        end
    end
    if UnitNoPath then
        return false, UnitNoPath, false, ReturnReason
    end
    return false, false, false, 'NoUnitFound'
end

function IsNukeBlastAreaNC(aiBrain, TargetPosition)
    -- check if the target is inside a nuke blast radius
    if aiBrain.NukedArea then
        for i, data in aiBrain.NukedArea or {} do
            if data.NukeTime + 50 <  GetGameTimeSeconds() then
                table.remove(aiBrain.NukedArea, i)
            elseif VDist2(TargetPosition[1], TargetPosition[3], data.Location[1], data.Location[3]) < 40 then
                return true
            end
        end
    end
    return false
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