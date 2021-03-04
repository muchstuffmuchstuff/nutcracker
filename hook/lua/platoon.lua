local UseHeroPlatoon = true
local PlatoonExists = moho.aibrain_methods.PlatoonExists
NCAIPlatoon = Platoon
local AIUtils = import('/lua/ai/aiutilities.lua')
local Behaviors = import('/lua/ai/aibehaviors.lua')
local Weapcon = import('/mods/nutcracker/hook/lua/weaponsrangeconditions.lua')
local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
local Utils = import('/lua/utilities.lua')
local GetMostRestrictiveLayer = import('/lua/AI/aiattackutilities.lua')

Platoon = Class(NCAIPlatoon) {
    
    
TacticalAINC = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local platoonUnits = self:GetPlatoonUnits()
    local unit
    
    if not aiBrain:PlatoonExists(self) then return end
    
    #GET THE Launcher OUT OF THIS PLATOON
    for k, v in platoonUnits do
        if EntityCategoryContains(categories.STRUCTURE * categories.TACTICALMISSILEPLATFORM, v) then
            unit = v
            break
        end
    end
    
    if not unit then return end
    
    local bp = unit:GetBlueprint()
    local weapon = bp.Weapon[1]
    local maxRadius = weapon.MaxRadius
    local minRadius = weapon.MinRadius
    unit:SetAutoMode(true)
    local atkPri = { 'STRUCTURE STRATEGIC EXPERIMENTAL', 'ARTILLERY EXPERIMENTAL', 'STRUCTURE NUKE EXPERIMENTAL', 'EXPERIMENTAL ORBITALSYSTEM', 'STRUCTURE ARTILLERY TECH3', 
    'STRUCTURE NUKE TECH3', 'EXPERIMENTAL ENERGYPRODUCTION STRUCTURE', 'COMMAND', 'EXPERIMENTAL MOBILE LAND', 'TECH3 MASSFABRICATION', 'TECH3 ENERGYPRODUCTION', 'TECH3 MASSPRODUCTION', 'TECH2 ENERGYPRODUCTION', 'TECH2 MASSPRODUCTION', 'STRUCTURE SHIELD', 'NAVAL' } # 'STRUCTURE STRATEGIC', 'STRUCTURE DEFENSE TECH3', 'STRUCTURE DEFENSE TECH2', 'STRUCTURE FACTORY', 'STRUCTURE', 'LAND, NAVAL' }
    self:SetPrioritizedTargetList( 'Attack', { categories.STRUCTURE * categories.ARTILLERY * categories.EXPERIMENTAL, categories.STRUCTURE * categories.NUKE * categories.EXPERIMENTAL, categories.EXPERIMENTAL * categories.ORBITALSYSTEM, categories.STRUCTURE * categories.ARTILLERY * categories.TECH3, 
    categories.STRUCTURE * categories.NUKE * categories.TECH3, categories.EXPERIMENTAL * categories.ENERGYPRODUCTION * categories.STRUCTURE, categories.COMMAND, categories.EXPERIMENTAL * categories.MOBILE * categories.LAND, categories.TECH3 * categories.MASSFABRICATION,
    categories.TECH3 * categories.ENERGYPRODUCTION, categories.TECH3 * categories.MASSPRODUCTION, categories.TECH2 * categories.ENERGYPRODUCTION, categories.TECH2 * categories.MASSPRODUCTION, categories.STRUCTURE * categories.SHIELD, categories.NAVAL } ) # categories.STRUCTURE * categories.STRATEGIC, categories.STRUCTURE * categories.DEFENSE * categories.TECH3, categories.STRUCTURE * categories.DEFENSE * categories.TECH2, categories.STRUCTURE * categories.FACTORY, categories.STRUCTURE, categories.LAND + categories.NAVAL } )
    while aiBrain:PlatoonExists(self) do
        local target = false
        local blip = false
        while unit:GetTacticalSiloAmmoCount() < 1 or not target do
            WaitSeconds(7)
            target = false
            while not target do
                #if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy():IsDefeated() then
                #    aiBrain:PickEnemyLogic()
                #end

                target = AIUtils.AIFindBrainTargetInRangeSorian( aiBrain, self, 'Attack', maxRadius, atkPri, true )
                local newtarget = false
                if aiBrain.AttackPoints and table.getn(aiBrain.AttackPoints) > 0 then
                    newtarget = AIUtils.AIFindPingTargetInRangeSorian( aiBrain, self, 'Attack', maxRadius, atkPri, true )
                    if newtarget then
                        target = newtarget
                    end
                end
                if not target then
                    target = self:FindPrioritizedUnit('Attack', 'Enemy', true, unit:GetPosition(), maxRadius)
                end
                if target then
                    break
                end
                WaitSeconds(3)
                if not aiBrain:PlatoonExists(self) then
                    return
                end
            end
        end
        if not target:IsDead() then
            #LOG('*AI DEBUG: Firing Tactical Missile at enemy swine!')
            if EntityCategoryContains(categories.STRUCTURE, target) then
                IssueTactical({unit}, target)
            else
                targPos = SUtils.LeadTarget(self, target)
                if targPos then
                    IssueTactical({unit}, targPos)
                end
            end
        end
        WaitSeconds(3)
    end
end,


NCsatelite = function(self)
    local aiBrain = self:GetBrain()
    local data = self.PlatoonData
    local atkPri = {}
    local atkPriTable = {}
    if data.PrioritizedCategories then
        for k,v in data.PrioritizedCategories do
            table.insert(atkPri, v)
            table.insert(atkPriTable, v)
        end
    end
    table.insert(atkPri, categories.ALLUNITS)
    table.insert(atkPriTable, categories.ALLUNITS)
    self:SetPrioritizedTargetList('Attack', atkPriTable)

    local maxRadius = data.SearchRadius or 50
    local oldTarget = false
    local target = false
   --('Novax AI starting')
    
    while PlatoonExists(aiBrain, self) do
       
        target = AIUtils.AIFindUndefendedBrainTargetInRangeNC(aiBrain, self, 'Attack', maxRadius, atkPri)
        local targetRotation = 0
        if target and target != oldTarget and not target.Dead then
            -- Pondering over if getting the target position would be useful for calling in air strike on target if shielded.
            --local targetpos = target:GetPosition()
            local originalHealth = target:GetHealth()
            self:Stop()
            self:AttackTarget(target)
            while (target and not target.Dead) or targetRotation < 6 do
                --LOG('Novax Target Rotation is '..targetRotation)
                targetRotation = targetRotation + 1
                WaitTicks(100)
                if target.Dead then
                    break
                end
            end
            if target and not target.Dead then
                local currentHealth = target:GetHealth()
                --LOG('Target is not dead at end of loop with health '..currentHealth)
                if currentHealth == originalHealth then
                    --LOG('Enemy Unit Health no change, setting to old target')
                    oldTarget = target
                end
            end
        end
        WaitTicks(100)
        self:Stop()
        --LOG('End of Satellite loop')
    end
end,


FighterHuntNC = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local location = self.PlatoonData.LocationType or 'MAIN'
    local radius = self.PlatoonData.Radius or 500
    local target
    local blip
    local hadtarget = false
    while aiBrain:PlatoonExists(self) do
        if self:IsOpponentAIRunning() then
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.AIR - categories.SCOUT - categories.POD - categories.CONSTRUCTION - categories.SHIELD)
            local newtarget = false
            if aiBrain.T4ThreatFound['Air'] then
                newtarget = self:FindClosestUnit('Attack', 'Enemy', true, categories.EXPERIMENTAL * categories.AIR)
                if newtarget then
                    target = newtarget
                end
            end
            if target and newtarget and target:GetFractionComplete() == 1
            and SUtils.GetThreatAtPosition( aiBrain, target:GetPosition(), 1, 'AntiAir', {'Air'}) < (AIAttackUtils.GetAirThreatOfUnits(self) * .7) then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AttackTarget( target )
                hadtarget = true
            elseif target and target:GetFractionComplete() == 1
            and SUtils.GetThreatAtPosition( aiBrain, target:GetPosition(), 1, 'AntiAir', {'Air'}) < (AIAttackUtils.GetAirThreatOfUnits(self) * .7) then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AggressiveMoveToLocation( table.copy(target:GetPosition()) )
                hadtarget = true
            elseif not target and hadtarget then
                for k,v in AIUtils.GetBasePatrolPoints(aiBrain, location, radius, 'Air') do
                    self:Patrol(v)
                end
            end
        end
        local waitLoop = 0
        repeat
            WaitSeconds(1)
            waitLoop = waitLoop + 1
        until waitLoop >= 17 or (target and (target:IsDead() or not target:GetPosition()))
    end
