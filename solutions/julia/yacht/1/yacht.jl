const CATEGORIES = Dict(
    "ones"            => 1,
    "twos"            => 2,
    "threes"          => 3,
    "fours"           => 4,
    "fives"           => 5,
    "sixes"           => 6,
    "full house"      => 7,
    "four of a kind"  => 8,
    "little straight" => 9,
    "big straight"    => 10,
    "choice"          => 11,
    "yacht"           => 12
)

function score(dice, category)
    points = 0
    if 1 <= CATEGORIES[category] <= 6
        points = CATEGORIES[category] * count(==(CATEGORIES[category]), dice) 
    elseif category == "little straight"
        Set(dice) == Set(1:5) && (points = 30)
    elseif category == "big straight"
        Set(dice) == Set(2:6) && (points = 30)
    elseif category == "choice"
        points = sum(dice)
    elseif category == "yacht"
        length(Set(dice)) == 1 && (points = 50)
    elseif category == "full house" && length(Set(dice)) == 2
        count(==(dice[1]), dice) ∈ (2, 3) && (points = sum(dice))
    elseif category == "four of a kind" && length(Set(dice)) ∈ (1, 2)
        count(==(dice[1]), dice) ∈ (1, 4, 5) && (points = 4*(dice[1] == dice[2] ? dice[1] : dice[3]))
    end
    points
end