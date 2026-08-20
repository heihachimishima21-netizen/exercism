#include "rotational_cipher.h"

char *rotate(const char *text, int shift_key){
    size_t len = strlen(text);
    char *rot = malloc((len + 1)*sizeof(char));
    int index;
    for (size_t i = 0; i <= len; i++){
        if (!isalpha(text[i])) rot[i] = text[i];
        else if (isupper(text[i])){
            index = text[i] - 'A';
            index += shift_key;
            rot[i] = index%26 + 'A';
        }
        else{
            index = text[i] - 'a';
            index += shift_key;
            rot[i] = index%26 + 'a';
        }
    }
    return rot;
}