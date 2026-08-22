#include "allergies.h"

bool is_allergic_to(allergen_t ALLERGEN, unsigned int score)
{return score & 1 << ALLERGEN;}

allergen_list_t get_allergens(unsigned int score){
    allergen_list_t allergies = {0, {false}};
    for (allergen_t i = 0; i < ALLERGEN_COUNT ; i++)
        if (is_allergic_to(i, score)){
            allergies.allergens[i] = true;
            allergies.count++;
        }
    return allergies;
}