#include "crypto_square.h"

char *ciphertext(const char *input){
    size_t l = strlen(input), len = 0, r, c, k = 0;
    char norm[l + 1];
    memset(norm, 0, (l + 1)*sizeof(char));
    for (size_t i = 0; i < l; i++)
        if (isalnum(input[i])) 
            norm[len++] = tolower(input[i]);
    if (!len) return calloc(1, sizeof(char));    
    c = (int) sqrt(len);
    if (c*c != len)
        if (len <= c*(c+1)) {r = c; c++;}
        else {c++; r = c;}
    else r = c;
    char arr[r][c+1];
    int trail = r*c - strlen(norm);
    for (size_t i = 0; i < r; i++)
        for (size_t j = 0; j < c; j++)
            arr[i][j] = (k < len) ? norm[k++] : ' ';
    k = 0;
    char code[(r+1)*c + 1];
    memset(code, 0, ((r+1)*c + 1)*sizeof(char));
    for (size_t i = 0; i < c; i++)
        for (size_t j = 0; j < r; j++){
            if (!isalnum(arr[j][i])) break;
            code[k++] = arr[j][i];
            if (k > r*(c - trail) - 1 && (k + 1)%r == 0) 
                code[k++] = ' ';
        }
    code[(r+1)*c] = '\0';
    char *output = calloc((r + 1)*c + 1, sizeof(char));
    for (size_t i = 0, j = 0; i < (r+1)*c - 1;)
        if (i && (i+1)%(r+1) == 0) {output[i++] = ' ';}
        else
            output[i++] = code[j++]; 
    return output;
}