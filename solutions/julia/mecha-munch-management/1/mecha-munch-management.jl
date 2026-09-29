function additems!(cart, items)
    foreach(item -> cart[item] = get(cart, item, 0) + 1, items)
    cart
end

function update_recipes!(ideas, updates)
    merge!(ideas, updates)
end

function send_to_store(cart, aislecodes)
    sort([aislecodes[item] => cart[item] for item in keys(cart)], by = x -> x.first)
end

function update_store_inventory!(inventory, cart)
    mergewith!(-, inventory, cart)
    filter(x -> x.second == 0, inventory)
end

function reorder!(outofstock, stock)
    order = Dict(item => get(stock, item, 100) for item in keys(outofstock))
    merge(stock, order)
    order
end