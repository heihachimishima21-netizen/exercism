function prime(num)
    num < 1 && error("No such prime!")
    flag, idx, candidate, primes = true, 1, 2, Vector{UInt32}()
    while idx <= num
        squ = isqrt(candidate)
        j = 1
        while j < idx && primes[j] <= squ
            if candidate % primes[j] == 0
                flag = false
                break
            end
            j += 1
        end
        if flag; push!(primes, candidate); idx += 1; end
        flag = true
        candidate += 1
    end
    primes[num]
end