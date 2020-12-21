


function CoinFlipAirExperimental(aiBrain, numReq)
    if not aiBrain.CoinFlip then
        local ran = math.random(50)
        aiBrain.CoinFlip = ran
        LOG('Coinflip random number generated, number is '..aiBrain.CoinFlip)
    end
    if aiBrain.CoinFlip == numReq then
        LOG('CoinFlip is true, brain is '..aiBrain.CoinFlip)
        return true
  

    

    else
        LOG('CoinFlip is false, brain is '..aiBrain.CoinFlip)
        return false
    end
end




