#include "clock.h"

clock_t clock_create(int hour, int minute){
    clock_t clock;
    hour += minute/60;     
    if (minute < 0 && minute%60) hour--;
    minute = (minute >= 0 || !(minute%60)) ? minute%60 : 60 + minute%60;
    hour = (hour >= 0 || !(hour%24)) ? hour%24 : 24 + hour%24;
    clock.text[0] = '0' + hour/10;
    clock.text[1] = '0' + hour%10;
    clock.text[2] = ':';
    clock.text[3] = '0' + minute/10;
    clock.text[4] = '0' + minute%10;
    clock.text[5] = '\0';
    return clock;
}

clock_t clock_add(clock_t clock, int minute_add){
    int h = 10*(clock.text[0] - '0')
        + clock.text[1] - '0', 
        m = 10*(clock.text[3] - '0')
            + clock.text[4] - '0';
    m += minute_add;
    h += m/60;
    h %= 24;
    m %= 60;
    return clock_create(h, m);
}
    
clock_t clock_subtract(clock_t clock, int minute_subtract){
    int h = 10*(clock.text[0] - '0')
        + clock.text[1] - '0', 
        m = 10*(clock.text[3] - '0')
            + clock.text[4] - '0';
    m -= minute_subtract;
    h += m/60;
    h %= 24;
    m %= 60;
    return clock_create(h, m);
}
    
bool clock_is_equal(clock_t a, clock_t b){
    for (long unsigned int i = 0; i < MAX_STR_LEN; i++){
        if (a.text[i] != b.text[i]) return false;
    }
    return true;
}