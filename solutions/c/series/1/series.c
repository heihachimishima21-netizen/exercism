#include "series.h"


slices_t slices(char *input_text, 
                unsigned int substring_length){
    unsigned int len = strlen(input_text);
    unsigned int count = (substring_length <= len && substring_length) ? len - substring_length + 1 : 0;
    unsigned int str_count = (count) ? count : 1;
    slices_t slice;
    slice.substring_count = count;
    slice.substring = malloc(str_count * sizeof(char *));
    if (!slice.substring) return (slices_t){0};
    for (unsigned int i = 0; i < str_count; i++){
        slice.substring[i] = malloc((substring_length + 1)*sizeof(char));
        if (!slice.substring[i]) {
            for (unsigned int j = 0; j < i; j++)
                free(slice.substring[j]);
            free(slice.substring);
            return (slices_t){0};
        }
    }
    if (!count) {slice.substring[0][0] = '\0'; return slice;}
    for (unsigned int i = 0; i < str_count; i++){
        strncpy(slice.substring[i], &input_text[i], substring_length);
        slice.substring[i][substring_length] = '\0';
    }
    return slice;
}