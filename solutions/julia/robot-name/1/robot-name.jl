NAMES = Set{String}()

mutable struct Robot
    name::String

    function Robot()
        code = ""
        while true
            letters = rand('A':'Z', 2)
            numbers = rand(0:9, 3) .|> string .|> first
            code = join([letters; numbers])
            (code ∉ NAMES) && break
        end
        push!(NAMES, code)
        new(code)
    end
end

reset!(instance::Robot) = (instance.name = Robot().name)

name(instance::Robot) = instance.name