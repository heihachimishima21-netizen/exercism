function on_square(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    big(1) << (square - 1)
end

function total_after(square)
    if !(1 <= square <= 64)
        throw(DomainError(square))
    end
    (on_square(square) << 1) - 1
end