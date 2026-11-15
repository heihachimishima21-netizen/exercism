@enum Property    COLOUR     = 1  BEVERAGE     = 2  HOBBY     = 3  NATIONALITY  = 4  PET      = 5
@enum Colour      RED        = 1  GREEN        = 2  IVORY     = 3  YELLOW       = 4  BLUE     = 5
@enum Nationality ENGLISHMAN = 1  SPANIARD     = 2  UKRAINIAN = 3  NORWEGIAN    = 4  JAPANESE = 5
@enum Pet         DOG        = 1  SNAILS       = 2  FOX       = 3  HORSE        = 4  ZEBRA    = 5
@enum Beverage    COFFEE     = 1  TEA          = 2  MILK      = 3  ORANGE_JUICE = 4  WATER    = 5
@enum Hobby       DANCING    = 1  PAINTING     = 2  READING   = 3  FOOTBALL     = 4  CHESS    = 5

const NUM_HOUSES = 5
const NUM_PROPERTIES = Int(PET)
const UNSET = 0
const COLOUR_END = NUM_HOUSES * Int(COLOUR)
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
        if houses[house, Int(COLOUR)] == Int(IVORY)
            if house < NUM_HOUSES && houses[house + 1, Int(COLOUR)] == Int(GREEN)
                return true    #6
            end
        end
    end
    return false
end

function check_11_12(houses)
    reader_house = fox_house = painter_house = horse_house = UNSET

    for house in 1:NUM_HOUSES
        if houses[house, Int(HOBBY)] == Int(READING)
            reader_house = house
        end
        if houses[house, Int(PET)] == Int(FOX)
            fox_house = house
        end
        if houses[house, Int(HOBBY)] == Int(PAINTING)
            painter_house = house
        end
        if houses[house, Int(PET)] == Int(HORSE)
            horse_house = house
        end
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
    houses[row, column] = entry    # setting entry to test

    colour      = houses[row, Int(COLOUR)]
    beverage    = houses[row, Int(BEVERAGE)]
    hobby       = houses[row, Int(HOBBY)]
    nationality = houses[row, Int(NATIONALITY)]
    pet         = houses[row, Int(PET)]

    if test_conflict(nationality, Int(ENGLISHMAN), colour, Int(RED))
        return false    # 2
    end
    if test_conflict(nationality, Int(SPANIARD), pet, Int(DOG))
        return false    # 3
    end
    if test_conflict(colour, Int(GREEN), beverage, Int(COFFEE))
        return false    # 4
    end
    if test_conflict(nationality, Int(UKRAINIAN), beverage, Int(TEA))
        return false    # 5
    end
    if test_conflict(pet, Int(SNAILS), hobby, Int(DANCING))
        return false    # 7
    end
    if test_conflict(colour, Int(YELLOW), hobby, Int(PAINTING))
        return false    # 8
    end
    if test_conflict(hobby, Int(FOOTBALL), beverage, Int(ORANGE_JUICE))
        return false    # 13
    end
    if test_conflict(nationality, Int(JAPANESE), hobby, Int(CHESS))
        return false    # 14
    end

    if (column == Int(HOBBY) || column == Int(PET)) && !check_11_12(houses)
        return false    # 11, 12
    end

    return true
end

function taken(column, entry, houses)
    for house in 1:NUM_HOUSES
        if houses[house, column] == entry
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

    row = slot % NUM_HOUSES + 1
    column = slot ÷ NUM_HOUSES + 1

    if houses[row, column] != UNSET
        return solve(slot + 1, houses)
    end

    for entry in 1:NUM_HOUSES

        if taken(column, entry, houses)
            continue
        end

        if set_and_test_entry(row, column, entry, houses) && solve(slot + 1, houses)
            return true
        end

        houses[row, column] = UNSET
    end

    return false
end


function solve_puzzle()
    drinks_water = nothing
    owns_zebra = nothing

    houses = fill(UNSET, NUM_HOUSES, NUM_PROPERTIES)

    houses[3, Int(BEVERAGE)]    = Int(MILK)         #9
    houses[1, Int(NATIONALITY)] = Int(NORWEGIAN)    #10
    houses[2, Int(COLOUR)]      = Int(BLUE)          #15

    solve(0, houses)

    for house in 1:NUM_HOUSES
        if houses[house, Int(BEVERAGE)] == Int(WATER)
            drinks_water = NATIONALITIES[houses[house, Int(NATIONALITY)]]
        end
        if houses[house, Int(PET)] == Int(ZEBRA)
            owns_zebra = NATIONALITIES[houses[house, Int(NATIONALITY)]]
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