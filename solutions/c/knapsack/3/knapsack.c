#include "knapsack.h"

unsigned int max(unsigned int a, unsigned int b){
    return (a > b) ? a : b;
}

 unsigned int maximum_value(unsigned int maximum_weight, item_t items[], size_t item_count){
     unsigned int value[item_count + 1][maximum_weight + 1];
     for (size_t i = 0; i <= item_count; i++)
         for (unsigned int w = 0; w <= maximum_weight; w++){
             if (!i || !w) {value[i][w] = 0; continue;}
             value[i][w] = (items[i-1].weight <= w) ? 
                 max(items[i-1].value + value[i-1][w - items[i-1].weight], value[i-1][w]) : value[i-1][w];
         }
     return value[item_count][maximum_weight];
 }