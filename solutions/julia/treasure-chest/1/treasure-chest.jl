struct TreasureChest{T}
    password::String
    treasure::T
end

function get_treasure(password_attempt, chest)
    if password_attempt == chest.password; return chest.treasure; end
end 

function multiply_treasure(multiplier, chest)
    TreasureChest{Vector{typeof(chest.treasure)}}(chest.password, fill.(chest.treasure, multiplier))
end