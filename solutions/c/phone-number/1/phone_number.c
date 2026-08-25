#include "phone_number.h"

char *phone_number_clean(const char *input){
    char *output = calloc(14, sizeof(char)), numbers[14] = {0};
    char *pNumbers = numbers;
    unsigned int count = 0;
    strcpy(output, "0000000000");
    for (;*input; input++){
        if (isdigit(*input))
            numbers[count++] = *input;
        if (count > 11) return output;
    }
    if (count < 10) return output;
    if (count == 11){
        if(*numbers != '1') return output;
        else pNumbers++;}
    
    if (pNumbers[0] == '0' || pNumbers[0] == '1' || 
        pNumbers[3] == '0' || pNumbers[3] == '1') 
        return output;
    strcpy(output, pNumbers);
    return output;
}