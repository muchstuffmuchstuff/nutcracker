

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

AirHuntAIANTINAVY = function(self)
    self:Stop()
    local aiBrain = self:GetBrain()
    local armyIndex = aiBrain:GetArmyIndex()
    local location = self.PlatoonData.LocationType or 'MAIN'
local radius = self.PlatoonData.Radius or 400
    local target
    local blip
    local hadtarget = false
    local atkPri = {'NAVAL', 'ALLUNITS'}
    while aiBrain:PlatoonExists(self) do
        if self:IsOpponentAIRunning() then
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.ALLUNITS - categories.WALL)
            local newtarget = false
            if aiBrain.T4ThreatFound['Land'] or aiBrain.T4ThreatFound['Naval'] or aiBrain.T4ThreatFound['Structure'] then
                newtarget = self:FindClosestUnit('Attack', 'Enemy', true, categories.EXPERIMENTAL * (categories.LAND + categories.NAVAL + categories.STRUCTURE + categories.ARTILLERY))
                if newtarget then
                    target = newtarget
                end
            elseif table.getn(aiBrain.AirAttackPoints) > 0 then
                newtarget = AIUtils.AIFindAirAttackTargetInRangeSorian( aiBrain, self, 'Attack', atkPri, self.AirAttackPoints[1].Position )
                if newtarget then
                    target = newtarget
                end
            end
            if target and newtarget then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AttackTarget( target )
                hadtarget = true
            elseif target then
                blip = target:GetBlip(armyIndex)
                self:Stop()
                self:AggressiveMoveToLocation( table.copy(target:GetPosition()) )
                hadtarget = true
            elseif not target and hadtarget then
                local x,z = aiBrain:GetArmyStartPos()
                local position = AIUtils.RandomLocation(x,z)
                local safePath, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Air', self:GetPlatoonPosition(), position, 200)
                if safePath then
                    for _,p in safePath do
                        self:MoveToLocation( p, false )
                    end
                else
                    self:MoveToLocation( position, false )
                end
                hadtarget = false
            end
        end
        local waitLoop = 0
        repeat
            WaitSeconds(1)
            waitLoop = waitLoop + 1
        until waitLoop >= 17 or (target and (target:IsDead() or not target:GetPosition()))
        if aiBrain:PlatoonExists(self) and AIAttackUtils.GetSurfaceThreatOfUnits(self) <= 0 then
            return self:FighterHuntAI()
        end				
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
            target = self:FindClosestUnit('Attack', 'Enemy', true, categories.AIR - categories.POD)
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
                hadtarget = false
                return self:GuardExperimentalSorian(self.FighterHuntNC)
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

function IsIsland(aiBrain, check)

    if not aiBrain.islandCheck then
        local startX, startZ = aiBrain:GetArmyStartPos()
        aiBrain.isIsland = false
        aiBrain.islandMarker = AIUtils.AIGetClosestMarkerLocation(aiBrain, 'Island', startX, startZ)
        aiBrain.islandCheck = true
        if aiBrain.islandMarker then
            aiBrain.isIsland = true
        end
    end

    if check == aiBrain.isIsland then
        return true
    else
        return false
    end
end