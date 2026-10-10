#include "luhn.h"
#include <ctype.h>

bool luhn(const char *num){
    unsigned int length = 0, digits = 0, m, sum = 0;
    while (num[length] != '\0')
        if(isdigit(num[length++])) digits++;
    if (digits <= 1) return false;
    for (int i = length - 1, j = 1; i >= 0; i--){
        if (num[i] == ' ') continue;
        if (isdigit(num[i])){
            m = num[i] - '0';
            sum += ((j++ & 1) == 0) ? (m >= 5) ? 2*m - 9 : 2*m : m;
        }
        else return false;
    }
  return (sum%10) ? false : true;
}