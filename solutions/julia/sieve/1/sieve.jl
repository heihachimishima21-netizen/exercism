function sieve(limit)
    numbers = collect(1:limit)
    boolean = fill(true, limit)
    boolean[1], i = false, 1
    while i < limit
        i += 1
        if boolean[i] == false; continue; end
        for multiple in 2i:i:limit
            boolean[multiple] = false
        end
    end
    numbers[boolean]
end