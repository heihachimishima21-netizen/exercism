#include "sieve.h"

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes){
    uint32_t count = 0;
    bool marks[limit + 1];
    memset(marks, true, (limit + 1)*sizeof(marks[0]));
    for (uint32_t i = 2; i <= limit; i++){
        if (!marks[i]){continue;}
        primes[count++] = i;
        for (uint32_t j = 2*i; j <= limit; j += i)
            marks[j] = false;
    }
    return (count < max_primes) ? count : max_primes;
}