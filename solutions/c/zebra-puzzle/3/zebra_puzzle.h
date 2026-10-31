#ifndef ZEBRA_PUZZLE_H
#define ZEBRA_PUZZLE_H

#include <stdbool.h>
#include <stdlib.h>

#define UNSET -1
#define COLOUR_END 10
#define HOBBY_END 25
#define COMPLETE 30

typedef enum {
    HOUSE_NUMBER,
    COLOUR,
    NATIONALITY,
    PET,
    HOBBY,
    BEVERAGE
} property_t;

typedef enum {
    FIRST = 1,
    SECOND,
    THIRD,
    FOURTH,
    FIFTH
} house_number_t;

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