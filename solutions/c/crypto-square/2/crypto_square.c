#include "crypto_square.h"

char *ciphertext(const char *input){
    size_t l = strlen(input), len = 0, r, c;;
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
    int trail = r*c - strlen(norm);
    char code[(r+1)*c + 1];
    memset(code, 0, ((r+1)*c + 1)*sizeof(char));
    for (size_t m = 0, n = 0; m < len + 1;){
            if (c*(m%r) + m/r != len)
                code[n++] = norm[c*(m%r) + m/r];
            m++;
            if (n > r*(c - trail) - 1 && (n + 1)%r == 0) 
                code[n++] = ' ';
        }
    code[(r+1)*c] = '\0';
    char *output = calloc((r + 1)*c + 1, sizeof(char));
    for (size_t i = 0, j = 0; i < (r+1)*c - 1;)
        if (i && (i+1)%(r+1) == 0) {output[i++] = ' ';}
        else
            output[i++] = code[j++]; 
    return output;
}