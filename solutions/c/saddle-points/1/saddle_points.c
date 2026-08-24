#include "saddle_points.h"

void task(bool *flag, uint8_t currRow, uint8_t colInd, uint8_t rowMax, uint8_t rows, uint8_t columns, uint8_t matrix[rows][columns], saddle_points_t *saddles){
    for (uint8_t k = 0; k < rows; k++){
            if (k == currRow) continue;
            if (matrix[k][colInd] < rowMax){
                flag = false;
                break;
            }
        }
        if (flag)
            saddles->points[saddles->count++] =(saddle_point_t){currRow+1, colInd+1};       
}

saddle_points_t *saddle_points(uint8_t rows, uint8_t columns,
                               uint8_t matrix[rows][columns]){
    saddle_points_t *saddles = malloc(sizeof(saddle_points_t) + rows*columns*sizeof(saddle_point_t));
    saddles->count = 0;
    uint8_t rowMax;
    bool flag = true;
    for (uint8_t i = 0; i < rows; i++){
        rowMax = 0;
        for (uint8_t j = 0; j < columns; j++)
            if (matrix[i][j] > rowMax)
                rowMax = matrix[i][j];
        for (uint8_t j = 0; j < columns; j++)
            if (matrix[i][j] == rowMax)
                task(&flag, i, j, rowMax, rows, 
                     columns, matrix, saddles);
        flag = true, rowMax = 0;
    }
    return saddles;
}

void free_saddle_points(saddle_points_t *saddles){
    free(saddles);
}