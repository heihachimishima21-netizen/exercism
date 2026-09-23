const UNITS = [" ohms", " kiloohms", " megaohms", " gigaohms"]

const COLORS = Dict(
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9
)

function label(colors)
    col = Tuple(COLORS[color] for color in colors)
    sub_digits = (col[1] > 0 ? 1 : 0) + col[3]
    zeros = "0"^(col[3] % 3)
    if sub_digits % 3 == 0 && sub_digits > 0 && col[2] > 0
        number = "$(col[1]).$(col[2])"
    elseif sub_digits % 3 == 0
        number = "$(col[1] > 0 ? col[1] : col[2])"
    elseif col[1] > 0
        number = "$(col[1])$(col[2])$zeros"
    else
        number = "$(col[2])$zeros"
    end
    number * UNITS[1 + sub_digits ÷ 3]
end