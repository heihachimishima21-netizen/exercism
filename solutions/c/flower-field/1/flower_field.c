#include "flower_field.h"

void anno(int i, int j, int rows, int cols, char **field){
    for (int x = -1; x < 2; x++)
        for (int y = -1; y < 2; y++)
            if (i+x >= 0 && i+x < rows && j+y >= 0 && j+y < cols){
                if (field[i+x][j+y] == '*') continue;
                field[i+x][j+y]++;}
}

char **annotate(const char **garden, const size_t rows){
    if (!rows) return NULL;
    char **field = calloc(rows + 1, sizeof(char *));
    if (!field) return NULL;
    size_t columns = strlen(garden[0]);
    for (size_t i = 0; i < rows; i++){
        field[i] = calloc((columns + 1), sizeof(char));
        if (!field[i]){
            for (size_t j = 0; j < i; j++) free(field[j]);
            free(field);
        }
        for (size_t j = 0; j < columns; j++)
            field[i][j] = (garden[i][j] == '*') ? '*' : '0';
    }
   for (size_t i = 0; i < rows; i++)
        for (size_t j = 0; j < columns; j++)
            if (field[i][j] == '*')
                anno(i, j, rows, columns, field);      
    for (size_t i = 0; i < rows; i++)
        for (size_t j = 0; j < columns; j++)
            if (field[i][j] == '0') field[i][j] -= 16;   
    return field;  
}
    
void free_annotation(char **annotation){
    for (size_t i = 0; annotation[i] != NULL; i++)
        free(annotation[i]);
    free(annotation);
}