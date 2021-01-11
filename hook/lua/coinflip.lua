


function StrategyRandomizer(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(60)
        aiBrain.CoinFlip = ran
      
    end
    if aiBrain.CoinFlip == numReq then
 
        return true

    else
      
        return false
    end
end

function NoSateliteRush(aiBrain)
    
    if aiBrain.StrategyRandomizer != 11 then
    
    return true
else
    LOG('!!!!!!there is a satelite strategy running!!!!') 
    return false
end
end

function NoDukeNukem(aiBrain)
    
    if aiBrain.StrategyRandomizer != 12 then
    
    return true
else
    LOG('!!!!!!there is a Duke Nukem strategy running!!!!') 
    return false
end
end









