#include "diamond.h"

#define ADJ ((i > cols/2) ? cols - i - 1 : i)

char **make_diamond(const char letter){
    int rows = 2*(letter - 'A') + 1;
    int cols = 2*(letter - 'A') + 1;
    char **output = malloc((rows + 1)*sizeof(char *));
    if (output == NULL) return NULL;
    output[rows] = NULL;
    for (int i = 0; i < rows; i++){
        output[i] = calloc(cols + 1, sizeof(char));
        if (output[i] == NULL){
            for (int j = 0; j < i; j++) free(output[j]);
            free(output);
            return NULL;
        }
    }
    for (int i = 0; i < rows; i++){
        memset(output[i], ' ', cols*sizeof(char));
        output[i][cols] = '\0';
        output[i][cols/2 + ADJ] = 'A' + ADJ;
        output[i][cols/2 - ADJ] = 'A' + ADJ;
    }
    return output;
}

void free_diamond(char **diamond){
    for (int i = 0; diamond[i];)
        free(diamond[i++]);
    free(diamond);
}