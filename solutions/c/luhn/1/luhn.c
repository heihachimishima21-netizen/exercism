#include "luhn.h"
#include <ctype.h>


bool luhn(const char *num){
    unsigned int length = 0, digits = 0, m, sum = 0;
    while (num[length] != '\0'){
        if(isdigit(num[length])) digits++;
        length++;
    }
    if (digits <= 1) return false;
    for (int i = length - 1, j = 1; i >= 0; i--){
        if (num[i] == ' ') continue;
        if (isdigit(num[i])){
            m = num[i] - '0';
            if (j%2 == 0){
                m *= 2;
                if (m > 9) m -= 9;
            }
            sum += m;
            j++;
        }
        else return false;
    }
  return (sum%10) ? false : true;
}