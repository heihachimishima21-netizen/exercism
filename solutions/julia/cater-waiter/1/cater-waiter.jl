function clean_ingredients(dish_name, dish_ingredients)
    dish_name, Set(dish_ingredients)
end

function check_drinks(drink_name, drink_ingredients)
    join([drink_name, (isdisjoint(drink_ingredients, ALCOHOLS)) ? "Mocktail" : "Cocktail"], " ")
end

function categorize_dish(dish_name, dish_ingredients)
    for (category, name) in [(VEGAN, "VEGAN"), 
                             (VEGETARIAN, "VEGETARIAN"), 
                             (PALEO, "PALEO"), 
                             (KETO, "KETO"), 
                             (OMNIVORE, "OMNIVORE")]
        if issubset(dish_ingredients, category)
            return "$dish_name: $name"
        end
    end
end

function tag_special_ingredients(dish)
    dish[1], intersect(Set(dish[2]), SPECIAL_INGREDIENTS)
end

function compile_ingredients(dishes)
    ingredients = dishes[1]
    for dish in dishes
        ingredients = union(ingredients, dish)
    end
    ingredients
end

function separate_appetizers(dishes, appetizers)
    [dish for dish in Set(dishes) if !(dish in Set(appetizers))]
end

function singleton_ingredients(dishes, intersection)
    setdiff(compile_ingredients(dishes), intersection)
end