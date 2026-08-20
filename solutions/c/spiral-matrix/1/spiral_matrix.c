#include "spiral_matrix.h"
#include <stdlib.h>

spiral_matrix_t *spiral_matrix_create(unsigned int n){
    spiral_matrix_t *spiral = malloc(sizeof(spiral_matrix_t));
    if (spiral == NULL) exit(1);
    spiral->size = n;
    if (!n){
        spiral->matrix = NULL;
        return spiral;
    }
    spiral->matrix = malloc(n*sizeof(int *));
    for (unsigned int i = 0; i < n; i++){
        spiral->matrix[i] = malloc(n*sizeof(int));
    }
    int k = 1, left, right, top, bottom;
    left = top = 0, right = bottom = n - 1;
    while (k <= (int)(n*n)){
        for (int i = left; i <= right; i++, k++){
            spiral->matrix[top][i] = k;
        }
        for (int i = top + 1; i <= bottom; i++, k++){
            spiral->matrix[i][right] = k;
        }
        for (int i = right - 1; i >= left; i--, k++){
            spiral->matrix[bottom][i] = k;
        }
        for (int i = bottom - 1; i >= top + 1; i--, k++){
            spiral->matrix[i][left] = k;
        }
        left++; right--; top++; bottom--;
    }
   return spiral; 
}

void spiral_matrix_destroy(spiral_matrix_t *spiral){
    for (int i = 0; i < spiral->size; i++){
        free(spiral->matrix[i]);
    }
    free(spiral->matrix);
    free(spiral);
}