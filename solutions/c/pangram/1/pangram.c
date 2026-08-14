#include "pangram.h"
#include <ctype.h>
#include <stddef.h>

bool is_pangram(const char *sentence){
    if (sentence == NULL) return false;
    bool letters[26] = {false};
    int i = 0;
    while (sentence[i]){
        if (!isalpha(sentence[i])) {i++; continue;}
        int index = tolower(sentence[i]) - 'a';
        
        letters[index] = true;
        i++;
    }
    for (int j = 0; j < 26; j++){
        if (!letters[j]) return false;
    }
    return true;
}
