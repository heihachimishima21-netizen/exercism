struct InvalidPosition <: Exception; end

struct Queen
    x::Int8
    y::Int8
    
    Queen(x, y) = !(0 <= x <= 7) || !(0 <= y <= 7) ?  throw(InvalidPosition()) : new(x, y)
end

function canattack(w::Queen, b::Queen)
    if w == b; throw(InvalidPosition()); end
    w.x == b.x || w.y == b.y || abs(w.x - b.x) == abs(w.y - b.y)
end