end,	

GuardBaseSorian2 = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local target = false
    local basePosition = false
    local radius = self.PlatoonData.Radius or 200
    local patrolling = false

    if self.PlatoonData.LocationType and self.PlatoonData.LocationType != 'NOTMAIN' then
        basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
    else
        basePosition = aiBrain:FindClosestBuilderManagerPosition(self:GetPlatoonPosition())
    end
    
    local guardRadius = self.PlatoonData.GuardRadius or 400
    local mapSizeX, mapSizeZ = GetMapSize()
    local T4Radius = math.sqrt((mapSizeX * mapSizeX) + (mapSizeZ * mapSizeZ)) / 2
    
    while aiBrain:PlatoonExists(self) do
        if self:IsOpponentAIRunning() then
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.ALLUNITS - categories.WALL)
            local newtarget = false
            if aiBrain.T4ThreatFound['Air'] then
                newtarget = self:FindClosestUnit('Attack', 'Enemy', true, categories.EXPERIMENTAL * categories.AIR)
                if newtarget then
                    target = newtarget
                end
            end
            if target and newtarget and not target:IsDead() and target:GetFractionComplete() == 1
            and SUtils.XZDistanceTwoVectorsSq( target:GetPosition(), basePosition ) < T4Radius * T4Radius then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AttackTarget( target )
                patrolling = false
            elseif target and not target:IsDead() and SUtils.XZDistanceTwoVectorsSq( target:GetPosition(), basePosition ) < guardRadius * guardRadius then
                self:Stop()
                self:AggressiveMoveToLocation( target:GetPosition() )
                patrolling = false
            elseif not patrolling then
                local position = AIUtils.RandomLocation(basePosition[1],basePosition[3])
                self:MoveToLocation( position, false )
                for k,v in AIUtils.GetBasePatrolPoints(aiBrain, basePosition, radius, 'Air') do
                    self:Patrol(v)
                end
                patrolling = true
            end
        end
        WaitSeconds(5)
    end
