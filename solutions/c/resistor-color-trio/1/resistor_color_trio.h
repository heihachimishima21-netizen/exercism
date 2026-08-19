#ifndef RESISTOR_COLOR_TRIO_H
#define RESISTOR_COLOR_TRIO_H
#include <math.h>

typedef enum {
    BLACK,
    BROWN,
    RED,
    ORANGE,
    YELLOW,
    GREEN,
    BLUE,
    VIOLET,
    GREY,
    WHITE
} resistor_band_t;

typedef enum {
    OHMS,
    KILOOHMS,
    MEGAOHMS,
    GIGAOHMS
} unit_t;

typedef struct{
    int value;
    unit_t unit;
} resistor_value_t;

resistor_value_t color_code(resistor_band_t colors[]);

#endif