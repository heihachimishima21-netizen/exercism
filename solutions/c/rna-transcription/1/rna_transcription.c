#include "rna_transcription.h"
#include <stdlib.h>

char *to_rna(const char *dna){
    int i = 0;
    char *rna = calloc(100, sizeof(char));
    while (dna[i]){
        switch (dna[i]){
                case 'G':
                    rna[i] = 'C';
                    break;
                case 'C':
                    rna[i] = 'G';
                    break;
                case 'T':
                    rna[i] = 'A';
                    break;
                case 'A':
                    rna[i] = 'U';
                    break;
        }
        i++;
    }
    return rna;
}
