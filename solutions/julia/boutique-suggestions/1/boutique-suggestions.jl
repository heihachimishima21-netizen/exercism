function clothingitem(categories, qualities)
    Dict(categories[i] => qualities[i] for i in eachindex(categories))
end

function get_combinations(tops, bottoms)
    [(top, bottom) for top in tops, bottom in bottoms]
end

function get_prices(combos)
    [x[1]["price"] + x[2]["price"] for x in combos]
end

function filter_clashing(combos)
    [x for x in combos if x[1]["base_color"] != x[2]["base_color"]]
end