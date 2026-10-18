function change(coins, target)
    target < 0 && throw(DomainError(""))
    valarr, statearr = fill(typemax(Int), target + 1), [Int[] for _ in 1:(target + 1)]
    valarr[1] = 0
    for i in 1:target
        coin = nothing
        for c in coins
            if i >= c && valarr[(i-c)+1] != typemax(Int) && 1 + valarr[(i-c)+1] < valarr[(i)+1]
                valarr[(i)+1] = 1 + valarr[(i-c)+1]
                coin = c
             end
        end
        !isnothing(coin) && (statearr[(i)+1] = [statearr[(i-coin)+1]; coin])
    end
    valarr[target + 1] == typemax(Int) && throw(DomainError(""))
    sort!(statearr[target + 1])    
end