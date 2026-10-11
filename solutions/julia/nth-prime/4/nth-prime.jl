function prime(num)
    num < 1 && error("No such prime!")
    flag, candidate, primes = true, 3, [2]
    while length(primes) < num
        any((candidate .% primes[primes .<= isqrt(candidate)]) .== 0) && (flag = false)
        flag && push!(primes, candidate)
        flag = true; candidate += 2
    end
    primes[num]
end