#ifndef INTERGALACTIC_TRANSMISSION_H
#define INTERGALACTIC_TRANSMISSION_H

#include <stdint.h>

#define WRONG_PARITY -1

uint8_t test(const uint8_t *message, int message_length);
uint8_t parity(uint8_t byte);
int transmit_sequence(uint8_t *buffer, const uint8_t *message, int message_length);
int decode_message(uint8_t *buffer, const uint8_t *message, int message_length);

#endif
