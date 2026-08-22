#ifndef SCRABBLE_SCORE_H
#define SCRABBLE_SCORE_H

#include <ctype.h>

unsigned int letter_score(const char letter);
unsigned int score(const char *word);

#endif