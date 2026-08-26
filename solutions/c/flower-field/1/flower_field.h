#ifndef FLOWER_FIELD_H
#define FLOWER_FIELD_H
#include <stddef.h>
#include <string.h>
#include <stdlib.h>

void anno(int i, int j, int rows, int cols, char **field);
char **annotate(const char **garden, const size_t rows);
void free_annotation(char **annotation);

#endif