


function CoinFlip(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(60)
        aiBrain.CoinFlip = ran
        LOG('Coinflip random number generated, number is '..aiBrain.CoinFlip)
    end
    if aiBrain.CoinFlip == numReq then
 
        return true

    else
      
        return false
    end
end

function SeaMonsterActivated(aiBrain)
    
    if aiBrain.CoinFlip >= 22 and aiBrain.CoinFlip <=24 then
    --LOG('Sea Monster Activated!!!!')
    return true
else
    
    return false
end
end





function NoTeleportActivated(aiBrain)
    
    if aiBrain.CoinFlip >= 2 then
    --LOG('No teleport Activated!!!!')
    return true
else
    
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
    
    return false
end
end



function NoRapidFireRush(aiBrain)
    
    if aiBrain.CoinFlip != 15 then
        
    return true
else
   
    return false
end
end

function Noparagonrush(aiBrain)
    
    if aiBrain.CoinFlip != 13 then
        
    return true
else
   
    return false
end
end

function NoNukeRush(aiBrain)
    
    if aiBrain.CoinFlip != 47 then
        
    return true
else
   
    return false
end
end


function Standardlandpush(aiBrain)
    if aiBrain.CoinFlip >= 0 and aiBrain.CoinFlip <= 10 then
    --LOG('standard push!!!!')    
    return true
else
    return false
end
end

function Standardlandpushstartlate1(aiBrain) 
    if aiBrain.CoinFlip >=11 and aiBrain.CoinFlip <= 21  then
        --LOG('standard push late 1!!!!')    
    return true
else
    return false
end
end

function Standardlandpushstartlate2(aiBrain) 
    if aiBrain.CoinFlip >=22 and aiBrain.CoinFlip <= 30  then
        --LOG('standard push late 2!!!!')
    return true
else
    return false
end
end

function Standardlandpushstartlate3(aiBrain)
    
    if aiBrain.CoinFlip >= 31 and aiBrain.CoinFlip <= 37 then
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
        LOG('AirExpRandomizer random number generated, number is '..aiBrain.AirExpRandomizer)
    end
    if aiBrain.AirExpRandomizer == numReq then
 
        return true

    else
      
        return false
    end
end




















