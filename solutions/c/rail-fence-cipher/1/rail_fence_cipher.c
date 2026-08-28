#include "rail_fence_cipher.h" 

char *encode(char *text, size_t rails){
    int len = strlen(text), base = 2*(rails - 1);
    char code[rails][len];
    memset(code, '\0', sizeof(code));
    for (int i = 0; i < len; i++){
        int k = i % base;
        int idx = (k > base/2) ? base - k : k;
        strcat(code[idx], (char[]){text[i], '\0'});
    }
    char * output = calloc(len + 1, sizeof(char));
    for (size_t i = 0; i < rails; i++)
        strcat(output, code[i]);
    return output;
}

char *decode(char *ciphertext, size_t rails){
    int len = strlen(ciphertext), base = 2*(rails - 1);
    char code[rails][len + 1];
    memset(code, '0', sizeof(code));
    for (int i = 0; i < len; i++){
        int k = i % base;
        int idx = (k > base/2) ? base - k : k;
        code[idx][i] = '1';
    }
    int s = 0;
    for (size_t i = 0; i < rails; i++)
        for (int j = 0; j < len; j++)
            if (code[i][j] == '1')
                code[i][j] = ciphertext[s++];           
    char *output = calloc(len + 1, sizeof(char));
    for (int i = 0; i < len; i++){
        int k = i % base;
        int idx = (k > base/2) ? base - k : k;
        output[i] = code[idx][i];
    }
    return output;
}