#include "resistor_color_duo.h"


int color_code(resistor_band_t colors[]){
    int num = 0;
   // int len = sizeof(colors)/sizeof(colors[0]);
    for (int i = 0; i < 2; i++){
        num *= 10;
        num += colors[i];
    }
    return num;   
}