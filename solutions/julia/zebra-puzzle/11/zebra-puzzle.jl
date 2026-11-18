@enum Property    COLOUR     = 1  BEVERAGE  HOBBY      NATIONALITY   PET
@enum Colour      RED        = 1  GREEN     IVORY      YELLOW        BLUE
@enum Nationality ENGLISHMAN = 1  SPANIARD  UKRAINIAN  NORWEGIAN     JAPANESE
@enum Pet         DOG        = 1  SNAILS    FOX        HORSE         ZEBRA
@enum Beverage    COFFEE     = 1  TEA       MILK       ORANGE_JUICE  WATER
@enum Hobby       DANCING    = 1  PAINTING  READING    FOOTBALL      CHESS

const NUM_HOUSES = 5
const NUM_PROPERTIES = Int(PET)
const UNSET = 0
const COLOUR_END = NUM_HOUSES * Int(COLOUR)
const COMPLETE = NUM_HOUSES * NUM_PROPERTIES

const PuzzleResult = NamedTuple{(:water, :zebra), Tuple{String, String}}
const CACHE        = Ref{Union{Nothing, PuzzleResult}}(nothing)

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
            house < NUM_HOUSES && houses[house + 1, Int(COLOUR)] == Int(GREEN) && return true  #6
        end
    end
    false
end

test_conflict(prop1, val1, prop2, val2) = prop1 != UNSET && prop2 != UNSET && (prop1 == val1) != (prop2 == val2)

function set_and_test_entry(row, column, entry, houses)
    houses[row, column] = entry                             # setting entry to test

    colour      = houses[row, Int(COLOUR)     ]
    beverage    = houses[row, Int(BEVERAGE)   ]
    hobby       = houses[row, Int(HOBBY)      ]
    nationality = houses[row, Int(NATIONALITY)]
    pet         = houses[row, Int(PET)        ]

    if     column == Int(BEVERAGE)
        test_conflict(colour     , Int(GREEN)     , beverage, Int(COFFEE)      ) && return false    # 4
    elseif column == Int(HOBBY)
        test_conflict(colour     , Int(YELLOW)    , hobby   , Int(PAINTING)    ) && return false    # 8
        test_conflict(hobby      , Int(FOOTBALL)  , beverage, Int(ORANGE_JUICE)) && return false    # 13
    elseif column == Int(NATIONALITY)
        test_conflict(nationality, Int(ENGLISHMAN), colour  , Int(RED)         ) && return false    # 2
        test_conflict(nationality, Int(UKRAINIAN) , beverage, Int(TEA)         ) && return false    # 5
        test_conflict(nationality, Int(JAPANESE)  , hobby   , Int(CHESS)       ) && return false    # 14
    elseif column == Int(PET)
        test_conflict(nationality, Int(SPANIARD)  , pet     , Int(DOG)         ) && return false    # 3
        test_conflict(pet        , Int(SNAILS)    , hobby   , Int(DANCING)     ) && return false    # 7
        
        if     entry == Int(FOX)
            row > 1          && houses[row - 1, Int(HOBBY)] == Int(READING)  ||
            row < NUM_HOUSES && houses[row + 1, Int(HOBBY)] == Int(READING)  || return false        # 11
        elseif entry == Int(HORSE)
            row > 1          && houses[row - 1, Int(HOBBY)] == Int(PAINTING) ||
            row < NUM_HOUSES && houses[row + 1, Int(HOBBY)] == Int(PAINTING) || return false        # 12
        end
        
    end

    true
end

function taken(column, entry, houses)
    for house in 1:NUM_HOUSES
        houses[house, column] == entry && return true
    end
    false
end

function solve(slot, houses)
    slot == COMPLETE                         && return true

    slot == COLOUR_END && !check_6(houses)   && return false

    row    = slot % NUM_HOUSES + 1
    column = slot ÷ NUM_HOUSES + 1

    houses[row, column] != UNSET             && return solve(slot + 1, houses)

    for entry in 1:NUM_HOUSES

        taken(column, entry, houses) && continue

        set_and_test_entry(row, column, entry, houses) && solve(slot + 1, houses) && return true

        houses[row, column] = UNSET
    end

    false
end

get_solution() = (CACHE[] === nothing && (CACHE[] = solve_puzzle()); CACHE[]::PuzzleResult)

function solve_puzzle()
    drinks_water = owns_zebra = nothing
    houses = fill(UNSET, NUM_HOUSES, NUM_PROPERTIES)

    houses[3, Int(BEVERAGE)   ] = Int(MILK)          #9
    houses[1, Int(NATIONALITY)] = Int(NORWEGIAN)     #10
    houses[2, Int(COLOUR)     ] = Int(BLUE)          #15

    solve(0, houses)

    for house in 1:NUM_HOUSES
        houses[house, Int(BEVERAGE)] == Int(WATER) && (drinks_water = NATIONALITIES[houses[house, Int(NATIONALITY)]])
        houses[house, Int(PET)     ] == Int(ZEBRA) && (owns_zebra   = NATIONALITIES[houses[house, Int(NATIONALITY)]])
    end

    (water=something(drinks_water), zebra=something(owns_zebra))
end

drinkswater() = get_solution().water
ownszebra()   = get_solution().zebra