allergen_names = [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
]

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
    list = Set()
    for i in 0:7
        allergen = allergen_names[i + 1]
        if allergic_to(score, allergen)
            push!(list, allergen)
        end
    end 
    list
end