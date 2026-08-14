#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int candidate){
    int len = 0, sum = 0, n = candidate, m = candidate;
    while (n){
        n /= 10;
        len++;
    }
    for (int i = 0; i < len; i++){
        sum += pow(m%10, len);
        m /= 10;
    }
    return sum == candidate;
}