end,



NavalHuntNC = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local target
    local blip
    local cmd = false
    local platoonUnits = self:GetPlatoonUnits()
    local PlatoonFormation = self.PlatoonData.UseFormation or 'NoFormation'
    self:SetPlatoonFormationOverride(PlatoonFormation)
    local atkPri = { 'SPECIALHIGHPRI', 'MOBILE NAVAL', 'COMMAND', 'STRUCTURE NAVAL', 'EXPERIMENTAL', 'STRUCTURE STRATEGIC EXPERIMENTAL', 'ARTILLERY EXPERIMENTAL', 'STRUCTURE ARTILLERY TECH3', 'STRUCTURE NUKE TECH3', 'STRUCTURE ANTIMISSILE SILO', 
                        'STRUCTURE DEFENSE DIRECTFIRE', 'TECH3 MASSFABRICATION', 'TECH3 ENERGYPRODUCTION', 'STRUCTURE STRATEGIC', 'STRUCTURE DEFENSE', 'STRUCTURE', 'MOBILE', 'SPECIALLOWPRI', 'ALLUNITS' }
    local atkPriTable = {}
    for k,v in atkPri do
        table.insert( atkPriTable, ParseEntityCategory( v ) )
    end
    self:SetPrioritizedTargetList( 'Attack', atkPriTable )
    local maxRadius = 6000
    for k,v in platoonUnits do

        if v:IsDead() then
            continue
        end
        
        if v:GetCurrentLayer() == 'Sub' then
            continue
        end
        
        if v:TestCommandCaps('RULEUCC_Dive') and v:GetUnitId() != 'uas0401' then
            IssueDive( {v} )
        end
    end
    WaitSeconds(5)
    while aiBrain:PlatoonExists(self) do
        if self:IsOpponentAIRunning() then
            target = AIUtils.AIFindBrainTargetInRangeSorian( aiBrain, self, 'Attack', maxRadius, atkPri)
            if target then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                cmd = self:AggressiveMoveToLocation(target:GetPosition())
            end
            WaitSeconds(1)
            if (not cmd or not self:IsCommandsActive( cmd )) then
                target = self:FindClosestUnit('Attack', 'Enemy', true, categories.ALLUNITS - categories.WALL)
                if target then
                    blip = target:GetBlip(armyIndex)
                    self:Stop()
                    cmd = self:AggressiveMoveToLocation(target:GetPosition())
                else
                    local scoutPath = {}
                    scoutPath = AIUtils.AIGetSortedNavalLocations(self:GetBrain())
                    for k, v in scoutPath do
                        self:Patrol(v)
                    end
                end
            end
        end
        WaitSeconds(17)
    end
