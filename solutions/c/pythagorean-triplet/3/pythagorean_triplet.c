#include "pythagorean_triplet.h"

#define MOD (N*N - 2*a*N)%(2*(N - a))
#define B (N*N - 2*a*N)/(2*(N - a))

triplets_t *triplets_with_sum(const uint16_t N){
    uint16_t lBound = N/3;
    triplets_t *triplets = malloc(sizeof(triplets_t));
    if (!triplets) return NULL;
    if (N%2) return triplets;
    for (uint16_t a = 1; a < lBound; a++)
        if (MOD == 0 && a < B){
            uint16_t b = B;
            triplets->triplets[triplets->count].a = a; 
            triplets->triplets[triplets->count].b = b;
            triplets->triplets[triplets->count++].c = N - a - b;
            }
    return triplets;
}

void free_triplets(triplets_t *triplets){
    free(triplets);
}