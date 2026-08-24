#include "sublist.h"

bool check(int *compare, int *base,
            size_t compare_count, size_t base_count){
    if (!base_count) return true;
    bool match = false;
    for (size_t i = 0; i <= compare_count - base_count; i++)
        if (*base == compare[i]){
            match = true;
            for (size_t j = 1; j < base_count; j++)
                if (base[j] != compare[i+j]) {match = false; break;}
            if (match) return true;
        }
    return match;
}

comparison_result_t check_lists(int *list_to_compare,
                                int *base_list,
                                size_t list_to_compare_element_count,
                                size_t base_list_element_count){

    if (list_to_compare_element_count == base_list_element_count)
        return (check(list_to_compare, base_list, 
                      list_to_compare_element_count, 
                      base_list_element_count)) ? EQUAL : UNEQUAL;

    else if(list_to_compare_element_count > base_list_element_count)
        return (check(list_to_compare, base_list, 
                      list_to_compare_element_count, 
                      base_list_element_count)) ? SUPERLIST : UNEQUAL;
    
    else
        return (check(base_list, list_to_compare,
                  base_list_element_count,
                  list_to_compare_element_count)) ? SUBLIST : UNEQUAL;
}