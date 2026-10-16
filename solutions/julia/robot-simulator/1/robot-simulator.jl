import Base: +

const MOVEMENTS = ((0, 1), (1, 0), (0, -1), (-1, 0))

const Point = Tuple{Int64, Int64}
Point(x::Int, y::Int) = (x, y)
+(a::Tuple{Int64, Int64}, b::Tuple{Int64, Int64}) = (a[1] + b[1], a[2] + b[2])

@enum Compass::Int8 NORTH=0 EAST=1 SOUTH=2 WEST=3
Base.convert(::Type{Compass}, val::Int) = Compass(mod(val, 4))

mutable struct Robot
    position::Point
    heading::Compass
end

position(r)    =  r.position
heading(r)     =  r.heading
turn_right!(r) = (r.heading   = mod(Int(r.heading) + 1, 4)   ; r)   
turn_left!(r)  = (r.heading   = mod(Int(r.heading) - 1, 4)   ; r)
advance!(r)    = (r.position += MOVEMENTS[1 + Int(r.heading)]; r)

function move!(r, str)
    for c in str
        if c == 'R'
            turn_right!(r)
        elseif c == 'L'
            turn_left!(r)
        elseif c == 'A'
            advance!(r)
        end
    end
    r
end