#include "collatz_conjecture.h"

int steps(int start){
    if (start < 1) return ERROR_VALUE;
    int steps = 0;
    while (start != 1){
        if (start%2) start = 3*start + 1;
        else start /= 2;
        steps++;
    }
    return steps;
}