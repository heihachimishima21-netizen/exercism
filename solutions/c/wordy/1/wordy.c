#include "wordy.h"

int test_operation(char *op){
	if      (strcmp(op, "plus") == 0)       return 1;
	else if (strcmp(op, "minus") == 0)      return 2;
	else if (strcmp(op, "multiplied") == 0) return 3;
	else if (strcmp(op, "divided") == 0)    return 4;
	else                                    return 0;
}

bool test_num(char *str){
    int len = strlen(str);
    for (int i = 0; i < len; i++){
        if (!i && str[0] == '-' && len != 1) continue;
        if (!isdigit(str[i])) return false;
    }
    return true;
}

int oper(int a, int b, int op){
	switch (op) {
	case 1: return a + b;
	case 2: return a - b;
	case 3: return a * b;
	case 4: return a / b;
	default: return 0;
	}
}

bool answer(const char *question, int *result){
    char string[100];
    char *words[21];
    int k = 0;
    while (*question != '-' && !isdigit(*question) && *question != '\0')
        question++;
    sprintf(string, "%s", question);
    if (strlen(string))
        string[strlen(string) - 1] = '\0';
    char *ptr = strtok(string, " ");
    while (ptr != NULL){
        if (strcmp(ptr, "by"))
            words[k++] = ptr;
        ptr = strtok(NULL, " ");
    }
    if (k%2 == 0 || !test_num(words[0])) return false;
    int ans = atoi(words[0]);
    for (int i = 1; i < k; i += 2){
        int op = test_operation(words[i]);
        if (op && test_num(words[i+1]))
            ans = oper(ans, atoi(words[i+1]), op);
        else
            return false;
    }
    *result = ans;
    return true;
}