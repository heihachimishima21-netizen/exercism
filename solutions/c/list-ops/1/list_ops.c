#include "list_ops.h"

static const size_t MAX_STRING_LEN = 100;

list_t *new_list(size_t length, list_element_t elements[]){
    list_t *list = malloc(sizeof(list_t) + 
                          MAX_STRING_LEN  * 
                          sizeof(list_element_t));
    if (!list) return NULL;
    list->length = (length < MAX_STRING_LEN) ? length : MAX_STRING_LEN;
    for (size_t i = 0; 
         i < length && i < MAX_STRING_LEN && elements != NULL; i++)
        list->elements[i] = elements[i];
    return list;
}

list_t *append_list(list_t *list1, list_t *list2){
    if (!list1 || !list2) return NULL;
    list_t *list = new_list(list1->length, list1->elements);
    if (!list) return NULL;
    for (size_t i= 0; 
         i < list2->length && i + list1->length < MAX_STRING_LEN; i++)
        list->elements[list->length++] = list2->elements[i];
    return list;
}

list_t *filter_list(list_t *list, bool (*filter)(list_element_t)){
    if (!list) return NULL;
    list_t *filtered = new_list(0, NULL);
    if (!filtered) return NULL;
    for (size_t i = 0; i < list->length; i++)
        if (filter(list->elements[i]))
            filtered->elements[filtered->length++] = list->elements[i];
    return filtered;
}

size_t length_list(list_t *list){
    if (!list) return 0;
    return list->length;
}

list_t *map_list(list_t *list, list_element_t (*map)(list_element_t)){
    if (!list) return NULL;
    list_t *mapped = new_list(list->length, NULL);
    if (!mapped) return NULL;
    for (size_t i = 0; i < list->length; i++)
        mapped->elements[i] = map(list->elements[i]);
    return mapped;
}

// folds (reduces) the given list from the left with a function
list_element_t foldl_list(list_t *list, list_element_t initial,
                          list_element_t (*foldl)(list_element_t,
                                                  list_element_t)){
    if (!list) return 0;
    for (size_t i = 0; i < list->length; i++)
        initial = foldl(initial, list->elements[i]);
    return initial;
}
                                                  

list_element_t foldr_list(list_t *list, list_element_t initial,
                          list_element_t (*foldr)(list_element_t,
                                                  list_element_t)){
    if (!list) return 0;
    for (size_t i = 0; i < list->length; i++)
        initial = foldr(list->elements[list->length - i - 1], initial);
    return initial;
                                                  }

list_t *reverse_list(list_t *list){
    if (!list) return NULL;
    list_t *reverse = new_list(list->length, NULL);
    if (!reverse) return NULL;
    for (size_t i = 0; i < list->length; i++)
        reverse->elements[i] = list->elements[list->length - i - 1];
    return reverse;
}

void delete_list(list_t *list){
    free(list);
}