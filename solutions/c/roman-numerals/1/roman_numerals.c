#include "roman_numerals.h"

char *to_roman_numeral(unsigned int n){
    char *numeral = calloc(n + 1, sizeof(char));
    while (n >= 1000) {
        strcat(numeral, "M");
        n -= 1000;
    }
    if (n >= 900) {
        strcat(numeral, "CM");
        n -= 900;
    }
    if (n >= 500) {
        strcat(numeral, "D");
        n -= 500;
    }
    if (n >= 400) {
        strcat(numeral, "CD");
        n -= 400;
    }
    while (n >= 100) {
        strcat(numeral, "C");
        n -= 100;
    }
    if (n >= 90) {
        strcat(numeral, "XC");
        n -= 90;
    }
    if (n >= 50) {
        strcat(numeral, "L");
        n -= 50;
    }
    if (n >= 40) {
        strcat(numeral, "XL");
        n -= 40;
    }
    while (n >= 10) {
        strcat(numeral, "X");
        n -= 10;
    }
    if (n >= 9) {
        strcat(numeral, "IX");
        n -= 9;
    }
    if (n >= 5) {
        strcat(numeral, "V");
        n -= 5;
    }
    if (n >= 4) {
        strcat(numeral, "IV");
        n -= 4;
    }
    while (n >= 1) {
        strcat(numeral, "I");
        n -= 1;
    }
    return numeral;
}