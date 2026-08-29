#ifndef VARIABLE_LENGTH_QUANTITY_H
#define VARIABLE_LENGTH_QUANTITY_H

#include <stdint.h>
#include <stddef.h>
#include <string.h>


int encode(const uint32_t *integers, size_t integers_len, uint8_t *output);
int decode(const uint8_t *bytes, size_t buffer_len, uint32_t *output);

#endif