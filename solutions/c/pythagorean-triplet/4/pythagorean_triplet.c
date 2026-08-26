#include "pythagorean_triplet.h"

uint16_t gcd(uint16_t x, uint16_t y){
    while (y) {uint16_t tmp = y; y = x%y; x = tmp;}
    return x;
}

triplets_t *triplets_with_sum(const uint16_t N){
    triplets_t *triplets = malloc(sizeof(triplets_t));
    if (!triplets) return NULL;
    if (N%2) return triplets;
    uint16_t n = N/2;
    for (uint16_t m = 2; m*m < n; m++)
        for (uint16_t k = 1; k < m; k++)
            if((m - k)%2 && gcd(m, k) == 1 && n % (m*(m + k)) == 0){
                uint16_t s = n/(m*(m + k)),
                    a = s*(m*m - k*k), b = 2*s*m*k, c = s*(m*m + k*k);
                if (a > b) {uint16_t tmp = a; a = b; b = tmp;}
                triplets->triplets[triplets->count].a = a; 
                triplets->triplets[triplets->count].b = b;
                triplets->triplets[triplets->count++].c = c;
            }
    return triplets;
}

void free_triplets(triplets_t *triplets){
    free(triplets);
}