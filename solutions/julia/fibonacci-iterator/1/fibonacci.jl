struct Fiberator; n::Int; end

function Base.iterate(F::Fiberator, state=(0, 0, 1))
    prev, curr, index = state
    if index <= F.n
        next = curr == 0 ? 1 : prev + curr
        state = (curr, next, index + 1)
        return (next, state)
    else
        return nothing
    end
end

Base.length(F::Fiberator) = F.n

Base.eltype(::Type{Fiberator}) = Int