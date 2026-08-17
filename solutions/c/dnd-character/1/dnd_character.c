#include "dnd_character.h"

int ability(void){
    int num, min = 6, sum = 0;
    for (int i = 0; i < 4; i++){
        num = rand()%6 + 1;
        if (num < min) min = num;
        sum += num;
    }
    sum -= min;
    return sum;
}

int modifier(int score){
    int tmp = (score - 10);
    return (tmp >= 0) ? tmp/2 : (tmp + 1)/2 - 1;
}
dnd_character_t make_dnd_character(void){
    dnd_character_t pc = {0};
    int *stats[] = 
    {&pc.strength,
    &pc.dexterity,
    &pc.constitution,
    &pc.intelligence,
    &pc.wisdom,
    &pc.charisma,};
    for (unsigned int i = 0; i < sizeof(stats)/sizeof(stats[0]); i++){
        *stats[i] = ability();
    }
    pc.hitpoints = 10 + modifier(pc.constitution);
    return pc;
}

