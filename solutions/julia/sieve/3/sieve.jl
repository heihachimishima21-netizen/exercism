function sieve(limit)
    numbers = collect(1:limit)
    boolean = fill(true, limit)
    boolean[1], limit_sqrt = false, isqrt(limit)
    for i=2:limit_sqrt
        if boolean[i] == false; continue; end
        boolean[i^2:i:limit] .= false
    end
    numbers[boolean]
end