end,

NukeNC = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local platoonUnits = self:GetPlatoonUnits()
    local unit
    --GET THE Launcher OUT OF THIS PLATOON
    for k, v in platoonUnits do
        if EntityCategoryContains(categories.SILO * categories.NUKE, v) then
            unit = v
            break
        end
    end

    if unit then
        local bp = unit:GetBlueprint()
        local weapon = bp.Weapon[1]
        local maxRadius = weapon.MaxRadius
        local nukePos, oldTargetLocation
        unit:SetAutoMode(true)
        while aiBrain:PlatoonExists(self) do
            while unit:GetNukeSiloAmmoCount() < 1 do
                WaitSeconds(11)
                if not  aiBrain:PlatoonExists(self) then
                    return
                end
            end

            nukePos = import('/lua/ai/aibehaviors.lua').GetHighestThreatClusterLocationNC(aiBrain, unit)
            if nukePos then
                IssueNuke({unit}, nukePos)
                WaitSeconds(12)
                IssueClearCommands({unit})
            end
            WaitSeconds(1)
        end
    end
    self:PlatoonDisband()
end,







LandAttackNC = function(self) ---modified for nutcracker
    
    AIAttackUtils.GetMostRestrictiveLayer(self) -- this will set self.MovementLayer to the platoon
    -- Search all platoon units and activate Stealth and Cloak (mostly Modded units)
    local platoonUnits = self:GetPlatoonUnits()
    local PlatoonStrength = table.getn(platoonUnits)
    local ExperimentalInPlatoon = false
    if platoonUnits and PlatoonStrength > 0 then
        for k, v in platoonUnits do
            if not v.Dead then
                if v:TestToggleCaps('RULEUTC_StealthToggle') then
                    v:SetScriptBit('RULEUTC_StealthToggle', false)
                end
                if v:TestToggleCaps('RULEUTC_CloakToggle') then
                    v:SetScriptBit('RULEUTC_CloakToggle', false)
                end
                if EntityCategoryContains(categories.EXPERIMENTAL, v) then
                    ExperimentalInPlatoon = true
                end
                -- prevent units from reclaiming while attack moving
                v:RemoveCommandCap('RULEUCC_Reclaim')
                v:RemoveCommandCap('RULEUCC_Repair')
            end
        end
    end
    local MoveToCategories = {}
    if self.PlatoonData.MoveToCategories then
        for k,v in self.PlatoonData.MoveToCategories do
            table.insert(MoveToCategories, v )
        end
    else
      
    end
    -- Set the target list to all platoon units
    local WeaponTargetCategories = {}
    if self.PlatoonData.WeaponTargetCategories then
        for k,v in self.PlatoonData.WeaponTargetCategories do
            table.insert(WeaponTargetCategories, v )
        end
    elseif self.PlatoonData.MoveToCategories then
        WeaponTargetCategories = MoveToCategories
    end
    self:SetPrioritizedTargetList('Attack', WeaponTargetCategories)
    local aiBrain = self:GetBrain()
    local target
    local bAggroMove = self.PlatoonData.AggressiveMove
    local WantsTransport = self.PlatoonData.RequireTransport
    local maxRadius = self.PlatoonData.SearchRadius
    local PlatoonPos = self:GetPlatoonPosition()
    local LastTargetPos = PlatoonPos
    local DistanceToTarget = 0
    local basePosition = aiBrain.BuilderManagers[self.PlatoonData.LocationType].Position
    local losttargetnum = 0
    local TargetSearchCategory = self.PlatoonData.TargetSearchCategory or 'ALLUNITS'
    while aiBrain:PlatoonExists(self) do
        PlatoonPos = self:GetPlatoonPosition()
        -- only get a new target and make a move command if the target is dead or after 10 seconds
        if not target or target.Dead then
            UnitWithPath, UnitNoPath, path, reason = AIUtils.AIFindNearestCategoryTargetInRangeNC(aiBrain, self, 'Attack', PlatoonPos, maxRadius, MoveToCategories, TargetSearchCategory, false )
            if UnitWithPath then
                losttargetnum = 0
                self:Stop()
                target = UnitWithPath
                LastTargetPos = table.copy(target:GetPosition())
                DistanceToTarget = VDist2(PlatoonPos[1] or 0, PlatoonPos[3] or 0, LastTargetPos[1] or 0, LastTargetPos[3] or 0)
                if DistanceToTarget > 70 then
                    -- if we have a path then use the waypoints
                    if self.PlatoonData.IgnorePathing then
                        self:Stop()
                        self:SetPlatoonFormationOverride('AttackFormation')
                        self:AttackTarget(UnitWithPath)
                    elseif path then
                        self:MoveToLocationInclTransport(target, LastTargetPos, bAggroMove, WantsTransport, basePosition, ExperimentalInPlatoon)
                    -- if we dont have a path, but UnitWithPath is true, then we have no map markers but PathCanTo() found a direct path
                    else
                        self:MoveDirect(aiBrain, bAggroMove, target)
                    end
                    -- We moved to the target, attack it now if its still exists
                    if aiBrain:PlatoonExists(self) and UnitWithPath and not UnitWithPath.Dead and not UnitWithPath:BeenDestroyed() then
                        self:Stop()
                        self:SetPlatoonFormationOverride('AttackFormation')
                        self:AttackTarget(UnitWithPath)
                    end
                end
            
            else
              
                losttargetnum = losttargetnum + 1
                if losttargetnum > 4 then
                    if not self.SuicideMode then
                        self.SuicideMode = true
                        self.PlatoonData.AttackEnemyStrength = 1000
                        self.PlatoonData.GetTargetsFromBase = false
                        self.PlatoonData.MoveToCategories = { categories.STRUCTURE }
                        self.PlatoonData.WeaponTargetCategories = { categories.LAND * categories.MOBILE }
                        self:Stop()
                        self:SetPlatoonFormationOverride('NoFormation')
                        self:LandAttackNC()
                  
                    end
                end
            end
        else
            if aiBrain:PlatoonExists(self) and target and not target.Dead and not target:BeenDestroyed() then
                LastTargetPos = target:GetPosition()
                -- check if the target is not in a nuke blast area
                if AIUtils.IsNukeBlastAreaNC(aiBrain, LastTargetPos) then
                    target = nil
                else
                    self:SetPlatoonFormationOverride('AttackFormation')
                    self:AttackTarget(target)
                end
                coroutine.yield(20)
            end
        end
        coroutine.yield(10)
    end
