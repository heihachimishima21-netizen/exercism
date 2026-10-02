aliquot(n) = n < 1 ? throw(DomainError("")) : sum(f for f in 1:(n-1) if n%f == 0)

isperfect(n) = aliquot(n) == n
isabundant(n) = aliquot(n) > n
isdeficient(n) = aliquot(n) < n