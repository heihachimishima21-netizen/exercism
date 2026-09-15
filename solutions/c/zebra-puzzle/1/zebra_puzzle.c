#include "zebra_puzzle.h"

const char *nationalities[] = {
    "Englishman",
    "Spaniard",
    "Ukrainian",
    "Norwegian",
    "Japanese"
};

bool check6(int houses[5][6])
{
    int ivory_house_no = -1;
    for (int house = 0; house < 5; house++)
        if (houses[house][COLOUR] == IVORY)
            ivory_house_no = houses[house][HOUSE_NUMBER];
    if (ivory_house_no == -1)
        return false;
    if (ivory_house_no == 5 || houses[ivory_house_no][COLOUR] != GREEN) //6
        return false;
    return true;
}

bool check(int houses[5][6])
{
    int reader_house_no, fox_house_no, painter_house_no, horse_house_no;
    reader_house_no = fox_house_no = painter_house_no = horse_house_no = -1;
    for (int house = 0; house < 5; house++){
        if (houses[house][HOBBY] == READING)
            reader_house_no = houses[house][HOUSE_NUMBER];
        if (houses[house][PET] == FOX)
            fox_house_no = houses[house][HOUSE_NUMBER];
        if (houses[house][HOBBY] == PAINTING)
            painter_house_no = houses[house][HOUSE_NUMBER];
        if (houses[house][PET] == HORSE)
            horse_house_no = houses[house][HOUSE_NUMBER];
    }
    if (reader_house_no != -1 && fox_house_no != -1 && 
        abs(reader_house_no - fox_house_no) != 1) //11
        return false;
    if (painter_house_no != -1 && horse_house_no != -1 && 
        abs(painter_house_no - horse_house_no) != 1) //12
        return false;
    return true;
}

bool set(int row, int column, int entry, int houses[5][6])
{
    houses[row][column] = entry;
    int nationality = houses[row][NATIONALITY];
    int colour      = houses[row][COLOUR];
    int pet         = houses[row][PET];
    int hobby       = houses[row][HOBBY];
    int beverage    = houses[row][BEVERAGE];
    if (nationality == ENGLISHMAN && colour != -1 && colour != RED)//2
        return false;
    if (colour == RED && nationality != -1 && nationality != ENGLISHMAN)
        return false;
    if (nationality == SPANIARD && pet != -1 && pet != DOG) //3
        return false;
    if (pet == DOG && nationality != -1 && nationality != SPANIARD)
        return false;
    if (colour == GREEN && beverage != -1 && beverage != COFFEE) //4
        return false;
    if (beverage == COFFEE && colour != -1 && colour != GREEN)
        return false;
    if (nationality == UKRAINIAN && beverage != -1 && beverage != TEA) //5
        return false;
    if (beverage == TEA && nationality != -1 && nationality != UKRAINIAN)
        return false;
    if (pet == SNAILS && hobby != -1 && hobby != DANCING) //7
        return false;
    if (hobby == DANCING && pet != -1 && pet != SNAILS)
        return false;
    if (colour == YELLOW && hobby != -1 && hobby != PAINTING) //8
        return false;
    if (hobby == PAINTING && colour != -1 && colour != YELLOW)
        return false;
    if (hobby == FOOTBALL && beverage != -1 && beverage != ORANGE_JUICE) //13
        return false;
    if (beverage == ORANGE_JUICE && hobby != -1 && hobby != FOOTBALL)
        return false;
    if (nationality == JAPANESE && hobby != -1 && hobby != CHESS) //14
        return false;
    if (hobby == CHESS && nationality != -1 && nationality != JAPANESE)
        return false;
    return true;
}

bool solve(int slot, int houses[5][6])
{
    if (slot == 30)
        return true;
    if(slot == 15 && !check6(houses))
        return false;
    if(slot == 25 && !check(houses))
        return false;
    int row = slot % 5, column = slot / 5;
    if (houses[row][column] != -1)
        return solve(slot + 1, houses);
    for (int entry = 0; entry < 5; entry++){
        bool taken = false;
        for (int other = 0; other < 5; other++){
            if (other == row) 
                continue;
            if (houses[other][column] == entry)
                taken = true;
        }
        if (taken)
            continue;
        if (!set(row, column, entry, houses)){
            houses[row][column] = -1;
            continue;
        }
        if (solve(slot + 1, houses))
            return true;
        houses[row][column] = -1;
    }
    return false;
}

solution_t solve_puzzle(void)
{
    solution_t output = {NULL};
    int houses[5][6];
    for (int i = 0; i < 5; i++){
        houses[i][HOUSE_NUMBER] = i + 1;
        for (int j = NATIONALITY; j <= BEVERAGE; j++)
            houses[i][j] = -1;
    }
    houses[THIRD - 1][BEVERAGE] = MILK; //9
    houses[FIRST - 1][NATIONALITY] = NORWEGIAN; //10
    houses[SECOND - 1][COLOUR] = BLUE; //15
    solve(0, houses);
    for (int i = 0; i < 5; i++){
        if (houses[i][BEVERAGE] == WATER)
            output.drinks_water = nationalities[houses[i][NATIONALITY]];
        if (houses[i][PET] == ZEBRA)
            output.owns_zebra = nationalities[houses[i][NATIONALITY]];
    }
    return output;
}