#include "pig_latin.h"

const char vowels[5] = {'a', 'e', 'i', 'o', 'u'};

void letter_cycle(char *word){
    int len = strlen(word);
    char first = word[0];
    for (int i = 0; i < len - 1; i++)
        word[i] = word[i+1];
    word[len - 1] = first;
}

char first_letter(const char *word){
    char first = word[0];
    bool vowel_found = false;
    for (int i = 0; i < 5; i++)
        if (first == vowels[i])
            vowel_found = true;
    return (vowel_found) ? 'v' : 'c';
}

char *pig(const char *word){
    static char latin[100];
    memset(latin, 0, sizeof latin);
    char first = word[0];
    bool swaps = false;    
    strcpy(latin, word);
    if (first_letter(word) == 'v' || 
        (first == 'x' && word[1] == 'r') || 
        (first == 'y' && word[1] == 't')) {}
    else
        while (first_letter(latin) == 'c'){
            if (latin[0] == 'q' && latin[1] == 'u'){
                letter_cycle(latin);
                letter_cycle(latin);
                break;
            }
            if (latin[0] == 'y' && swaps)
                break;
            letter_cycle(latin);
            swaps = true;
        }
    strcat(latin, "ay");
    return latin;
}

char *translate(const char *phrase){
    char *translation = calloc(2 * strlen(phrase) + 20, sizeof(char));
    if (translation == NULL) return NULL;
    char copy[strlen(phrase) + 1];
    strcpy(copy, phrase);
    char *word = strtok(copy, " ");
    if (word == NULL) return translation;
    strcpy(translation, pig(word));
    word = strtok(NULL, " ");
    while(word != NULL){
        strcat(translation, " ");
        strcat(translation, pig(word));
        word = strtok(NULL, " ");
    }
    return translation;
}