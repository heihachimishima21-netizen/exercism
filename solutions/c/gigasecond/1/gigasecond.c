#include "gigasecond.h"

#include <stdio.h>


void gigasecond(time_t input, char *output, size_t size){
    time_t giga = input + 1000000000;
    output[size] = '0';
    struct tm *t = gmtime(&giga);
    sprintf(output, "%d-%02d-%02d %02d:%02d:%02d", t->tm_year +1900, t->tm_mon + 1, t->tm_mday, t->tm_hour, t->tm_min, t->tm_sec);
    
}