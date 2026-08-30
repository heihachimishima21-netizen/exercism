#include "intergalactic_transmission.h"

uint8_t parity(uint8_t byte){
    uint8_t folded_bits = byte;
    for (uint8_t i = 4; i > 0; i >>= 1)
        folded_bits ^= folded_bits >> i;
    folded_bits &= 1;
    byte ^= folded_bits;
    return byte; 
}

uint8_t test(const uint8_t *message, int message_length){
    for (int i = 0; i < message_length; i++){
        uint8_t folded_bits = message[i];
        for (uint8_t j = 4; j > 0; j >>= 1)
            folded_bits ^= folded_bits >> j;
        if (folded_bits & 1)
            return 1;
    }
    return 0;
}

int transmit_sequence(uint8_t *buffer, 
                      const uint8_t *message,
                      int message_length){
    if (!message_length) return 0;
    int j = 0;
    uint8_t byte;
    for (int i = 0; i < message_length; i++, j++)
        if (i%7 == 0)
            buffer[j] = parity(message[i]);
        else{
            byte = message[i] >> (i%7);
            byte |= message[i-1] << (8-i%7);
            buffer[j] = parity(byte);
            if (i%7 == 6)
                buffer[++j] = parity(message[i] << 1);
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
    int decoded_length = (message_length * 7) / 8;
    for (int i = 0, j = 0; j < decoded_length; i++, j++){
        if (j && j%7 == 0) i++;
        uint8_t byte = (message[i] & 254) << j%7;
        if (i + 1 != message_length)
            byte |= message[i+1] >> (7 - j%7);
        buffer[j] = byte;
    }
    return decoded_length;
}