#ifndef WORDY_H
#define WORDY_H

#include <stdbool.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int test_operation(char *op);
bool test_num(char *str);
int oper(int a, int b, int op);
bool answer(const char *question, int *result);

#endif