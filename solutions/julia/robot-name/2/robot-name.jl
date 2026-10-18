const NAMES = Set{String}(string(a, b, c, d, e) for a in 'A':'Z', b in 'A':'Z', c in '0':'9', d in '0':'9', e in '0':'9')

mutable struct Robot
    name::String

    function Robot()
        isempty(NAMES) && error("Names depleted")
        code = rand(NAMES)
        delete!(NAMES, code)
        new(code)
    end
end

reset!(instance::Robot) = (instance.name = Robot().name)

name(instance::Robot) = instance.name