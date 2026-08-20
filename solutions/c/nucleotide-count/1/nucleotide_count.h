#ifndef NUCLEOTIDE_COUNT_H
#define NUCLEOTIDE_COUNT_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct{
    int a;
    int c;
    int g;
    int t;
}count_t;

char *count(const char *dna_strand);

#endif