StringOrMissing = Union{String, Missing}
IntOrNothing = Union{Int, Nothing}

@kwdef mutable struct Player
    name::StringOrMissing = missing
    level::Int64 = 0
    health::Int64 = 100
    mana::IntOrNothing = nothing
end

function introduce(player::Player)
    ismissing(player.name) ? "Mighty Magician" : player.name
end

increment(mana::IntOrNothing) = isnothing(mana) ? 50 : mana + 100

increment(name::StringOrMissing) = ismissing(name) ? "The Great" : name * " the Great"

function title!(player::Player)
    player.level == 42 ? player.name = increment(player.name) : player.name
end

function revive!(player::Player)
    if player.health == 0
        player.health = 100
        player.mana = increment(player.mana)
    end
    player
end