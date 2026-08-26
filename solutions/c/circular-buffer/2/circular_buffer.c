#include "circular_buffer.h"

circular_buffer_t *new_circular_buffer(size_t capacity){
    circular_buffer_t *buffer = malloc(sizeof(circular_buffer_t) + capacity*sizeof(node_t *));
    if (!buffer) return NULL;
    buffer->capacity = capacity;
    buffer->position = 0;
    for (size_t i = 0; i < capacity; i++){
        buffer->nodes[i] = malloc(sizeof(node_t));
        if (!buffer->nodes[i]){
            for (size_t j = 0; j < i; j++)
                free(buffer->nodes[j]);
            free(buffer);
            return NULL;
        }
        buffer->nodes[i]->occupied = false;
        if (i)
            buffer->nodes[i-1]->next = buffer->nodes[i];
        if (i == capacity - 1)
            buffer->nodes[i]->next = buffer->nodes[0];
    }
    return buffer;
}

int16_t read(circular_buffer_t *buffer, buffer_value_t *read_value){
    node_t *node = buffer->nodes[buffer->position]->next;
    for (size_t i = 0; i < buffer->capacity; i++)
        if (node->occupied){
            *read_value = node->value;
            node->occupied = false;
            return EXIT_SUCCESS;
        }
        else
            node = node->next;
    errno = ENODATA;
    return EXIT_FAILURE;
}

int16_t write(circular_buffer_t *buffer, buffer_value_t value){
    if (buffer->nodes[buffer->position]->next->occupied){
        errno = ENOBUFS; 
        return EXIT_FAILURE;}
    return overwrite(buffer, value);
}

int16_t overwrite(circular_buffer_t *buffer, buffer_value_t value){
    node_t *node = buffer->nodes[buffer->position]->next;
    node->value = value;
    node->occupied = true;
    buffer->position++;
    buffer->position %= buffer->capacity;
    return EXIT_SUCCESS;
}

void clear_buffer(circular_buffer_t *buffer){
    for (size_t i = 0; i < buffer->capacity; i++)
        buffer->nodes[i]->occupied = false;
}

void delete_buffer(circular_buffer_t *buffer){
    for (size_t i = 0; i < buffer->capacity; i++)
        free(buffer->nodes[i]);
    free(buffer);
}