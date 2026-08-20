#include "protein_translation.h"


void mod(protein_t *pro, amino_acid_t amino, int j){
    pro->count++;
    pro->amino_acids[j] = amino;
}

protein_t protein(const char *const rna){
    protein_t pro = {0};
    pro.valid = true;
    int len = strlen(rna);
    if (len == 0) return pro;
    for (int i = 0, j = 0; i < len && j < MAX_AMINO_ACIDS; i++){
        if (len - 3*j < 3) {
            pro.valid = false; 
            return pro;
        }
        if (i%3 == 0){
            if (rna[i] == 'A' && rna[i+1] == 'U' && rna[i+2] == 'G'){
                mod(&pro, Methionine, j++);
                i += 2;
            }
            else if (rna[i] != 'U'){
                pro.valid = false;
                break;
            }
            continue;
                
        }
        if (rna[i] == 'C'){
            mod(&pro, Serine, j++);
            i++;
            continue;
        }
        if (rna[i] == 'U'){
            switch (rna[i+1]){
                case 'U':
                case 'C':
                    mod(&pro, Phenylalanine, j++);
                    break;
                case 'A':
                case 'G':
                    mod(&pro, Leucine, j++);
                    break;
            }
            i++;
            continue;
        }
        if (rna[i+1] == 'U' || rna[i+1] == 'C'){
            if (rna[i] == 'A')
                mod(&pro, Tyrosine, j++);
            else
                mod(&pro, Cysteine, j++);
            i++;
            continue;
        }
        if (rna[i] == 'G' && rna[i+1] == 'G'){
            mod(&pro, Tryptophan, j++);
            i++;
            continue;
        }
        break;
    }
    return pro;
}