#include "darts.h"
#include <math.h>

float radius(coordinate_t l){
    return sqrt(l.x*l.x + l.y*l.y);
}


int score(coordinate_t landing_position){
    float rad = radius(landing_position);
    if (rad > 10) return 0;
    else if (rad > 5) return 1;
    else if (rad > 1) return 5;
    else return 10;
}
