#include "rational_numbers.h"

int gcd(rational_t r){
    int a = abs(r.numerator), 
        b = abs(r.denominator), 
        rem;
    while (b != 0){
        rem = a%b; 
        a = b; 
        b = rem;
    }
    return a;
}

rational_t add(rational_t r1, rational_t r2){
    rational_t result = {r1.numerator*r2.denominator + 
                         r2.numerator*r1.denominator, 
                         r1.denominator*r2.denominator};
    return reduce(result);
}
    
rational_t subtract(rational_t r1, rational_t r2){
    rational_t result = {r1.numerator*r2.denominator - 
                         r2.numerator*r1.denominator, 
                         r1.denominator*r2.denominator};
    return reduce(result);
}
    
rational_t multiply(rational_t r1, rational_t r2){
    rational_t result = {r1.numerator*r2.numerator, 
                         r1.denominator*r2.denominator};
    return reduce(result);
}
    
rational_t divide(rational_t r1, rational_t r2){
    rational_t result = {r1.numerator*r2.denominator, 
                         r1.denominator*r2.numerator};
    return reduce(result);
}
    
rational_t absolute(rational_t r){
    rational_t result = {abs(r.numerator), 
                         abs(r.denominator)};
    return reduce(result);
}
    
rational_t exp_rational(rational_t r, int16_t n){
    rational_t result = (n>0) ? 
        (rational_t){round(pow(r.numerator, n)), 
                     round(pow(r.denominator, n))} : 
        (rational_t){round(pow(r.denominator, -n)), 
                     round(pow(r.numerator, -n))};
    return reduce(result);
}

float exp_real(uint16_t x, rational_t r){
    float result = pow(pow(x,r.numerator), 
                       1.0/r.denominator);
    return result;
}

rational_t reduce(rational_t r){
    int num, den, g = gcd(r);
    num = r.numerator / g;
    den = r.denominator / g;
    if (den < 0) {num *= -1; den *= -1;}
    rational_t result = {num, den};
    return result;
}