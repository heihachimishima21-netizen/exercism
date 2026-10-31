#ifndef ZEBRA_PUZZLE_H
#define ZEBRA_PUZZLE_H

#include <stdbool.h>
#include <stdlib.h>

#define NUM_HOUSES 5
#define NUM_PROPERTIES (PET + 1)
#define UNSET      -1
#define COLOUR_END (NUM_HOUSES * (COLOUR + 1))
#define COMPLETE   (NUM_HOUSES * NUM_PROPERTIES)

typedef enum {
    COLOUR,
    BEVERAGE,
    HOBBY,
    NATIONALITY,
    PET
} property_t;

typedef enum {
    RED,
    GREEN,
    IVORY,
    YELLOW,
    BLUE
} colour_t;

typedef enum {
    ENGLISHMAN,
    SPANIARD,
    UKRAINIAN,
    NORWEGIAN,
    JAPANESE
} nationality_t;

typedef enum {
    DOG,
    SNAILS,
    FOX,
    HORSE,
    ZEBRA
} pet_t;

typedef enum {
    COFFEE,
    TEA,
    MILK,
    ORANGE_JUICE,
    WATER
} beverage_t;

typedef enum {
    DANCING,
    PAINTING,
    READING,
    FOOTBALL,
    CHESS
} hobby_t;

typedef struct {
   const char *drinks_water;
   const char *owns_zebra;
} solution_t;

solution_t solve_puzzle(void);

#endif