end,
   






----teleport activity







SACUTeleportAINC = function(self)
    LOG('*SACUTeleportAI: Start ')
    -- SACU need to move out of the gate first
    coroutine.yield(50)
    local aiBrain = self:GetBrain()
    local platoonUnits
    local platoonPosition = self:GetPlatoonPosition()
    local TargetPosition
    AIAttackUtils.GetMostRestrictiveLayer(self) -- this will set self.MovementLayer to the platoon
    -- start upgrading all SubCommanders as teleporter
  
    local MoveToCategories = {}
    if self.PlatoonData.MoveToCategories then
        for k,v in self.PlatoonData.MoveToCategories do
            table.insert(MoveToCategories, v )
        end
    else
        LOG('* SACUTeleportAI: MoveToCategories missing in platoon '..self.BuilderName)
    end
    local WeaponTargetCategories = {}
    if self.PlatoonData.WeaponTargetCategories then
        for k,v in self.PlatoonData.WeaponTargetCategories do
            table.insert(WeaponTargetCategories, v )
        end
    elseif self.PlatoonData.MoveToCategories then
        WeaponTargetCategories = MoveToCategories
    end
    self:SetPrioritizedTargetList('Attack', WeaponTargetCategories)
    local TargetSearchCategory = self.PlatoonData.TargetSearchCategory or 'ALLUNITS'
    local maxRadius = self.PlatoonData.SearchRadius or 100
    -- search for a target
    local Target
    while not Target do
        coroutine.yield(50)
        Target, _, _, _ = AIUtils.AIFindNearestCategoryTeleportLocationNC(aiBrain, platoonPosition, maxRadius, MoveToCategories, TargetSearchCategory, false)
    end
    platoonUnits = self:GetPlatoonUnits()
    if Target and not Target.Dead then
        TargetPosition = Target:GetPosition()
        for k, unit in platoonUnits do
            if not unit.Dead then
                if not unit:HasEnhancement('Teleporter') then
                    WARN('* SACUTeleportAI: Unit has no transport enhancement!')
                    continue
                end
                --IssueStop({unit})
                coroutine.yield(2)
                IssueTeleport({unit}, Weapcon.RandomizePositionNC(TargetPosition))
            end
        end
    else
        LOG('*SACUTeleportAI: No target, disbanding platoon!')
        self:PlatoonDisband()
        return
    end
    coroutine.yield(30)
    -- wait for the teleport of all unit
    local count = 0
    local UnitTeleporting = 0
    while aiBrain:PlatoonExists(self) do
        platoonUnits = self:GetPlatoonUnits()
        UnitTeleporting = 0
        for k, unit in platoonUnits do
            if not unit.Dead then
                if unit:IsUnitState('Teleporting') then
                    UnitTeleporting = UnitTeleporting + 1
                end
            end
        end
        LOG('*SACUTeleportAI: Units Teleporting :'..UnitTeleporting )
        if UnitTeleporting == 0 then
            break
        end
        coroutine.yield(10)
    end        
    -- Fight
    coroutine.yield(1)
    for k, unit in platoonUnits do
        if not unit.Dead then
            IssueStop({unit})
            coroutine.yield(2)
            IssueMove({unit}, TargetPosition)
        end
    end
    coroutine.yield(50)
    self:LandAttackAINC()
    if aiBrain:PlatoonExists(self) then
        self:PlatoonDisband()
    end
