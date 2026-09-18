function on_square(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    UInt64(1) << (square - 1)
end

function total_after(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    UInt64(1) << square - 1
end