@enum Property COLOUR=0 BEVERAGE=1 HOBBY=2 NATIONALITY=3 PET=4

@enum Colour RED=0 GREEN=1 IVORY=2 YELLOW=3 BLUE=4

@enum Nationality ENGLISHMAN=0 SPANIARD=1 UKRAINIAN=2 NORWEGIAN=3 JAPANESE=4

@enum Pet DOG=0 SNAILS=1 FOX=2 HORSE=3 ZEBRA=4

@enum Beverage COFFEE=0 TEA=1 MILK=2 ORANGE_JUICE=3 WATER=4

@enum Hobby DANCING=0 PAINTING=1 READING=2 FOOTBALL=3 CHESS=4

const NUM_HOUSES = 5
const NUM_PROPERTIES = Int(PET) + 1
const UNSET = -1
const COLOUR_END = NUM_HOUSES * (Int(COLOUR) + 1)
const COMPLETE = NUM_HOUSES * NUM_PROPERTIES

const NATIONALITIES = (
    "Englishman",
    "Spaniard",
    "Ukrainian",
    "Norwegian",
    "Japanese"
)

function check_6(houses)
    for house in 1:NUM_HOUSES
        if houses[house, Int(COLOUR) + 1] == Int(IVORY)
            if house < NUM_HOUSES && houses[house + 1, Int(COLOUR) + 1] == Int(GREEN)
                return true    #6
            end
        end
    end
    return false
end

function check_11_12(houses)
    reader_house = fox_house = painter_house = horse_house = UNSET

    for house in 1:NUM_HOUSES
        if houses[house, Int(HOBBY) + 1] == Int(READING)     reader_house  = house end
        if houses[house, Int(PET) + 1]   == Int(FOX)         fox_house     = house end
        if houses[house, Int(HOBBY) + 1] == Int(PAINTING)    painter_house = house end
        if houses[house, Int(PET) + 1]   == Int(HORSE)       horse_house   = house end
    end

    if reader_house  != UNSET && fox_house   != UNSET && abs(reader_house  - fox_house)   != 1
        return false    #11
    end
    if painter_house != UNSET && horse_house != UNSET && abs(painter_house - horse_house) != 1
        return false    #12
    end

    return true
end

function test_conflict(property1, value1, property2, value2)
    return property1 != UNSET && property2 != UNSET &&
           (property1 == value1) != (property2 == value2)
end

function set_and_test_entry(row, column, entry, houses)
    houses[row + 1, column + 1] = entry    # setting entry to test

    colour      = houses[row + 1, Int(COLOUR) + 1]
    beverage    = houses[row + 1, Int(BEVERAGE) + 1]
    hobby       = houses[row + 1, Int(HOBBY) + 1]
    nationality = houses[row + 1, Int(NATIONALITY) + 1]
    pet         = houses[row + 1, Int(PET) + 1]

    if test_conflict(nationality, Int(ENGLISHMAN), colour, Int(RED))              return false    # 2
    end
    if test_conflict(nationality, Int(SPANIARD), pet, Int(DOG))                  return false    # 3
    end
    if test_conflict(colour, Int(GREEN), beverage, Int(COFFEE))                  return false    # 4
    end
    if test_conflict(nationality, Int(UKRAINIAN), beverage, Int(TEA))            return false    # 5
    end
    if test_conflict(pet, Int(SNAILS), hobby, Int(DANCING))                      return false    # 7
    end
    if test_conflict(colour, Int(YELLOW), hobby, Int(PAINTING))                  return false    # 8
    end
    if test_conflict(hobby, Int(FOOTBALL), beverage, Int(ORANGE_JUICE))           return false    # 13
    end
    if test_conflict(nationality, Int(JAPANESE), hobby, Int(CHESS))              return false    # 14
    end

    if (column == Int(HOBBY) || column == Int(PET)) && !check_11_12(houses)
        return false    # 11, 12
    end

    return true
end

function taken(column, entry, houses)
    for house in 1:NUM_HOUSES
        if houses[house, column + 1] == entry
            return true
        end
    end
    return false
end


function solve(slot, houses)
    if slot == COMPLETE
        return true
    end

    if slot == COLOUR_END && !check_6(houses)
        return false
    end

    row = slot % NUM_HOUSES
    column = slot ÷ NUM_HOUSES

    if houses[row + 1, column + 1] != UNSET
        return solve(slot + 1, houses)
    end

    for entry in 0:(NUM_HOUSES - 1)

        if taken(column, entry, houses)
            continue
        end

        if set_and_test_entry(row, column, entry, houses) && solve(slot + 1, houses)
            return true
        end

        houses[row + 1, column + 1] = UNSET
    end

    return false
end


function solve_puzzle()
    drinks_water = nothing
    owns_zebra = nothing

    houses = fill(UNSET, NUM_HOUSES, NUM_PROPERTIES)

    houses[3, Int(BEVERAGE) + 1]    = Int(MILK)         #9
    houses[1, Int(NATIONALITY) + 1] = Int(NORWEGIAN)    #10
    houses[2, Int(COLOUR) + 1]      = Int(BLUE)         #15

    solve(0, houses)

    for house in 1:NUM_HOUSES
        if houses[house, Int(BEVERAGE) + 1] == Int(WATER)
            drinks_water = NATIONALITIES[houses[house, Int(NATIONALITY) + 1] + 1]
        end
        if houses[house, Int(PET) + 1] == Int(ZEBRA)
            owns_zebra = NATIONALITIES[houses[house, Int(NATIONALITY) + 1] + 1]
        end
    end

    return (drinks_water=drinks_water, owns_zebra=owns_zebra)
end


function drinkswater()
    return solve_puzzle().drinks_water
end

function ownszebra()
    return solve_puzzle().owns_zebra
end