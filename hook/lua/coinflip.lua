


function CoinFlipAirExperimental(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(50)
        aiBrain.CoinFlip = ran
      
    end
    if aiBrain.CoinFlip == numReq then
      
        return true
  

    

    else
      
        return false
    end
end




