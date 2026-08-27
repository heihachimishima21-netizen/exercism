#include "run_length_encoding.h"

char *encode(const char *text){
    int len = strlen(text), count = 1;
    if (!len) return calloc(1, sizeof(char));
    char letter = *text, letter_s[2], number[100];
    char *output = calloc(100, sizeof(char));
    for (int i = 1; i <= len; i++)
        if (i != len && text[i] == letter) count++;
        else{
            sprintf(number, "%d", count);
            sprintf(letter_s, "%c", letter);
            if (count > 1)
                strcat(output, number);
            strcat(output, letter_s);
            letter = text[i];
            count = 1;
        }            
    return output;
}

char *decode(const char *data){
    int len = strlen(data), j, n = 1;
    if (!len) return calloc(1, sizeof(char));
    char *output = calloc(100, sizeof(char));
    for (int i = 0; i < len; i++)
        if (isalpha(data[i]) || isspace(data[i])){
            for (; n > 0; n--)
                strcat(output, (char []){data[i], '\0'});  
            n = 1;
        }
        else{
            j = 1;
            while (isdigit(data[i + j - 1])) j++;
            char number[10];
            snprintf(number, j, "%s", data + i);
            n = atoi(number);
            i += j - 2;
        }
    return output;
}