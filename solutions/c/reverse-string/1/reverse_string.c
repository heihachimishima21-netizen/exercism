#include "reverse_string.h"

char *reverse(const char *value){
    int i = 0;
    while (*(value + i) != '\0') i++;
    char *rev = calloc(i + 1, sizeof(char));
    for (int j = 0; j < i; j++){
        rev[j] = value[i - j - 1];
    }
    return rev;
}