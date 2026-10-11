function prime(num)
    num < 1 && error("No such prime!")
    flag, idx, candidate, primes = true, 2, 3, [2]
    while idx <= num
        squ, j = isqrt(candidate), 1
        while j < idx && primes[j] <= squ
            if candidate % primes[j] == 0
                flag = false
                break
            end
            j += 1
        end
        if flag; push!(primes, candidate); idx += 1; end
        flag = true
        candidate += 2
    end
    primes[num]
end