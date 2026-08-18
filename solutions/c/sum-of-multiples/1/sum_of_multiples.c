#include "sum_of_multiples.h"


unsigned int sum(const unsigned int *factors, 
                 const size_t number_of_factors, 
                 const unsigned int limit){
    unsigned int mult[number_of_factors*limit];
    memset(mult, 0, number_of_factors*limit*sizeof(mult[0]));
    unsigned int n, k, j = 0, sum = 0;
    for (size_t i = 0; i < number_of_factors; i++){
        n = k = factors[i];
        while (n < limit){
            mult[j++] = n;
            n += k;
        }
    }
    for (unsigned int i = 0; i < j; i++){
        if (mult[i] == 0) continue;
        sum += mult[i];
        for (unsigned int l = i + 1; l < j; l++){
            if (mult[l] == mult[i]) mult[l] = 0;
        }
    }
    return sum;
}