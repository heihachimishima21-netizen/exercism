function collatz_steps(n)
    n < 1 && throw(DomainError(n))
    steps = 0
    while n != 1
        n = (n&1 == 0) ? n >> 1 : 3n + 1
        steps += 1
    end
    steps
end