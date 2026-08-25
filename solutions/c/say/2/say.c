#include "say.h"

const char *const ZERO = "zero";

const char *SUB_20[] = {"", "one ", "two ", "three ", "four ", "five ", "six ", "seven ", "eight ", "nine ", "ten ", "eleven ", "twelve ", "thirteen ", "fourteen ", "fifteen ", "sixteen ", "seventeen ", "eighteen ", "nineteen "};

const char *const HUNDRED = "hundred ";

const char *TENS[] = {
    "", "ten ", "twenty ", "thirty ", "forty ", "fifty ", "sixty", "seventy ", "eighty ", "ninety "
};

const char *ORDER[] = {"", "thousand ", "million ", "billion "};

void subthousand(int64_t n, char *buffer){
    int64_t hundreds = n/100, tens, ones, len;
    n %=100;
    if (n > 19){
        tens = n/10;
        n %= 10;
        ones = n;
    }
    else {tens = 0; ones = n;}
    if (hundreds){
        strcat(buffer, SUB_20[hundreds]);
        strcat(buffer, HUNDRED);
    }
    if (tens) strcat(buffer, TENS[tens]);
    if (tens && ones) {
        len = strlen(buffer);
        buffer[len - 1] = '\0';
        strcat(buffer, "-");}
    if (ones) strcat(buffer, SUB_20[ones]);
}

int say(int64_t input, char **ans){
    int64_t n = input;
    if (n > 999999999999 || n < 0) return -1;
    *ans = calloc(130, sizeof(char));
    if (!n) {strcpy(*ans, ZERO); return 0;}
    int64_t billions, millions, thousands, len = 0;
    char word[30] = {0};
    billions = n/1000000000;
    n -= billions*1000000000;
    millions = n/1000000;
    n -= millions*1000000;
    thousands = n/1000;
    n -= thousands*1000;
    if (billions){
        subthousand(billions, word);
        strcat(*ans, word);
        strcat(*ans, ORDER[3]);
        memset(word, 0, sizeof(word));
    }
    if (millions){
        subthousand(millions, word);
        strcat(*ans, word);
        strcat(*ans, ORDER[2]);
        memset(word, 0, sizeof(word));
    }
    if (thousands){
        subthousand(thousands, word);
        strcat(*ans, word);
        strcat(*ans, ORDER[1]);
        memset(word, 0, sizeof(word));
    }
    if (n){
        subthousand(n, word);
        strcat(*ans, word);
        memset(word, 0, sizeof(word));
    }
    len = strlen(*ans);
    (*ans)[len - 1] = '\0';
    return 0;
}