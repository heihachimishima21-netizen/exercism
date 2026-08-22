#include "matching_brackets.h"

bool is_paired(const char *input){
    char arr[1000];
    int i = 0;
    for (; *input; input++){
        switch (*input){
            case '(': case '[': case '{':
                arr[i++] = *input;
                break;
            case ')':
                if (!i || arr[i-1] != *input - 1)
                    return false;
                i--;
                break;
            case ']': case '}':
                if (!i || arr[i-1] != *input - 2)
                    return false;
                i--;
                break;
        }
    }
    return !i;
}