struct Coord
    x::UInt16
    y::UInt16
end

@kwdef struct Plot
    top_right::Coord
    bottom_left::Coord
end

is_claim_staked(claim, register) = claim in register

function stake_claim!(claim, register)
    is_claim_staked(claim, register) && return false
    push!(register, claim)
    return true    
end

get_longest_side(claim) = max(
    claim.top_right.x - claim.bottom_left.x,
    claim.top_right.y - claim.bottom_left.y
)

function get_claim_with_longest_side(register)
    m = maximum(get_longest_side, register)
    filter(x -> get_longest_side(x) == m, register)
end