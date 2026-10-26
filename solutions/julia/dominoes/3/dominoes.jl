function dominoes(stones::Vector{Vector{Int}})
    isempty(stones) && return true
    (start, next) = pop!(stones)
    
    function check(stones, next)
        isempty(stones) && return start == next

        for (i, domino) in enumerate(stones)
            if next in domino
                check(stones[eachindex(stones) .!= i], domino[domino[1] == next ? 2 : 1]) && return true
            end
        end
        false
    end
    
    return check(stones, next)        
end