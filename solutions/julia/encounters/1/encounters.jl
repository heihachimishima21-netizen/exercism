abstract type Pet end

struct Dog <: Pet; name; end

struct Cat <: Pet; name; end

actions = Dict{Tuple{Type, Type}, String}(
    (Dog, Dog) => "sniffs",
    (Cat, Dog) => "hisses",
    (Dog, Cat) => "chases",
    (Cat, Cat) => "slinks",
)

name(p::Pet) = p.name

meets(a::S, b::T) where {S <: Pet, T <: Pet} = get(actions, (S, T), "is cautious")
meets(a::Pet, b)                             = "runs away"
meets(a, b)                                  = "nothing happens"

encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."