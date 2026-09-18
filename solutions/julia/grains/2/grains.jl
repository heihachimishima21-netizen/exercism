function on_square(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    BigInt(2)^(square - 1)
end

function total_after(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    2 * on_square(square) - 1
end