end,

LandAttackAINC = function(self)
    if UseHeroPlatoon then
        self:HeroFightPlatoon()
        return
    end
    AIAttackUtils.GetMostRestrictiveLayer(self) -- this will set self.MovementLayer to the platoon
    -- Search all platoon units and activate Stealth and Cloak (mostly Modded units)
    local platoonUnits = self:GetPlatoonUnits()
    local PlatoonStrength = table.getn(platoonUnits)
    local ExperimentalInPlatoon = false
    if platoonUnits and PlatoonStrength > 0 then
        for k, v in platoonUnits do
            if not v.Dead then
                if v:TestToggleCaps('RULEUTC_StealthToggle') then
                    v:SetScriptBit('RULEUTC_StealthToggle', false)
                end
                if v:TestToggleCaps('RULEUTC_CloakToggle') then
                    v:SetScriptBit('RULEUTC_CloakToggle', false)
                end
                if EntityCategoryContains(categories.EXPERIMENTAL, v) then
                    ExperimentalInPlatoon = true
                end
                -- prevent units from reclaiming while attack moving
                v:RemoveCommandCap('RULEUCC_Reclaim')
                v:RemoveCommandCap('RULEUCC_Repair')
            end
        end
    end
    local MoveToCategories = {}
    if self.PlatoonData.MoveToCategories then
        for k,v in self.PlatoonData.MoveToCategories do
            table.insert(MoveToCategories, v )
        end
    else
        
    end
    -- Set the target list to all platoon units
    local WeaponTargetCategories = {}
    if self.PlatoonData.WeaponTargetCategories then
        for k,v in self.PlatoonData.WeaponTargetCategories do
            table.insert(WeaponTargetCategories, v )
        end
    elseif self.PlatoonData.MoveToCategories then
        WeaponTargetCategories = MoveToCategories
    end
    self:SetPrioritizedTargetList('Attack', WeaponTargetCategories)
    local aiBrain = self:GetBrain()
    local target
    local bAggroMove = self.PlatoonData.AggressiveMove
    local WantsTransport = self.PlatoonData.RequireTransport
    local maxRadius = self.PlatoonData.SearchRadius
    local PlatoonPos = self:GetPlatoonPosition()
    local LastTargetPos = PlatoonPos
    local DistanceToTarget = 0
    local basePosition = aiBrain.BuilderManagers['MAIN'].Position
    local losttargetnum = 0
    local TargetSearchCategory = self.PlatoonData.TargetSearchCategory or 'ALLUNITS'
    while aiBrain:PlatoonExists(self) do
        PlatoonPos = self:GetPlatoonPosition()
        -- only get a new target and make a move command if the target is dead or after 10 seconds
        if not target or target.Dead then
            UnitWithPath, UnitNoPath, path, reason = AIUtils.AIFindNearestCategoryTargetInRangeNC(aiBrain, self, 'Attack', PlatoonPos, maxRadius, MoveToCategories, TargetSearchCategory, false )
            if UnitWithPath then
                losttargetnum = 0
                self:Stop()
                target = UnitWithPath
                LastTargetPos = table.copy(target:GetPosition())
                DistanceToTarget = VDist2(PlatoonPos[1] or 0, PlatoonPos[3] or 0, LastTargetPos[1] or 0, LastTargetPos[3] or 0)
                if DistanceToTarget > 30 then
                    -- if we have a path then use the waypoints
                    if self.PlatoonData.IgnorePathing then
                        self:Stop()
                        self:SetPlatoonFormationOverride('AttackFormation')
                        self:AttackTarget(UnitWithPath)
                    elseif path then
                        self:MoveToLocationInclTransport(target, LastTargetPos, bAggroMove, WantsTransport, basePosition, ExperimentalInPlatoon)
                    -- if we dont have a path, but UnitWithPath is true, then we have no map markers but PathCanTo() found a direct path
                    else
                        self:MoveDirect(aiBrain, bAggroMove, target)
                    end
                    -- We moved to the target, attack it now if its still exists
                    if aiBrain:PlatoonExists(self) and UnitWithPath and not UnitWithPath.Dead and not UnitWithPath:BeenDestroyed() then
                        self:Stop()
                        self:SetPlatoonFormationOverride('AttackFormation')
                        self:AttackTarget(UnitWithPath)
                    end
                end
            elseif UnitNoPath then
                losttargetnum = 0
                self:Stop()
                target = UnitNoPath
                self:MoveWithTransport(aiBrain, bAggroMove, target, basePosition, ExperimentalInPlatoon)
                -- We moved to the target, attack it now if its still exists
                if aiBrain:PlatoonExists(self) and UnitNoPath and not UnitNoPath.Dead and not UnitNoPath:BeenDestroyed() then
                    self:SetPlatoonFormationOverride('AttackFormation')
                    self:AttackTarget(UnitNoPath)
                end
            else
                -- we have no target return to main base
                losttargetnum = losttargetnum + 1
                if losttargetnum > 2 then
                    if not self.SuicideMode then
                        self.SuicideMode = true
                        self.PlatoonData.AttackEnemyStrength = 1000
                        self.PlatoonData.GetTargetsFromBase = false
                        self.PlatoonData.MoveToCategories = { categories.EXPERIMENTAL, categories.TECH3, categories.TECH2, categories.ALLUNITS }
                        self.PlatoonData.WeaponTargetCategories = { categories.EXPERIMENTAL, categories.TECH3, categories.TECH2, categories.ALLUNITS }
                        self:Stop()
                        self:SetPlatoonFormationOverride('NoFormation')
                        self:LandAttackAIUvesoNC()
                 
                    end
                end
            end
        else
            if aiBrain:PlatoonExists(self) and target and not target.Dead and not target:BeenDestroyed() then
                LastTargetPos = target:GetPosition()
                -- check if the target is not in a nuke blast area
                if AIUtils.IsNukeBlastAreaNC(aiBrain, LastTargetPos) then
                    target = nil
                else
                    self:SetPlatoonFormationOverride('AttackFormation')
                    self:AttackTarget(target)
                end
                coroutine.yield(20)
            end
        end
        coroutine.yield(10)
    end
