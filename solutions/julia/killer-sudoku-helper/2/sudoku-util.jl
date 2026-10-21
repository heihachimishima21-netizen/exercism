function  combinations_in_cage(total, numsquares, restricted=nothing)
    perms, current = Vector{Vector{Int}}(), Vector{Int}()
    numbers = isnothing(restricted) ? collect(1:9) : setdiff(1:9, restricted); range = length(numbers)
    function recur(start)
        if length(current) == numsquares
            sum(current) == total && push!(perms, copy(current))
            return
        end
        for i in start:range
            push!(current, numbers[i])
            recur(i+1)
            pop!(current)
        end
    end
    recur(1)
    perms
end