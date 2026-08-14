#include "hamming.h"

int compute(const char *lhs, const char *rhs){
    int dist = 0, i = 0;
    while (!(*(lhs + i) == '\0' && *(rhs + i) == '\0')){
        if (*(lhs + i) == '\0' || *(rhs + i) == '\0') 
            return -1;
        if (lhs[i] != rhs[i]) dist++;
        i++;
    }
    return dist;
}