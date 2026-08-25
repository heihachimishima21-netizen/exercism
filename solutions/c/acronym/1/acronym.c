#include "acronym.h"

char *abbreviate(const char *phrase){
    if (phrase == NULL || !*phrase) return NULL;
    char *acronym = calloc(100, sizeof(char));
    if (acronym == NULL) return NULL;
    bool isInside = false;
    int character = 0;
    for (; *phrase; phrase++){
        if (isalpha(*phrase)){
            if (!isInside)
                acronym[character++] = toupper(*phrase);
            isInside = true;
        }
        else if (*phrase == '\'' && isInside && 
                 isalpha(*(phrase + 1))){}
        else isInside = false;
    }
    return acronym;
}