function on_square(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    UInt64(2)^(square - 1)
end

function total_after(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    (square < 64) ? UInt64(2)^square - 1 : typemax(UInt64)
end