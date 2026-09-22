function create_inventory(items)
    inventory = Dict(item => 0 for item in Set(items))
    for item in items
        inventory[item] += 1
    end
    inventory
end

function add_items(inventory, items)
    inven = copy(inventory)
    for item in setdiff(Set(items), Set(keys(inven)))
        inven[item] = 0
    end
    for item in items
        inven[item] += 1
    end
    inven
end

function decrement_items(inventory, items)
    inven = copy(inventory)
    for item in items
        if haskey(inven, item) && inven[item] > 0
            inven[item] -= 1
        end
    end
    inven
end

function remove_item(inventory, item)
    inven = copy(inventory)
    delete!(inven, item)
end

function list_inventory(inventory)
    [pair for pair in sort(collect(inventory)) if last(pair) > 0]
end
