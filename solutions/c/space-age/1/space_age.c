#include "space_age.h"
//#include <stdint. h>

float plan(planet_t planet){
    switch (planet) {
        case MERCURY:
            return 0.2408467;
        case VENUS:
            return 0.61519726;
        case EARTH:
            return 1.0;
        case MARS:
            return 1.8808158;
        case JUPITER:
            return 11.862615;
        case SATURN:
            return 29.447498;
        case URANUS:
            return 84.016846;
        case NEPTUNE:
            return 164.79132;
    }
    return -1;
}

float age(planet_t planet, int64_t seconds){
    if (plan(planet) == -1) return -1.0;
    return seconds/(plan(planet)*3600*24*365);
}

