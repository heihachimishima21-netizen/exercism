#include "grains.h"

uint64_t square(uint8_t index){
    if (index == 0) return 0;
    uint64_t g = 1;
    for (int i = 2; i <= index; i++) g *= 2;
    return g;
}
uint64_t total(void){
    uint64_t sum = 0;
    for (int i = 1; i <= 64; i++) sum += square(i);
    return sum;
}