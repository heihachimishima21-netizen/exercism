#ifndef ATBASH_CIPHER_H
#define ATBASH_CIPHER_H

#include <string.h>
#include <ctype.h>
#include <stdlib.h>

char *atbash_encode(const char *input);
char *atbash_decode(const char *input);

#endif