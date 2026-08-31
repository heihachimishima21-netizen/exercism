#include "knapsack.h"

unsigned int maximum_value(unsigned int maximum_weight, 
                           item_t items[], 
                           size_t item_count){
    if (!item_count || !maximum_weight) return 0;
    unsigned int max_value = 0, value;
    for (size_t i = 0; i < item_count; i++){
        if (items[i].weight > maximum_weight) continue;
        unsigned int weight = maximum_weight - items[i].weight;
        size_t count = item_count - 1;
        item_t new_items[count];
        for (size_t j = 0, k = 0; j < item_count; j++){
            if (j == i) continue;
            new_items[k++] = items[j];
        }
        value = items[i].value + maximum_value(weight, new_items, count);
        if (value > max_value)
            max_value = value;
    }
    return max_value;
}