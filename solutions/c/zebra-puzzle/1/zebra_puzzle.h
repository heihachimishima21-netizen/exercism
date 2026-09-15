#ifndef ZEBRA_PUZZLE_H
#define ZEBRA_PUZZLE_H

#include <stdbool.h>
#include <stdlib.h>

typedef enum {
    HOUSE_NUMBER,
    NATIONALITY,
    COLOUR,
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

bool check6(int houses[5][6]);
bool check(int houses[5][6]);
bool set(int row, int column, int entry, int houses[5][6]);
bool solve(int slot, int houses[5][6]);
solution_t solve_puzzle(void);

#endif