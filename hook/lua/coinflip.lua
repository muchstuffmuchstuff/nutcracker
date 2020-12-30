


function StrategyRandomizer(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(1)
        aiBrain.CoinFlip = ran
      
    end
    if aiBrain.CoinFlip == numReq then
 
        return true
  

    

    else
      
        return false
    end
end

function NoRandomStrategyRunning(aiBrain)
    if aiBrain.StrategyRandomizer > 9 then
      
    return true
else

    return false
end
end

function NoTeleRandomStrategyRunning(aiBrain)
    if aiBrain.StrategyRandomizer > 1 then
      LOG('NO TELE STRATEGY RUNNING')
    return true
else
   
    return false
end
end

function notrambo(aiBrain)
    if aiBrain.StrategyRandomizer > 1 then
        LOG('NOT RAMBO')
      return true
  else
     
      return false
  end
  end




