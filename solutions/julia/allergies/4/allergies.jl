allergens = Dict(
    "eggs"         => 0,
    "peanuts"      => 1,
    "shellfish"    => 2,
    "strawberries" => 3,
    "tomatoes"     => 4,
    "chocolate"    => 5,
    "pollen"       => 6,
    "cats"         => 7
)

function allergic_to(score, allergen)
    score & 1 << allergens[allergen] > 0
end

function allergy_list(score)
    list = filter(x -> allergic_to(score, x), keys(allergens))
end