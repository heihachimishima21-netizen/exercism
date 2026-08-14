#include "difference_of_squares.h"

unsigned int sum_of_squares(unsigned int n){
    return n*(n+1)*(2*n + 1)/6;
    
}
unsigned int square_of_sum(unsigned int n){
    return n*n*(n+1)*(n+1)/4;
}
unsigned int difference_of_squares(unsigned int n){
    return (n-1)*n*(n+1)*(3*n + 2)/12;
}