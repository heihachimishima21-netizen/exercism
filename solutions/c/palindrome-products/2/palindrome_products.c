#include "palindrome_products.h"


bool palindrome(int n){
    int m = n / 10, place_value = 1;
    while (m) {m /= 10; place_value *= 10;}
    for (; place_value; n /= 10, place_value /= 100){
        int left_digit = n / place_value;
        int right_digit = n % 10;
        if (left_digit != right_digit) return false;
        n -= left_digit * place_value;        
    }
    return true;
}

product_t *get_palindrome_product(int from, int to){
    struct product *output = calloc(1, sizeof(struct product));
    if (to < from){
         sprintf(output->error, "invalid input: min is %d and max is %d", from, to);
        return output;
    }
    int n;
    factor_t *factors, *ptr, *prevptr;
    for (int i = from; i <= to; i++)
        for (int j = i; j <= to; j++){
            n = i*j;
            if (palindrome(n)){
                if (output->smallest == 0 || n < output->smallest){
                    output->smallest = n;
                    factors = malloc(sizeof(factor_t));
                    *factors = (factor_t){i, j, NULL};
                    if (output->factors_sm != NULL)
                         while (output->factors_sm != NULL){
                            ptr = output->factors_sm;
                            while(ptr->next != NULL){
                                prevptr = ptr;
                                ptr = ptr->next;
                            }
                            if (ptr != output->factors_sm)
                                prevptr->next = NULL;
                            else
                                output->factors_sm = NULL;
                            free(ptr);
                        }
                    output->factors_sm = factors;
                }
                else if (n == output->smallest){
                    factors = malloc(sizeof(factor_t));
                    *factors = (factor_t){i, j, NULL};
                    ptr = output->factors_sm;
                    while(ptr->next != NULL)
                        ptr = ptr->next;
                    ptr->next = factors;
                }
                if (n > output->largest){
                    output->largest = n;
                    factors = malloc(sizeof(factor_t));
                    *factors = (factor_t){i, j, NULL};
                    if (output->factors_lg != NULL)
                        while (output->factors_lg != NULL){
                            ptr = output->factors_lg;
                            while(ptr->next != NULL){
                                prevptr = ptr;
                                ptr = ptr->next;
                            }
                            if (ptr != output->factors_lg)
                                prevptr->next = NULL;
                            else
                                output->factors_lg = NULL;
                            free(ptr);
                        }
                    output->factors_lg = factors;
                }
                else if (n == output->largest){
                    factors = malloc(sizeof(factor_t));
                    *factors = (factor_t){i, j, NULL};
                    ptr = output->factors_lg;
                    while(ptr->next != NULL)
                        ptr = ptr->next;
                    ptr->next = factors;
                }
            }
        }
    if (output->smallest == 0){
        sprintf(output->error, "no palindrome with factors in the range %d to %d", from, to);
        return output;
    }    
    return output;
}

void free_product(product_t *p){
    factor_t *ptr, *prevptr;
    if (p->factors_sm != NULL)
        while (p->factors_sm != NULL){
            ptr = p->factors_sm;
            while(ptr->next != NULL){
                prevptr = ptr;
                ptr = ptr->next;
            }
            if (ptr != p->factors_sm)
                prevptr->next = NULL;
            else
                p->factors_sm = NULL;
            free(ptr);
        }
    if (p->factors_lg != NULL)
        while (p->factors_lg != NULL){
            ptr = p->factors_lg;
            while(ptr->next != NULL){
                prevptr = ptr;
                ptr = ptr->next;
            }
            if (ptr != p->factors_lg)
                prevptr->next = NULL;
            else
                p->factors_lg = NULL;
            free(ptr);
        }
    free(p);
}