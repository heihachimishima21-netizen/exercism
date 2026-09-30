function prime_factors(n)
    factors = []
    low = 2
    while n != 1
        for j in low:n
            if n%j == 0
                push!(factors, j)
                low = j
                n /= j
                break
            end
        end
    end
    factors
end