#include "word_count.h"

bool check(char *word, 
           word_count_word_t *words, 
           int unique){
    for (int i = 0; i < unique; i++){
        if (strcmp(words[i].text, word) == 0){
            words[i].count++;
            return false;
        }
    }
    return true;
}

void processWord(int *isInside, 
                 int *letters, 
                 char *word, 
                 word_count_word_t *words, 
                 int *unique){
    word[*letters] = '\0';
    *letters = *isInside = 0;
    if(check(word, words, *unique) && 
       *unique < MAX_WORDS){
            strcpy(words[*unique].text, word);
            words[(*unique)++].count = 1;
    }
}

int count_words(const char *s, word_count_word_t *words){
    int unique = 0, isInside = 0, letters = 0;
    char word[MAX_WORD_LENGTH];
    for (;*s; s++){
        if (isalnum(*s)){
            isInside = 1;
            if (letters < MAX_WORD_LENGTH - 1)
                word[letters++] = tolower(*s);
        }
        else if (*s == '\'' && 
                 isInside && 
                 isalpha(*(s+1)) && 
                letters < MAX_WORD_LENGTH - 1) 
            word[letters++] = *s;
        else if (isspace(*s) || ispunct(*s)){
            if (!(letters && isInside)) continue;
            processWord(&isInside, &letters, 
                        word, words, &unique);
        }
    }
    if (letters) processWord(&isInside, &letters, 
                             word, words, &unique);
  return unique;  
}