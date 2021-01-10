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
        --LOG('* AI-Uveso: AIFindNearestCategoryTargetInRange: function called with empty "maxRange"' )
        return false, false, false, 'NoRange'
    end
    if not TargetSearchCategory then
        --LOG('* AI-Uveso: AIFindNearestCategoryTargetInRange: function called with empty "TargetSearchCategory"' )
        return false, false, false, 'NoCat'
    end
    if not position then
        --LOG('* AI-Uveso: AIFindNearestCategoryTargetInRange: function called with empty "position"' )
        return false, false, false, 'NoPos'
    end
    if not platoon then
        LOG('* AI-Uveso: AIFindNearestCategoryTargetInRange: function called with no "platoon"' )
        return false, false, false, 'NoPos'
    end
    local AttackEnemyStrength = platoon.PlatoonData.AttackEnemyStrength or 300
    local platoonUnits = platoon:GetPlatoonUnits()
    local PlatoonStrength = table.getn(platoonUnits)

    if type(TargetSearchCategory) == 'string' then
        TargetSearchCategory = ParseEntityCategory(TargetSearchCategory)
    end
    local enemyIndex = false
    local MyArmyIndex = aiBrain:GetArmyIndex()
    if enemyBrain then
        enemyIndex = enemyBrain:GetArmyIndex()
    end

    local RangeList = { [1] = maxRange }
    if maxRange > 512 then
        RangeList = {
            [1] = 30,
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
            [1] = 30,
            [1] = 64,
            [2] = 128,
            [2] = 192,
            [3] = 256,
            [4] = maxRange,
        }
    elseif maxRange > 64 then
        RangeList = {
            [1] = 30,
            [2] = maxRange,
        }
    end
    local path = false
    local reason = false
    local UnitWithPath = false
    local UnitNoPath = false
    local count = 0
    local TargetsInRange, EnemyStrength, TargetPosition, category, distance, targetRange, success, bestGoalPos
    for _, range in RangeList do
        TargetsInRange = aiBrain:GetUnitsAroundPoint(TargetSearchCategory, position, range, 'Enemy')
        --DrawCircle(position, range, '0000FF')
        for _, v in MoveToCategories do
            category = v
            if type(category) == 'string' then
                category = ParseEntityCategory(category)
            end
            distance = maxRange
            --LOG('* AIFindNearestCategoryTargetInRange: numTargets '..table.getn(TargetsInRange)..'  ')
            for num, Target in TargetsInRange do
                if Target.Dead or Target:BeenDestroyed() then
                    continue
                end
                TargetPosition = Target:GetPosition()
                targetRange = VDist2(position[1],position[3],TargetPosition[1],TargetPosition[3])
                --LOG('* AIFindNearestCategoryTargetInRange: targetRange '..repr(targetRange))
                if targetRange < distance then
                    EnemyStrength = 0
                    -- check if thisis the right enemy
                    if not EntityCategoryContains(category, Target) then continue end
                    -- check if the target is on the same layer then the attacker
                    if platoon.MovementLayer ~= 'Air' and not ValidateLayer(TargetPosition, platoon.MovementLayer) then continue end
                    -- check if the Target is still alive, matches our target priority and can be attacked from our platoon
                    if not platoon:CanAttackTarget(squad, Target) then continue end
                    --LOG('* AIFindNearestCategoryTargetInRange: canAttack '..repr(canAttack))
                    if not Target.Dead then
                        -- yes... we need to check if we got friendly units with GetUnitsAroundPoint(_, _, _, 'Enemy')
                        if not IsEnemy( MyArmyIndex, Target:GetAIBrain():GetArmyIndex() ) then continue end
                        -- check if the target is inside a nuke blast radius
                        if IsNukeBlastArea(aiBrain, TargetPosition) then continue end
                        -- check if we have a special player as enemy
                        if enemyBrain and enemyIndex and enemyBrain ~= enemyIndex then continue end
                        if Target.ReclaimInProgress then
                            --WARN('* AIFindNearestCategoryTargetInRange: ReclaimInProgress !!! Ignoring the target.')
                            continue
                        end
                        if Target.CaptureInProgress then
                            --WARN('* AIFindNearestCategoryTargetInRange: CaptureInProgress !!! Ignoring the target.')
                            continue
                        end
                        if not aiBrain:PlatoonExists(platoon) then
                            return false, false, false, 'NoPlatoonExists'
                        end
                        if platoon.MovementLayer == 'Land' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE + categories.GROUNDATTACK) , TargetPosition, 50, 'Enemy' )
                        elseif platoon.MovementLayer == 'Air' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * categories.ANTIAIR , TargetPosition, 60, 'Enemy' )
                        elseif platoon.MovementLayer == 'Water' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE + categories.GROUNDATTACK + categories.ANTINAVY) , TargetPosition, 50, 'Enemy' )
                        elseif platoon.MovementLayer == 'Amphibious' then
                            EnemyStrength = aiBrain:GetNumUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) * (categories.DIRECTFIRE + categories.INDIRECTFIRE + categories.GROUNDATTACK + categories.ANTINAVY) , TargetPosition, 50, 'Enemy' )
                        end
                        --LOG('PlatoonStrength / 100 * AttackEnemyStrength <= '..(PlatoonStrength / 100 * AttackEnemyStrength)..' || EnemyStrength = '..EnemyStrength)
                        -- Only attack if we have a chance to win
                        if PlatoonStrength / 100 * AttackEnemyStrength < EnemyStrength then continue end
                        --coroutine.yield(1)
                        --LOG('* AIFindNearestCategoryTargetInRange: PlatoonGenerateSafePathTo ')
                        path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, platoon.MovementLayer, position, TargetPosition, platoon.PlatoonData.NodeWeight or 10 )
                        -- Check if we found a path with markers
                        if path then
                            UnitWithPath = Target
                            distance = targetRange
                            --LOG('* AIFindNearestCategoryTargetInRange: Possible target with path. distance '..distance..'  ')
                        -- We don't find a path with markers
                        else
                            -- NoPath happens if we have markers, but can't find a way to the destination. (We need transport)
                            if reason == 'NoPath' then
                                UnitNoPath = Target
                                distance = targetRange
                                --LOG('* AIFindNearestCategoryTargetInRange: Possible target no path. distance '..distance..'  ')
                            -- NoGraph means we have no Map markers. Lets try to path with c-engine command CanPathTo()
                            elseif reason == 'NoGraph' then
                                --coroutine.yield(1)
                                local success, bestGoalPos = AIAttackUtils.CheckPlatoonPathingEx(platoon, TargetPosition)
                                -- check if we found a path with c-engine command.
                                if success then
                                    UnitWithPath = Target
                                    distance = targetRange
                                    --LOG('* AIFindNearestCategoryTargetInRange: Possible target with CanPathTo(). distance '..distance..'  ')
                                    -- break out of the loop, so we don't use CanPathTo too often.
                                    break
                                -- There is no path to the target.
                                else
                                    UnitNoPath = Target
                                    distance = targetRange
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
                -- DEBUG; use the first target if we can path to it.
                --if UnitWithPath then
                --    return UnitWithPath, UnitNoPath, path, reason
                --end
                -- DEBUG; use the first target if we can path to it.
            end
            if UnitWithPath then
                return UnitWithPath, false, path, reason
            end
        end
    end
    if UnitNoPath then
        return false, UnitNoPath, false, reason
    end
    return false, false, false, 'NoUnitFound'
end