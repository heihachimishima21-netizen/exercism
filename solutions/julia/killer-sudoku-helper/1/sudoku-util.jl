function  combinations_in_cage(total, numsquares, restricted=nothing)
    perms, current = Vector{Vector{Int}}(), Vector{Int}()
    function recur(start)
        if length(current) == numsquares
            sum(current) == total && push!(perms, copy(current))
            return
        end
        for i in start:9
            push!(current, i)
            recur(i+1)
            pop!(current)
        end
    end
    recur(1)
    perms =[perm for perm in perms if restricted==nothing || all(x -> isempty(perm ∩ x), restricted)]
end