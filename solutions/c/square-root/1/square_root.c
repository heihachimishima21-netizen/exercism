#include "square_root.h"

int square_root(int n){
    int a = (n/2 > 0) ? n/2 : 1, b = 0;
    while (a != b){
        b = a;
        a = (a + n/a)/2;
    }
    return a;
}