function prime(num)
    num < 1 && error("No such prime!")
    flag, idx, candidate, primes = true, 2, 3, [2]
    while idx <= num
        any((candidate .% primes[primes .<= isqrt(candidate)]) .== 0) && (flag = false)
        if flag; push!(primes, candidate); idx += 1; end
        flag = true; candidate += 2
    end
    primes[num]
end