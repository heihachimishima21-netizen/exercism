#include "high_scores.h"

int32_t latest(const int32_t *scores, size_t scores_len){
    return *(scores + scores_len - 1);
}

int32_t personal_best(const int32_t *scores, size_t scores_len){
    int32_t max = 0;
    for (size_t i = 0; i < scores_len; i++){
        if (scores[i] > max) max = scores[i];
    }
    return max;
}

size_t personal_top_three(const int32_t *scores, size_t scores_len, int32_t *output){
    int32_t max, index, arr[100] = {0};
    for (int j = 0; j < 3; j++){
        max = 0, index = 0;
        for (size_t i = 0; i < scores_len; i++){
            if (scores[i] > max && !arr[i]){
                max = scores[i];
                index = i;
            }
        }
        arr[index] = 1;
        output[j] = max;
    }
    return (scores_len > 3) ? 3 : scores_len;
}