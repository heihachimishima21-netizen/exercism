function maximum_value(maximum_weight, items)
    item_count = length(items); value = zeros(UInt64, item_count + 1, maximum_weight + 1)
    for i in 1:item_count, w in 1:maximum_weight
            value[i+1, w+1] = items[i].weight <= w ? max(items[i].value + value[i, w+1 - items[i].weight], value[i, w+1]) : value[i, w+1]
    end
    value[item_count+1, maximum_weight+1]
end