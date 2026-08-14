#include "perfect_numbers.h"

kind classify_number(int x){
    if (x < 1) return ERROR;
    int aliquot = 0;
    for (int i = 1; i <= x/2; i++){
        if (!(x%i)) aliquot += i;
    }
    if (aliquot > x) return ABUNDANT_NUMBER;
    if (aliquot < x) return DEFICIENT_NUMBER;
    return PERFECT_NUMBER;
}