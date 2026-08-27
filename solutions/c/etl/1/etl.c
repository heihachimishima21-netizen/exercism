#include "etl.h"

int sort(const void *a, const void *b){
    char l1 = *(const char*)a, l2 = *(const char*)b;
    return l1 - l2;}

int convert(const legacy_map *input, const size_t input_len, new_map **output){
    size_t alphabet = 0;
    for (size_t i = 0; i < input_len; i++)
        alphabet += strlen(input[i].keys);
    *output = calloc(alphabet, sizeof(new_map));
    for (size_t i = 0, k = 0; i < input_len; i++)
        for (size_t j = 0; j < strlen(input[i].keys); j++)
            (*output)[k++] = (new_map) {tolower(input[i].keys[j]), input[i].value};
    qsort(*output, alphabet, sizeof(new_map), sort);
    return alphabet;
}