end,

EnhanceAINC = function(self)
    local aiBrain = self:GetBrain()
    local unit
    local data = self.PlatoonData
    local lastEnhancement
    local numLoop = 0
    for k,v in self:GetPlatoonUnits() do
        unit = v
        break
    end
    if unit then
        IssueStop({unit})
        IssueClearCommands({unit})
        for k,v in data.Enhancement do
            if not unit:HasEnhancement(v) then
                local order = {
                    TaskName = "EnhanceTask",
                    Enhancement = v
                }
                --LOG('*AI DEBUG: '..aiBrain.Nickname..' EnhanceAI Added Enhancement: '..v)
                IssueScript({unit}, order)
                lastEnhancement = v
            end
        end
        WaitSeconds(data.TimeBetweenEnhancements or 1)
        repeat
            WaitSeconds(5)
            local enhance = import('/lua/enhancementcommon.lua')
            local curUnitId = unit:GetEntityId()
            local curUnitEnhancements = enhance.GetEnhancements(curUnitId)
            LOG('Current Enhancements '..repr(curUnitEnhancements))
            LOG('*AI DEBUG: '..aiBrain.Nickname..' Com still upgrading ')
         until unit.Dead or unit:HasEnhancement(lastEnhancement)
        --LOG('*AI DEBUG: '..aiBrain.Nickname..' Com finished upgrading ')
    end
    self:PlatoonDisband()
