#include "two_fer.h"
#include <string.h>

void two_fer(char *buffer, const char *name){
    char one[] = "One for ", you[] = "you", me[] = ", one for me.";
    strcpy(buffer, one);
    if (name ==  NULL || *name == '\0'){strcat(buffer, you);}
    else strcat(buffer, name);
    strcat(buffer, me);
}