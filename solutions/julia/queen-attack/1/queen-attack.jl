struct InvalidPosition <: Exception; end

struct Queen
    x::Int
    y::Int
    function Queen(x, y)
        if !(0 <= x <= 7) || !(0 <= y <= 7); throw(InvalidPosition()); end
        new(x, y)
    end
end

function canattack(w::Queen, b::Queen)
    if w == b; throw(InvalidPosition()); end
    w.x == b.x || w.y == b.y || abs(w.x - b.x) == abs(w.y - b.y)
end