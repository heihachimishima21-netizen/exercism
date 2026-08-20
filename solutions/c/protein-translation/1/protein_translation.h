#ifndef PROTEIN_TRANSLATION_H
#define PROTEIN_TRANSLATION_H

#include <stdbool.h>
#include <stddef.h>
#include <string.h>

#define MAX_AMINO_ACIDS 10

typedef enum {
   Methionine,
   Phenylalanine,
   Leucine,
   Serine,
   Tyrosine,
   Cysteine,
   Tryptophan,
} amino_acid_t;

typedef struct {
   bool valid;
   size_t count;
   amino_acid_t amino_acids[MAX_AMINO_ACIDS];
} protein_t;

void mod(protein_t *pro, amino_acid_t amino, int j);
protein_t protein(const char *const rna);

#endif
