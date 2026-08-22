#include "yacht.h"

int score(dice_t dice, category_t category){
    int points = 0, a = 1, b = 0, counts[6] = {0};
    bool same = true;
    
    switch (category) {
            
        case YACHT:
            for (int i = 1; i < 5; i++)
                if (dice.faces[i] != dice.faces[0])
                    same = false;
            points = (same) ? 50 : 0;
            break;
            
        case CHOICE:
            for (int i = 0; i < 5; i++)
                points += dice.faces[i];
            break;
            
        case BIG_STRAIGHT:
            for (int i = 0; i < 5; i++)
                b |= a << (dice.faces[i] - 1);
            points = (b == 62) ? 30 : 0;
            break;
    
        case LITTLE_STRAIGHT:
            for (int i = 0; i < 5; i++)
                b |= a << (dice.faces[i] - 1);
            points = (b == 31) ? 30 : 0;
            break;
    
        case FOUR_OF_A_KIND:
            for (int i = 0; i < 5; i++)
                counts[dice.faces[i] - 1]++;
            for (int i = 0; i < 6; i++)
                if (counts[i] >= 4){
                    points += 4*(i+1);
                    break;
                }
            break;
    
        case FULL_HOUSE:
            for (int i = 0; i < 5; i++){
                counts[dice.faces[i] - 1]++;
                points += dice.faces[i];
            }
            for (int i = 0; i < 6; i++){
                if (counts[i] == 1 || 
                    counts[i] == 4 ||
                    counts[i] == 5){
                    points = 0;
                    break;
                }
            }
            break;
    
        default:
            for (int i = 0; i < 5; i++)
                if (dice.faces[i] == (int) category + 1)
                    points += category + 1;
    }
    return points;
}