function maximum_value(maximum_weight, items) 
    (isempty(items) || iszero(maximum_weight)) && return 0
    max_value = 0
    for i in 1:length(items)
        items[i].weight > maximum_weight && continue
        new_weight = maximum_weight - items[i].weight
        new_items = items[1:end .!= i]
        value = items[i].value + maximum_value(new_weight, new_items,)
        value > max_value && (max_value = value)
    end
    max_value
end

    
    
    
    
    
    
    
    
    

    
  #=  value = zeros(UInt64, length(items) + 1, maximum_weight + 1)
    for i in 1:length(items) + 1
        for w in 1:maximum_weight + 1
            if i == 1 || w == 1
                value[i, w] = 0
                continue
            end
            value[i, w] = items[i-1].weight <= w ? 
                max(items[i-1].value + value[i-1, w - items[i-1].weight], value[i-1, w]) : 
                value[i-1, w]
        end
    end
    value[length(items)+1, maximum_weight+1]
end=#

    