


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

function AlteredAirExpPriority(aiBrain)
    
    if aiBrain.CoinFlip < 25 then
        
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

function AirExperimentalRandomizer(aiBrain, numReq)
    if not aiBrain.AirExperimentalRandomizer then
        local ran = math.random(5)
        aiBrain.AirExperimentalRandomizer = ran
        LOG('airexperimentalrandomizer random number generated, number is '..aiBrain.AirExperimentalRandomizer)
    end
    if aiBrain.AirExperimentalRandomizer == numReq then
 
        return true

    else
      
        return false
    end
end

function AirExpRegular(aiBrain) 
    if aiBrain.CoinFlip >= 2 and aiBrain.CoinFlip <= 11 then
        LOG('AIR exp attacking commander!!!!')    
    return true
else
    return false
end
end

function AirExpLandMobileFocus(aiBrain) 
    if aiBrain.AirExperimentalRandomizer >= 2 and aiBrain.AirExperimentalRandomizer < 3  then
        LOG('AIR exp attacking mobile land!!!')
    return true
else
    return false
end
end

function AirExpMexFocus(aiBrain)
    if aiBrain.AirExperimentalRandomizer >= 3 and aiBrain.AirExperimentalRandomizer < 4 then
        LOG('AIR exp attacking mex!!!')
    return true
else
    return false
end
end

function AirExpEnergyFocus(aiBrain)
    if aiBrain.AirExperimentalRandomizer >= 4 and aiBrain.AirExperimentalRandomizer < 5 then
        LOG('AIR exp attacking energy!!!')
    return true
else
    return false
end
end

function AirExpAntiNukeFocus(aiBrain)
    if aiBrain.AirExperimentalRandomizer >= 5 and aiBrain.AirExperimentalRandomizer < 6 then
        LOG('AIR exp attacking antinuke!!!')
    return true
else
    return false
end
end
















