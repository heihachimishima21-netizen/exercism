#include "isogram.h"
#include <ctype.h>
#include <stddef.h>

bool is_isogram(const char *sentence){
    if (sentence == NULL) return false;
    bool letters[26] = {false};
    int i = 0;
    while (sentence[i]){
        if (!isalpha(sentence[i])) {i++; continue;}
        int index = tolower(sentence[i]) - 'a';
        if (letters[index] == false){
            letters[index] = true;
        }
        else return false;
        i++;
    }
    return true;
}