function pythagorean_triplets(N)
    triplets = Tuple{Int, Int, Int}[]
    N & 1 == 1 && return triplets
    n = N÷2
    m = 2
    while m*m < n
        for k in 1:m-1
            if ((m - k)%2 == 1) && (gcd(m, k) == 1) && (n % (m*(m + k))) == 0
                s = n÷(m*(m + k))
                a, b, c = s*(m*m - k*k), 2*s*m*k, s*(m*m + k*k)
                a > b && ((a, b) = (b, a))
                pushfirst!(triplets, (a, b, c))
            end
        end
        m += 1
    end
    sort!(triplets, by=first)
    triplets
end