#ifndef SADDLE_POINTS_H
#define SADDLE_POINTS_H

#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct{
    uint8_t row;
    uint8_t column;
}saddle_point_t;

typedef struct{
    uint8_t count;
    saddle_point_t points[];
}saddle_points_t;

void task(bool *flag, uint8_t currRow, uint8_t colInd, uint8_t rowMax, uint8_t rows, uint8_t columns, uint8_t matrix[rows][columns], saddle_points_t *saddles);
saddle_points_t *saddle_points(uint8_t rows, uint8_t columns, uint8_t matrix[rows][columns]);
void free_saddle_points(saddle_points_t *saddles);

#endif