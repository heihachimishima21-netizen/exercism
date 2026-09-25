function triangle(n)
    if n < 0; throw(DomainError("")); end
    if n == 0; return []; end
    row = [binomial(n - 1, k) for k in 0:(n-1)]
    push!(triangle(n - 1), row)
end