#include "largest_series_product.h"

int64_t largest_series_product(char *digits, size_t span){
    size_t len = strlen(digits);
    int64_t max = 0, prod, digit;
    if (len < span) return -1;
    for (size_t i = 0; i < len; i++) 
        if (!isdigit(digits[i])) return -1;
    for (size_t i = 0; i < len - span + 1; i++){
        if (i > 0 && digits[i-1] > digits[i+span-1])
            continue;
        prod = 1;
        for (size_t j = i; j < i + span; j++){
            digit = (int64_t) digits[j] - '0';
            prod *= digit;
        }
        if (prod > max) max = prod;
    }
    return max;
}