end,

AirAttackNC = function(self)
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local data = self.PlatoonData
    local categoryList = {}
    local atkPri = {}
    if data.PrioritizedCategories then
        for k,v in data.PrioritizedCategories do
            table.insert(atkPri, v)
            table.insert(categoryList, ParseEntityCategory(v))
        end
    end
   
    
    self:SetPrioritizedTargetList('Attack', categoryList)
    local target = false
    local oldTarget = false
    local blip = false
    local maxRadius = data.SearchRadius or 50
    local movingToScout = false
    AIAttackUtils.GetMostRestrictiveLayer(self)
    while aiBrain:PlatoonExists(self) do
        if target then
            local targetCheck = true
            for k,v in atkPri do
                local category = ParseEntityCategory(v)
                if EntityCategoryContains(category, target) and v != 'ALLUNITS' then
                    targetCheck = false
                    break
                end
            end
            if targetCheck then
                target = false
                oldTarget = false
            end
        end
        if not target or target.Dead or not target:GetPosition() then
            if aiBrain:GetCurrentEnemy() and aiBrain:GetCurrentEnemy().Result == "defeat" then
                aiBrain:PickEnemyLogicSorian()
            end
            --local mult = { 1,10,25 }
            --for _,i in mult do
                target = AIUtils.AIFindBrainTargetInRange(aiBrain, self, 'Attack', maxRadius * 25, atkPri, aiBrain:GetCurrentEnemy())
            --    if target then
            --        break
            --    end
            --    WaitSeconds(3)
            --    if not aiBrain:PlatoonExists(self) then
            --        return
            --    end
            --end
            local newtarget = false
            if AIAttackUtils.GetSurfaceThreatOfUnits(self) > 0 and (aiBrain.T4ThreatFound['Land'] or aiBrain.T4ThreatFound['Naval'] or aiBrain.T4ThreatFound['Structure']) then
                newtarget = self:FindClosestUnit('Attack', 'Enemy', true, categories.EXPERIMENTAL * (categories.LAND + categories.NAVAL + categories.STRUCTURE + categories.ARTILLERY))
           
            end
            if newtarget then
                target = newtarget
            end
            if target and (target != oldTarget or movingToScout) then
                oldTarget = target
                local path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, self.MovementLayer, self:GetPlatoonPosition(), target:GetPosition(), 10)
                self:Stop()
                if not path then
                    if reason == 'NoStartNode' or reason == 'NoEndNode' then
                        if not data.UseMoveOrder then
                            self:AttackTarget(target)
                        else
                            self:MoveToLocation(table.copy(target:GetPosition()), false)
                        end
                    end
                else
                    local pathSize = table.getn(path)
                    for wpidx,waypointPath in path do
                        if wpidx == pathSize and not data.UseMoveOrder then
                            self:AttackTarget(target)
                        else
                            self:MoveToLocation(waypointPath, false)
                        end
                    end
                end
                movingToScout = false
            elseif not movingToScout and not target and self.MovementLayer != 'Water' then
                movingToScout = true
                self:Stop()
                local MassSpots = AIUtils.AIGetSortedMassLocations(aiBrain, 10, nil, nil, nil, nil, self:GetPlatoonPosition())
                if table.getn(MassSpots) > 0 then
                    for k,v in MassSpots do
                        self:MoveToLocation(v, false)
                    end
                else
                    local x,z = aiBrain:GetArmyStartPos()
                    local position = AIUtils.RandomLocation(x,z)
                    local safePath, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Air', self:GetPlatoonPosition(), position, 200)
                    if safePath then
                        for _,p in safePath do
                            self:MoveToLocation(p, false)
                        end
                    else
                        self:MoveToLocation(position, false)
                    end
                end
            elseif not movingToScout and not target and self.MovementLayer == 'Water' then
                movingToScout = true
                self:Stop()
                local scoutPath = {}
                scoutPath = AIUtils.AIGetSortedNavalLocations(self:GetBrain())
                for k, v in scoutPath do
                    self:Patrol(v)
                end
            end
        end
        if self.MovementLayer == 'Air' then
            local waitLoop = 0
            repeat
                WaitSeconds(1)
                waitLoop = waitLoop + 1
            until waitLoop >= 7 or (target and (target.Dead or not target:GetPosition()))
        else
            WaitSeconds(7)
        end
    end
end,

}