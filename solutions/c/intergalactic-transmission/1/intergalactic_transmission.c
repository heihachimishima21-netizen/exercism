#include "intergalactic_transmission.h"

uint8_t parity(uint8_t byte){
    uint8_t parity = 0;
    for (uint8_t i = 0; i < 7; i++)
        parity ^= (byte >> (7-i)) & 1;
    byte &= 254;
    byte |= parity;
    return byte; 
}

uint8_t test(const uint8_t *message, int message_length){
    uint8_t odd = 0;
    for (int i = 0; i < message_length; i++, odd = 0){
        for (uint8_t j = 0; j < 7; j++)
            odd ^= (message[i] >> (7 - j)) & 1;
        if((message[i] & 1) != odd) return 1;
    }
    return 0;
}

int transmit_sequence(uint8_t *buffer, 
                      const uint8_t *message,
                      int message_length){
    if (!message_length) return 0;
    int j = 0;
    uint8_t byte;
    for (int i = 0; i < message_length; i++, j++){
        if (i%7 == 0)
            buffer[j] = parity(message[i]);
        else{
            byte = message[i] >> (i%7);
            byte |= message[i-1] << (8-i%7);
            buffer[j] = parity(byte);
            if (i%7 == 6)
                buffer[1+j++] = parity(message[i] << 1);
        }
    }
    if (j%7 != (message_length/7)%7){
        byte = message[message_length - 1] << (8 - j%8);
        buffer[j++] = parity(byte);
    }
return j;
}

int decode_message(uint8_t *buffer, 
                   const uint8_t *message, 
                   int message_length){
    if (!message_length) return 0;
    if (test(message, message_length))
        return WRONG_PARITY;    
    int j = 0;
    uint8_t byte;
    for (int i = 0; i < message_length; i++, j++){
        if (i && j%7 == 0) i++;
        byte = (message[i] & 254) << j%7;
        if (i + 1 != message_length)
            byte |= message[i+1] >> (7 - j%7);
        buffer[j] = byte;
    }
    return j - 1;
}