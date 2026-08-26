#ifndef PYTHAGOREAN_TRIPLET_H
#define PYTHAGOREAN_TRIPLET_H

#define MAXTRIPLETS 100


#include <stdint.h>
#include <stdlib.h>

typedef struct{
    uint16_t a;
    uint16_t b;
    uint16_t c;
}triplet_t;

typedef struct{
    uint16_t count;
    triplet_t triplets[MAXTRIPLETS];
}triplets_t;

triplets_t *triplets_with_sum(const uint16_t N);
void free_triplets(triplets_t *triplets);

#endif