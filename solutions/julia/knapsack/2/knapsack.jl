function maximum_value(maximum_weight, items) 
    (isempty(items) || iszero(maximum_weight)) && return 0
    max_value = 0
    for i in 1:length(items)
        items[i].weight > maximum_weight && continue
        value = items[i].value + maximum_value(maximum_weight - items[i].weight, items[1:end .!= i])
        value > max_value && (max_value = value)
    end
    max_value
end  