#include "triangle.h"

bool is_degen(triangle_t s){
    return s.a + s.b < s.c || s.a + s.c < s.b || s.c + s.b < s.a || s.a <= 0 || s.b <= 0 || s.c <= 0;
}

bool is_equilateral(triangle_t sides){
    return sides.a == sides.b && sides.a == sides.c && !is_degen(sides);
}

bool is_isosceles(triangle_t sides){
    return (sides.a == sides.b || sides.a == sides.c || sides.b == sides.c) && !is_degen(sides);
}

bool is_scalene(triangle_t sides){
    return !is_isosceles(sides) && !is_degen(sides);
}