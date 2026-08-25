#ifndef SAY_H
#define SAY_H

#include <stdint.h>
#include <string.h>
#include <stdlib.h>

void subthousand(int64_t n, char *buffer);
int say(int64_t input, char **ans);

#endif