#include "beer_song.h"

#define WALL "%d bottle%s of beer on the wall, %d bottle%s of beer."

#define TAKE "Take one down and pass it around, %d bottle%s of beer on the wall."

#define IT "Take it down and pass it around, no more bottles of beer on the wall."

#define NO "No more bottles of beer on the wall, no more bottles of beer."

#define STORE "Go to the store and buy some more, 99 bottles of beer on the wall."

void recite(uint8_t start_bottles, uint8_t take_down, char **song){
    uint8_t bottles = start_bottles;
    for (int i = 0, j = 0; j < take_down; j++){
        if (bottles > 0){
            sprintf(song[i++], WALL, 
            bottles, (bottles > 1) ? "s":"",  
            bottles, (bottles > 1) ? "s":"");
            bottles--;
            if (bottles)
                sprintf(song[i++], TAKE, 
                bottles, (bottles > 1) ? "s":"");
            else
               sprintf(song[i++], IT);
            if (j + 1 < take_down)
                *(song[i++]) = '\0';
        }
        else{
            sprintf(song[i++], NO);
            sprintf(song[i], STORE);
        }
    }
}