const NAMES = Set(string(a, b, lpad(c, 3, '0')) for a in 'A':'Z', b in 'A':'Z', c in 0:999)

mutable struct Robot; name::String; end

function Robot()
    isempty(NAMES) && error("Names depleted")
    code = rand(NAMES)
    delete!(NAMES, code)
    Robot(code)
end

reset!(instance::Robot) = (instance.name = Robot().name)

name(instance::Robot) = instance.name