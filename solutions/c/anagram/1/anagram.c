#include "anagram.h"

void find_anagrams(const char *subject, struct candidates *candidates){
    size_t len = strlen(subject);
    for (size_t i = 0; i < candidates->count; i++ ){
        if (len != strlen(candidates->candidate[i].word) || 
            strcasecmp(subject, candidates->candidate[i].word) == 0){
            candidates->candidate[i].is_anagram = NOT_ANAGRAM; 
            continue;
        }
        int unmatched = len;
        bool letters[len];
        memset(letters, false, sizeof(letters));
        for (size_t j = 0; j < len; j++)
            for (size_t k = 0; k < len; k++)
                if (!letters[k] && 
                    tolower(subject[k]) == tolower(candidates->candidate[i].word[j])){
                    letters[k] = true;
                    unmatched--;
                    break;
                }
        candidates->candidate[i].is_anagram = (!unmatched) ? IS_ANAGRAM : NOT_ANAGRAM;
    }  
}