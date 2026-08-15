#include "binary.h"

int convert(const char *input){
    int sum = 0, position = 1, len = 0 ;
    while (input[len]){
        if (input[len] != '0' && input[len] != '1')
            return -1;
        len++;
    }
    for (int i = len - 1; i >= 0; i--){
        sum += (input[i] == '1') ? position : 0;
        position *= 2;
    }
    return sum;
}