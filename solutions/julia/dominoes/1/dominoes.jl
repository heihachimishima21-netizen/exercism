function dominoes(stones::Vector{Vector{Int}})
    (start, next) = pop!(stones)
    
    function check(stones, next)
        if isempty(stones)
            (start == next) ? (return true) : (return false)
        end

        for (i, domino) in enumerate(stones)
            if next in domino
                new_next = domino[domino[1] == next ? 2 : 1]
                (check(stones[eachindex(stones) .!= i], new_next)) ? (return true) : continue
            end
        end
        false
    end
    
    return check(stones, next)        
end

dominoes(stones::Union{Vector{Any}, Vector{Int}}) = isempty(stones) || stones[begin] == stones[end] ? true : false