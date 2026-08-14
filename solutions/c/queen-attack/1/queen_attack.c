#include "queen_attack.h"

int invalid(position_t q){
    return q.row > 7 || q.column > 7;
}

attack_status_t can_attack(position_t queen_1, position_t queen_2){
    
    if (invalid(queen_1) || invalid(queen_2) || 
        (queen_1.row == queen_2.row && queen_1.column == queen_2.column)) 
        return INVALID_POSITION;
    
    else if (queen_1.row == queen_2.row || queen_1.column == queen_2.column ||
       queen_1.row - queen_2.row == queen_1.column - queen_2.column ||
       queen_1.row - queen_2.row == queen_2.column - queen_1.column)
        return CAN_ATTACK;
    
    else return CAN_NOT_ATTACK;
}