#ifndef SERIES_H
#define SERIES_H

#include <string.h>
#include <stdlib.h>

#define MAX_INPUT_TEXT_LENGTH (8)
#define MAX_SERIES_RESULTS (MAX_INPUT_TEXT_LENGTH)
#define MAX_SERIES_LENGTH (5)

typedef struct slices {
   unsigned int substring_count;
   char **substring;
} slices_t;

slices_t slices(char *input_text, unsigned int substring_length);

#endif