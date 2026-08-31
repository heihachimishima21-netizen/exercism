#ifndef PIG_LATIN_H
#define PIG_LATIN_H

#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

void letter_cycle(char *word);
char first_letter(const char *word);
char *pig(const char *word);
char *translate(const char *phrase);

#endif