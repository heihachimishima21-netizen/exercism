enable_bonus_tests = true

mutable struct CircularBuffer{T} <: AbstractVector{T}
    buffer::Vector{T}
    unread::Int
    next::Int
    capacity::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        capacity < 1 && throw(DomainError(""))
        buffer = Vector{T}(undef, capacity)
        new(buffer, 0, 1, capacity)
    end
end

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    overwrite ? cb.unread == cb.next && (cb.unread = 1 + mod(cb.unread, cb.capacity)) : cb.unread == cb.next && throw(BoundsError(cb))
    cb.buffer[cb.next] = item
    cb.unread == 0 && (cb.unread = cb.next)
    cb.next = 1 + mod(cb.next, cb.capacity)
    cb
end

function Base.popfirst!(cb::CircularBuffer)
    cb.unread == 0 && throw(BoundsError(cb))
    pop = cb.buffer[cb.unread]
    cb.unread = 1 + mod(cb.unread, cb.capacity)
    cb.unread == cb.next && (cb.unread = 0)
    pop
end

function Base.empty!(cb::CircularBuffer)
    cb.unread = 0
    cb.next = 1
    cb
end

Base.length(cb::CircularBuffer) = iszero(cb.unread) ? 0 : cb.next - cb.unread + (cb.next > cb.unread ? 0 : cb.capacity)
Base.size(cb::CircularBuffer) = (length(cb),)

capacity(cb::CircularBuffer) = cb.capacity

Base.isempty(cb::CircularBuffer) = iszero(cb.unread)
isfull(cb::CircularBuffer) = cb.unread == cb.next

function Base.first(cb::CircularBuffer)
    if isempty(cb)
        throw(BoundsError())
    end
    cb.buffer[cb.unread]
end

function Base.last(cb::CircularBuffer)
    if isempty(cb)
        throw(BoundsError())
    end
    cb.buffer[1 + mod(cb.next - 2, cb.capacity)]
end

Base.eltype(::Type{CircularBuffer{T}}) where {T} = T

function Base.append!(cb::CircularBuffer, items; overwrite=false)
    for item in items
        push!(cb, item; overwrite)
    end
end

function Base.getindex(cb::CircularBuffer, i::Int)
    if i < 1 || i > length(cb)
        throw(BoundsError(cb, i))
    end
    cb.buffer[1 + mod(cb.unread + i - 2, cb.capacity)]
end

function Base.setindex!(cb::CircularBuffer, value, i::Int)
    if i < 1 || i > length(cb)
        throw(BoundsError(cb, i))
    end
    cb.buffer[1 + mod(cb.unread + i - 2, cb.capacity)] = value
    cb
end

Base.iterate(cb::CircularBuffer) = isempty(cb) ? nothing : (first(cb), 2)

function Base.iterate(cb::CircularBuffer, state)
    if length(cb) < state
        return nothing
    end
    (cb[state], state + 1)
end

Base.convert(::Type{Vector{T}}, cb::CircularBuffer{T}) where {T} = T[item for item in cb]

function Base.pushfirst!(cb::CircularBuffer, value; overwrite=false)
    overwrite ? cb.unread == cb.next && (cb.next = 1 + mod(cb.next + cb.capacity - 2, cb.capacity)) : cb.unread == cb.next && throw(BoundsError(cb))
    cb.unread = 1 + (iszero(cb.unread) ? mod(cb.next + cb.capacity - 2, cb.capacity) : mod(cb.unread + cb.capacity - 2, cb.capacity))
    cb.buffer[cb.unread] = value
    cb
end

function Base.pop!(cb::CircularBuffer)
    isempty(cb) && throw(BoundsError(cb))
    cb.next = 1 + mod(cb.next + cb.capacity - 2, cb.capacity)
    value = cb.buffer[cb.next]
    cb.unread == cb.next && (cb.unread = 0)
    value
end