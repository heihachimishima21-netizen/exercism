#include "nth_prime.h"


uint32_t nth(uint32_t n){
    if (n == 0) return 0;
    int flag = 1;
    uint32_t primes[n], i = 0, k = 2;
    while (i < n){
        uint32_t sq = sqrt(k);
        for (uint32_t j = 0; j < i && primes[j] <= sq; j++){
            if (k%primes[j] == 0){
                flag = 0;
                break;
            }
        }
        if (flag) primes[i++] = k;
        flag = 1;
        k++;
    }
    return primes[i-1];
}