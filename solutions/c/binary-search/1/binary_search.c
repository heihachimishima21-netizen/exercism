#include "binary_search.h"


const int *binary_search(int value, const int *arr, size_t length){
    if (length == 0) return NULL;
    int min = 0, max = length - 1, m = 0;
    while (arr[m] != value){
        m = (max + min)/2;
        if (arr[m] == value){continue;}
        else if (min == max){return NULL;}
        else if (arr[m] > value){max = m;}
        else{
            if (m != min){min = m;}
            else min++;
        }
    }
    return &arr[m];
}