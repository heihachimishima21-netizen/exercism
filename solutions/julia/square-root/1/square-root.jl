function square_root(n)
    if n < 0
        throw(DomainError(n))
    end
    a = n÷2 > 0 ? n÷2 : 1
    b = 0
    while a != b
        b = a
        a = (a + n÷a) ÷ 2
    end
    a
end