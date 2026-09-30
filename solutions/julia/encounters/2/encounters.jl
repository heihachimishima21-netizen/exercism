abstract type Pet end

struct Dog <: Pet; name; end
struct Cat <: Pet; name; end

const ACTIONS = Dict((Dog, Dog)=>"sniffs", (Cat, Dog)=>"hisses", (Dog, Cat)=>"chases", (Cat, Cat)=>"slinks")

name(p) = p.name

meets(a::S, b::T) where {S <: Pet, T <: Pet} = get(ACTIONS, (S, T), "is cautious")
meets(a::Pet, b)                             = "runs away"
meets(a, b)                                  = "nothing happens"

encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."