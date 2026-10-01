function sum_of_multiples(limit, factors)
    multiples = Set(0)
    for factor in factors
        if iszero(factor); continue; end
        multiples = multiples ∪ Set(factor:factor:(limit - 1))
    end
    sum(multiples)
end