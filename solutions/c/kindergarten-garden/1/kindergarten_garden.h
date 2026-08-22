#ifndef KINDERGARTEN_GARDEN_H
#define KINDERGARTEN_GARDEN_H

#include <string.h>

typedef enum { CLOVER = 0, GRASS = 1, RADISHES = 2, VIOLETS = 3 } plant_t;

typedef struct {
   plant_t plants[4];
} plants_t;

typedef struct {
    const char *name;
    const int order;
} student_t;

int order(const char *name);
plant_t plant(const char initial);
plants_t plants(const char *diagram, const char *student);

#endif