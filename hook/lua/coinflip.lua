 ---muchstuff

---nutcracker


function CoinFlip(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(60)
        aiBrain.CoinFlip = ran
        --LOG('Coinflip random number generated, number is '..aiBrain.CoinFlip)
    end
    if aiBrain.CoinFlip == numReq then
 
        return true

    else
      
        return false
    end
end

function CoinFlip2(aiBrain, numReq)
    if not aiBrain.CoinFlip2 then
        local ran = math.random(85)
        aiBrain.CoinFlip2 = ran
        --LOG('Coinflip2 random number generated, number is '..aiBrain.CoinFlip2)
    end
    if aiBrain.CoinFlip2 == numReq then
 
        return true

    else
      
        return false
    end
end

function RamboStrategyActivated(aiBrain)
    
    if aiBrain.CoinFlip == 19 then
    --LOG('Rambo Activated!!!!')
    return true
else
    
    return false
end
end

function EarlyAttackAuthorized(aiBrain)
    
    if aiBrain.CoinFlip != 1 and aiBrain.CoinFlip != 22 and aiBrain.CoinFlip != 19 then

    --LOG('early attack authorized!!!!')
    return true
else
    
    return false
end
end


function TeleportStrategyActivated(aiBrain)
    
    if aiBrain.CoinFlip == 21 or aiBrain.CoinFlip == 22 then
    --LOG('mass teleport Activated!!!!')
    return true
else
    
    return false
end
end

function TeleportStrategyNotRunning(aiBrain)
    
    if aiBrain.CoinFlip != 21 or not aiBrain.CoinFlip != 22  then
    --LOG('mass teleport not running!!!!')
    return true
else
    
    return false
end
end

function SeaMonsterActivated(aiBrain)
    
    if aiBrain.CoinFlip >= 23 and aiBrain.CoinFlip <=24 then
    --LOG('Sea Monster Activated!!!!')
    return true
else
    
    return false
end
end

function ExpClearedtoBuild(aiBrain)
    if aiBrain.CoinFlip != 26 then
        --LOG('exp cleared to build!!!!')
        return true
    else
        --LOG('exp not cleared to build!!!!')
        return false
    end
    end


function NukeClearedtoBuild(aiBrain)
if aiBrain.CoinFlip >= 37 or aiBrain.CoinFlip <= 34 then
    --LOG('nuke cleared to build!!!!')
    return true
else
    --LOG('nukes not cleared to build!!!!')
    return false
end
end

function NukeandExperimentalClearedtoBuild(aiBrain)
    if aiBrain.CoinFlip !=27 then
        --LOG('nuke and exp cleared to build!!!!')
        return true
    else
        --LOG('nuke and exp NOT cleared to build!!!!')
        return false
    end
    end

function DukeNukemEnabled(aiBrain)
    
    if aiBrain.CoinFlip >= 55 then
    --LOG('Duke Nukem!!!!')
    return true
else
    
    return false
end
end

function NoDukeNukem(aiBrain)
    
    if aiBrain.CoinFlip <=54 then
        
    return true
else
   
    return false
end
end


function NoSateliteRush(aiBrain)
    
    if aiBrain.CoinFlip != 11 then
        
    return true
else
    --LOG('Satelite rush!')
    return false
end
end



function NoRapidFireRush(aiBrain)
    
    if aiBrain.CoinFlip != 15 then
        
    return true
else
   --LOG('rapid fire arty is a go!')
    return false
end
end

function Noparagonrush(aiBrain)
    
    if aiBrain.CoinFlip != 13 then
        
    return true
else
   --LOG('About to get juicy! Paragon rush underway')
    return false
end
end

function NukeRush(aiBrain)
    
    if aiBrain.CoinFlip >= 47 and aiBrain.CoinFlip <= 49 then
    --LOG('nuke rush, hold onto ur hats!')    
    return true
else
   
    return false
end
end

function NoNukeRush(aiBrain)
    
    if aiBrain.CoinFlip < 47 or aiBrain.CoinFlip > 50 then
        
    return true
else
   
    return false
end
end


function Standardlandpush(aiBrain)
    if aiBrain.CoinFlip2 >= 0 and aiBrain.CoinFlip2 <= 20 then
    --LOG('standard push!!!!')    
    return true
else
    return false
end
end

function Standardlandpushstartlate1(aiBrain) 
    if aiBrain.CoinFlip2 >=21 and aiBrain.CoinFlip2 <= 30  then
        --LOG('standard push late 1!!!!')    
    return true
else
    return false
end
end

function Standardlandpushstartlate2(aiBrain) 
    if aiBrain.CoinFlip2 >=31 and aiBrain.CoinFlip2 <= 40  then
        --LOG('standard push late 2!!!!')
    return true
else
    return false
end
end

function Standardlandpushstartlate3(aiBrain)
    
    if aiBrain.CoinFlip2 >= 41 and aiBrain.CoinFlip2 <= 50 then
        --LOG('standard push late 3!!!!')
    return true
else
    return false
end
end

function Standardlandpushlimittime(aiBrain)
    
    if aiBrain.CoinFlip2 >= 51 and aiBrain.CoinFlip2 <= 60 then
        --LOG('standard push late 3!!!!')
    return true
else
    return false
end
end

function AirExpRandomizer(aiBrain, numReq)
    if not aiBrain.AirExpRandomizer then
        local ran = math.random(4)
        aiBrain.AirExpRandomizer = ran
        --LOG('AirExpRandomizer random number generated, number is '..aiBrain.AirExpRandomizer)
    end
    if aiBrain.AirExpRandomizer == numReq then
 
        return true

    else
      
        return false
    end
end

function bomberandgroundattackrandomizer(aiBrain, numReq)
    if not aiBrain.bomberandgroundattackrandomizer then
        local ran = math.random(20)
        aiBrain.bomberandgroundattackrandomizer = ran
        --LOG('bomberandgroundattackrandomizer random number generated, number is '..aiBrain.bomberandgroundattackrandomizer)
    end
    if aiBrain.bomberandgroundattackrandomizer == numReq then
 
        return true

    else
      
        return false
    end
end

function bomberallowed(aiBrain)
    
    if aiBrain.bomberandgroundattackrandomizer != 1  then
        
    return true
else
    --LOG('bombers not cleared for takeoff!')
    return false
end
end

function gunshipallowed(aiBrain)
    
    if aiBrain.bomberandgroundattackrandomizer != 2  then
        
    return true
else
    --LOG('gunships not cleared for takeoff!')
    return false
end
end






















