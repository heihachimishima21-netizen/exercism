#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stddef.h>
#include <errno.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

typedef int buffer_value_t;

typedef struct node_t{
    bool occupied;
    buffer_value_t value;
    struct node_t *next;
}node_t;

typedef struct circular_buffer_t{
    size_t capacity;
    unsigned int position; // Most recently written in slot. Default = 0.
    node_t *nodes[];
}circular_buffer_t;

circular_buffer_t *new_circular_buffer(size_t  capacity);
int16_t read(circular_buffer_t *buffer, buffer_value_t *read_value);
int16_t write(circular_buffer_t *buffer, buffer_value_t value);
int16_t overwrite(circular_buffer_t *buffer, buffer_value_t value);
void clear_buffer(circular_buffer_t *buffer);
void delete_buffer(circular_buffer_t *buffer);

#endif