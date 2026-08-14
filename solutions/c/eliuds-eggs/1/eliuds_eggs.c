#include "eliuds_eggs.h"

unsigned int egg_count(unsigned int x){
    int count = 0;
    while (x){
        if (x%2) count++;
        x /= 2;
    }
    return count;
}