#include "nucleotide_count.h"

char *count(const char *dna_strand){
    char *count = calloc(4*6 + 1, sizeof(char));
    int len = strlen(dna_strand);
    count_t dna = {0};
    for (int i = 0; i < len; i++){
        switch (dna_strand[i]){
            case 'A':
                dna.a++;
                break;
            case 'C':
                dna.c++;
                break;
            case 'G':
                dna.g++;
                break;
            case 'T':
                dna.t++;
                break;
            default:
                return count;
        }
    }
    sprintf(count, "A:%d C:%d G:%d T:%d", 
            dna.a, dna.c, dna.g, dna.t);
    return count;
}