#include "zebra_puzzle.h"

static const char *const nationalities[] = {
    "Englishman",
    "Spaniard",
    "Ukrainian",
    "Norwegian",
    "Japanese"
};

static bool check_6(int houses[5][6])
{
    int ivory_house_no;
    for (int house = 0; house < 5; house++)
        if (houses[house][COLOUR] == IVORY)
            {ivory_house_no = houses[house][HOUSE_NUMBER]; break;}
    if (ivory_house_no == 5 || houses[ivory_house_no][COLOUR] != GREEN)    return false;  //6
    
    return true;
}

static bool check_11_12(int houses[5][6])
{
    int reader_house_no, fox_house_no, painter_house_no, horse_house_no;
    reader_house_no = fox_house_no = painter_house_no = horse_house_no = UNSET;
    for (int house = 0; house < 5; house++){
        if (houses[house][HOBBY] == READING)    reader_house_no  = houses[house][HOUSE_NUMBER];
        if (houses[house][PET]   == FOX)        fox_house_no     = houses[house][HOUSE_NUMBER];
        if (houses[house][HOBBY] == PAINTING)   painter_house_no = houses[house][HOUSE_NUMBER];
        if (houses[house][PET]   == HORSE)      horse_house_no   = houses[house][HOUSE_NUMBER];
    }
    if (reader_house_no  != UNSET && fox_house_no   != UNSET && 
        abs(reader_house_no  - fox_house_no)   != 1)                  return false;    //11
    if (painter_house_no != UNSET && horse_house_no != UNSET && 
        abs(painter_house_no - horse_house_no) != 1)                  return false;    //12
    
    return true;
}

static bool test_conflict(int prop1, int val1, int prop2, int val2)
{
    if (prop1 == val1 && prop2 != UNSET && prop2 != val2)   return true;
    if (prop2 == val2 && prop1 != UNSET && prop1 != val1)   return true;
    
    return false;
}

static bool set_and_test_entry(int row, int column, int entry, int houses[5][6])
{
    houses[row][column] = entry;                                         // setting entry to test
    
    int colour      = houses[row][COLOUR];
    int nationality = houses[row][NATIONALITY];
    int beverage    = houses[row][BEVERAGE];
    int hobby       = houses[row][HOBBY];
    int pet         = houses[row][PET];

    if (test_conflict(nationality, ENGLISHMAN, colour  , RED))            return false;    // 2
    if (test_conflict(nationality, SPANIARD  , pet     , DOG))            return false;    // 3
    if (test_conflict(colour     , GREEN     , beverage, COFFEE))         return false;    // 4
    if (test_conflict(nationality, UKRAINIAN , beverage, TEA))            return false;    // 5
    if (test_conflict(pet        , SNAILS    , hobby   , DANCING))        return false;    // 7
    if (test_conflict(colour     , YELLOW    , hobby   , PAINTING))       return false;    // 8
    if (test_conflict(hobby      , FOOTBALL  , beverage, ORANGE_JUICE))   return false;    // 13
    if (test_conflict(nationality, JAPANESE  , hobby   , CHESS))          return false;    // 14

    if ((column == HOBBY || column == PET) && !check_11_12(houses))       return false;   // 11, 12
        
    return true;
}

static bool taken(int column, int entry, int houses[5][6])
{
    for (int house = 0; house < 5; house++)
        if (houses[house][column] == entry)   return true;
    return false;
}


static bool solve(int slot, int houses[5][6])
{
    if (slot == COMPLETE)
        return true;
    
    if(slot == COLOUR_END && !check_6(houses))
        return false;

    int row = slot % 5, column = slot / 5;
    
    if (houses[row][column] != UNSET)
        return solve(slot + 1, houses);
    
    for (int entry = 0; entry < 5; entry++){
        
        if (taken(column, entry, houses))
            continue;
        
        if (set_and_test_entry(row, column, entry, houses) && solve(slot + 1, houses))
            return true;
        
        houses[row][column] = UNSET;
    }
    
    return false;
}

solution_t solve_puzzle(void)
{
    solution_t output = {NULL};
    int houses[5][6];
    for (int i = 0; i < 5; i++){
        houses[i][HOUSE_NUMBER] = i + 1;
        for (int j = COLOUR; j <= PET; j++)
            houses[i][j] = UNSET;
    }
    
    houses[THIRD  - 1][BEVERAGE]    = MILK;         //9
    houses[FIRST  - 1][NATIONALITY] = NORWEGIAN;    //10
    houses[SECOND - 1][COLOUR]      = BLUE;         //15
    
    solve(0, houses);
    
    for (int i = 0; i < 5; i++){
        if (houses[i][BEVERAGE] == WATER)
            output.drinks_water = nationalities[houses[i][NATIONALITY]];
        if (houses[i][PET] == ZEBRA)
            output.owns_zebra = nationalities[houses[i][NATIONALITY]];
    }
    return output;
}