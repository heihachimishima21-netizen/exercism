#include "zebra_puzzle.h"

static const char *const nationalities[] = {
    "Englishman",
    "Spaniard",
    "Ukrainian",
    "Norwegian",
    "Japanese"
};

static bool check_6(int houses[NUM_HOUSES][NUM_PROPERTIES])
{
    for (int house = 0; house < NUM_HOUSES; house++)
        if (houses[house][COLOUR] == IVORY)
            if (house < NUM_HOUSES - 1 && houses[house + 1][COLOUR] == GREEN)    return true;    //6
    return false;
}

static bool check_11_12(int houses[NUM_HOUSES][NUM_PROPERTIES])
{
    int reader_house, fox_house, painter_house, horse_house;
    reader_house = fox_house = painter_house = horse_house = UNSET;
    for (int house = 0; house < NUM_HOUSES; house++){
        if (houses[house][HOBBY] == READING)    reader_house  = house;
        if (houses[house][PET]   == FOX)        fox_house     = house;
        if (houses[house][HOBBY] == PAINTING)   painter_house = house;
        if (houses[house][PET]   == HORSE)      horse_house   = house;
    }
    if (reader_house  != UNSET && fox_house   != UNSET && abs(reader_house  - fox_house)   != 1)                  return false;    //11
    if (painter_house != UNSET && horse_house != UNSET && abs(painter_house - horse_house) != 1)                  return false;    //12
    
    return true;
}

static bool test_conflict(int property1, int value1, int property2, int value2)
{
    return property1 != UNSET && property2 != UNSET && (property1 == value1) != (property2 == value2);
}

static bool set_and_test_entry(int row, int column, int entry, int houses[NUM_HOUSES][NUM_PROPERTIES])
{
    houses[row][column] = entry;                                         // setting entry to test
    
    int colour      = houses[row][COLOUR];
    int beverage    = houses[row][BEVERAGE];
    int hobby       = houses[row][HOBBY];
    int nationality = houses[row][NATIONALITY];
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

static bool taken(int column, int entry, int houses[NUM_HOUSES][NUM_PROPERTIES])
{
    for (int house = 0; house < NUM_HOUSES; house++)
        if (houses[house][column] == entry)   return true;
    return false;
}


static bool solve(int slot, int houses[NUM_HOUSES][NUM_PROPERTIES])
{
    if (slot == COMPLETE)
        return true;
    
    if(slot == COLOUR_END && !check_6(houses))
        return false;

    int row = slot % NUM_HOUSES, column = slot / NUM_HOUSES;
    
    if (houses[row][column] != UNSET)
        return solve(slot + 1, houses);
    
    for (int entry = 0; entry < NUM_HOUSES; entry++){
        
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
    int houses[NUM_HOUSES][NUM_PROPERTIES];
    for (int house = 0; house < NUM_HOUSES; house++){
        for (int j = COLOUR; j <= PET; j++)
            houses[house][j] = UNSET;
    }
    
    houses[3 - 1][BEVERAGE]    = MILK;         //9
    houses[1 - 1][NATIONALITY] = NORWEGIAN;    //10
    houses[2 - 1][COLOUR]      = BLUE;         //15
    
    solve(0, houses);
    
    for (int house = 0; house < NUM_HOUSES; house++){
        if (houses[house][BEVERAGE] == WATER)
            output.drinks_water = nationalities[houses[house][NATIONALITY]];
        if (houses[house][PET]      == ZEBRA)
            output.owns_zebra   = nationalities[houses[house][NATIONALITY]];
    }
    return output;
}