#include "prime_factors.h"

size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS]){
    size_t i = 0;
    while (n != 1){
        if (i == MAXFACTORS) break;
        for (uint64_t j = 2; j <= n; j++){
            if (!(n%j)){
                factors[i++] = (uint64_t) j;
                n /= j;
                break;
            }
        }
    }
    return i;
}