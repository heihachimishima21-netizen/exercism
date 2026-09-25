function triangle(n)
    if n < 0; throw(DomainError("")); end
    [[binomial(m - 1, k) for k in 0:(m-1)] for m in 1:n]
end