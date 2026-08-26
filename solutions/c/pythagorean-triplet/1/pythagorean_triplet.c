#include "pythagorean_triplet.h"

triplets_t *triplets_with_sum(const uint16_t N){
    uint16_t lBound = N/3, uBound = N/2;
    triplets_t *triplets = malloc(sizeof(triplets_t));
    if (!triplets) return NULL;
    for (uint16_t a = 1; a < lBound; a++)
        for (uint16_t b = a + 1; b < uBound && a + 2*b < N; b++)
            if (a*a + b*b == (N - a - b)*(N - a - b)){
                triplets->triplets[triplets->count].a = a; 
                triplets->triplets[triplets->count].b = b;
                triplets->triplets[triplets->count++].c = N - a - b;
            }
    return triplets;
}

void free_triplets(triplets_t *triplets){
    free(triplets);
}