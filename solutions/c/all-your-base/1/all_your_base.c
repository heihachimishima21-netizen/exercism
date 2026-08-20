#include "all_your_base.h"


size_t rebase(int8_t digits[], int16_t input_base, int16_t output_base, size_t input_length){
    
    if (input_base < 2 || output_base < 2 || input_length == 0)
        return 0;
    
    int64_t number = 0, place = 1;
    for (int i = input_length - 1; i >= 0; i--){
        if (digits[i] >= input_base || digits[i] < 0) 
            return 0;
        number += digits[i] * place;
        place *= input_base;
    }
    if (number == 0){digits[0] = 0; return 1;}
    
    size_t len = 0; int8_t rev[1000];
    while (number){
        rev[len++] = number % output_base;
        number /= output_base;
    }
    
    for (size_t i = 0; i < len; i++)
        digits[i] = rev[len - i - 1];
    
    return len;
}