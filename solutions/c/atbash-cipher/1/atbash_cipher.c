#include "atbash_cipher.h"

char *atbash_encode(const char *input){
    int len = strlen(input);
    char *output = calloc(len + len/5 + 1, sizeof(char));
    for (int i = 0, j = 0; i < len; i++)
        if (isalnum(input[i])){
            if (i && (j+1)%6 == 0) output[j++] = ' ';
            output[j++] = (isalpha(input[i])) ? 'z' + 'a' - tolower(input[i]) : tolower(input[i]);
        }   
    return output;
}

char *atbash_decode(const char *input){
    int len = strlen(input);
    char *output = calloc(5*(1 + len/6) + 1, sizeof(char));
    for (int i = 0, j = 0; i < len; i++)
        if (input[i] != ' ')
            output[j++] = (isalpha(input[i])) ? 'z' + 'a' - input[i] : input[i];
    return output;
}