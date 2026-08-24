#include "bob.h"
#include <ctype.h>

char *hey_bob(char *greeting){
    int len = 0, silence = 1, question = 0, 
        yell = 0, yellLock = 0;
    while (*(greeting + len)) len++;
    for (; *greeting; greeting++){
        if (isalpha(*greeting)) question = 0;
        if (*greeting == '?') question = 1;
        if ((isupper(*greeting)) && yellLock == 0) yell = 1;
        if (islower(*greeting)) {yell = 0; yellLock = 1;}
        if (!(isspace(*greeting))) silence = 0;
    }
    if (silence) {return "Fine. Be that way!";}
    if (yell && question) {return "Calm down, I know what I'm doing!";}
    if (yell) {return "Whoa, chill out!";}
    if (question) {return "Sure.";}
    return "Whatever.";             
}