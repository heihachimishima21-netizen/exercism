mutable struct CircularBuffer{T}
    buffer::Vector{T}
    unread::Int
    next::Int
    capacity::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        capacity < 1 && throw(DomainError(""))
        buffer = Vector{T}(undef, capacity)
        new(buffer, -1, 1, capacity)
    end
end

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    overwrite ? cb.unread == cb.next && (cb.unread = 1 + mod(cb.unread, cb.capacity)) : cb.unread == cb.next && throw(BoundsError(cb))
    cb.buffer[cb.next] = item
    cb.unread == -1 && (cb.unread = cb.next)
    cb.next = 1 + mod(cb.next, cb.capacity)
    cb
end

function Base.popfirst!(cb::CircularBuffer)
    cb.unread == -1 && throw(BoundsError(cb))
    pop = cb.buffer[cb.unread]
    cb.unread = 1 + mod(cb.unread, cb.capacity)
    cb.unread == cb.next && (cb.unread = -1)
    pop
end

function Base.empty!(cb::CircularBuffer)
    cb.unread = -1
    cb.next = 1
    cb
end