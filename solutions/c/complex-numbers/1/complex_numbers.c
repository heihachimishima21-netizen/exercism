#include "complex_numbers.h"

complex_t c_add(complex_t a, complex_t b)
{
   complex_t z = {a.real + b.real, a.imag + b.imag};
    return z;
}

complex_t c_sub(complex_t a, complex_t b)
{
   complex_t z = {a.real - b.real, a.imag - b.imag};
    return z;
}

complex_t c_mul(complex_t a, complex_t b)
{
   complex_t z = {a.real*b.real - a.imag*b.imag, a.real*b.imag + a.imag*b.real};
    return z;
}

complex_t c_div(complex_t a, complex_t b)
{
   complex_t z = {(a.real*b.real + a.imag*b.imag)/(b.real*b.real + b.imag*b.imag), (a.imag*b.real - a.real*b.imag)/(b.real*b.real + b.imag*b.imag)};
    return z;
}

double c_abs(complex_t x)
{
   double m = sqrt(x.real*x.real + x.imag*x.imag);
    return m;
}

complex_t c_conjugate(complex_t x)
{
   complex_t z = {x.real, -x.imag};
    return z;
}

double c_real(complex_t x)
{
   return (double) x.real;
}

double c_imag(complex_t x)
{
   return (double) x.imag;
}

complex_t c_exp(complex_t x)
{
   complex_t z = {exp(x.real)*cos(x.imag), exp(x.real)*sin(x.imag)};
    return z;
}
