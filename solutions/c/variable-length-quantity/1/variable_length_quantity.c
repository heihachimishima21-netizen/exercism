#include "variable_length_quantity.h"

int encode(const uint32_t *integers, size_t integers_len, uint8_t *output)
{
    uint32_t integer;
    int k, index = 0;
    uint8_t nums[5] = {0};
    for (size_t i = 0; i < integers_len; i++){
        integer = integers[i];
        k = 0;
        memset(nums, 0, sizeof(uint8_t));     
        do{
            nums[k] = integer & 127;
            if (k) nums[k] |= 128;
            integer >>= 7;
            k++;
        }
        while (integer);
        for (int j = 0; j < k; j++)
            output[index + j] = nums[k - j - 1];
        index += k;
    }
    return index;
}

int decode(const uint8_t *bytes, size_t buffer_len, uint32_t *output){
    uint32_t segment, integer = 0;
    unsigned int index = 0;
    for (size_t i = 0; i < buffer_len; i++){
        if (i == buffer_len - 1 && (bytes[i] & 128) != 0)
            return -1;
        segment = bytes[i] & 127;
        integer |= segment;
        if ((bytes[i] & 128) == 0){
            output[index++] = integer;
            integer = 0;
        }
        else integer <<= 7;       
    }
    return index;
}