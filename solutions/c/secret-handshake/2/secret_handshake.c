#include "secret_handshake.h"

const char *const actions[] = {"wink", "double blink", "close your eyes", "jump"};

const char **commands(size_t number){
    bool reverse = (number >> 4) & 1;
    int action = 0;
    const char **handshake = calloc(4, sizeof(char *));
    for (int i = 0; i < 4; i++)
        if (number >> ((reverse) ? 3 - i : i) & 1)
            handshake[action++] = actions[(reverse) ? 3 - i : i];
    return handshake;
}