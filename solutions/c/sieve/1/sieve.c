#include "sieve.h"

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes){
    uint32_t m, n;
    uint32_t count = 0;
    int marks[limit + 1];
    memset(marks, 0, (limit + 1)*sizeof(marks[0]));
    for (uint32_t i = 2; i <= limit; i++){
        if (marks[i]){continue;}
        primes[count++] = i;
        m = i;
        n = 2*m;
        while (n <= limit){
            marks[n] = 1;
            n += m;
        }
    }
    return (count < max_primes) ? count : max_primes;
}