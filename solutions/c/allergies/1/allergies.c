#include "allergies.h"

bool is_allergic_to(allergen_t ALLERGEN, unsigned int score){
    for (unsigned int i = 0; i < ALLERGEN ; i++){
        score /= 2;
    }
    return score%2;    
}

allergen_list_t get_allergens(unsigned int score){
    allergen_list_t allergies = {0, {false}};
    for (unsigned int i = 0; i < ALLERGEN_COUNT ; i++){
        if (score%2){
            allergies.allergens[i] = true;
            allergies.count++;
        }
        score /= 2;
    }
    return allergies;
}