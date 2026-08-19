#include "resistor_color_trio.h"

resistor_value_t color_code(resistor_band_t colors[]){
    unsigned long long int num = 0;
    unsigned int n = colors[2], zeros = colors[2];
    resistor_value_t resistor;
    for (int i = 0; i < 2; i++){
        num *= 10;
        num += colors[i];
    }
    while (n){
        num *= 10;
        n--;
    }
    if (colors[1] == 0){
        if (colors[0] == 0) zeros = 0;
        else zeros++;
    }
    if (zeros < 3){
        resistor.value = num;
        resistor.unit = OHMS;
    }
    else if (zeros < 6){
        resistor.value = num/1000;
        resistor.unit = KILOOHMS;
    }
    else if (zeros < 9){
        resistor.value = num/1000000;
        resistor.unit = MEGAOHMS;
    }
    else{
        resistor.value = num/1000000000;
        resistor.unit = GIGAOHMS;
    }
    return resistor;   
}