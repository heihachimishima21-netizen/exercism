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
            house < NUM_HOUSES && houses[house + 1, Int(COLOUR)] == Int(GREEN) && return true  #6
        end
    end
    false
end

function check_11_12(houses)
    reader_h = fox_h = painter_h = horse_h = UNSET

    for house in 1:NUM_HOUSES
        houses[house, Int(HOBBY)] == Int(READING)  && (reader_h  = house)
        houses[house, Int(PET)  ] == Int(FOX)      && (fox_h     = house)
        houses[house, Int(HOBBY)] == Int(PAINTING) && (painter_h = house)
        houses[house, Int(PET)  ] == Int(HORSE)    && (horse_h   = house)
    end

    reader_h  != UNSET && fox_h   != UNSET && abs(reader_h  - fox_h)   != 1 && return false    #11
    painter_h != UNSET && horse_h != UNSET && abs(painter_h - horse_h) != 1 && return false    #12
    
    true
end

test_conflict(prop1, val1, prop2, val2) = prop1 != UNSET && prop2 != UNSET && (prop1 == val1) != (prop2 == val2)

function set_and_test_entry(row, column, entry, houses)
    houses[row, column] = entry    # setting entry to test

    colour      = houses[row, Int(COLOUR)     ]
    beverage    = houses[row, Int(BEVERAGE)   ]
    hobby       = houses[row, Int(HOBBY)      ]
    nationality = houses[row, Int(NATIONALITY)]
    pet         = houses[row, Int(PET)        ]

    test_conflict(nationality, Int(ENGLISHMAN), colour  , Int(RED)         ) && return false    # 2
    test_conflict(nationality, Int(SPANIARD)  , pet     , Int(DOG)         ) && return false    # 3
    test_conflict(colour     , Int(GREEN)     , beverage, Int(COFFEE)      ) && return false    # 4
    test_conflict(nationality, Int(UKRAINIAN) , beverage, Int(TEA)         ) && return false    # 5
    test_conflict(pet        , Int(SNAILS)    , hobby   , Int(DANCING)     ) && return false    # 7
    test_conflict(colour     , Int(YELLOW)    , hobby   , Int(PAINTING)    ) && return false    # 8
    test_conflict(hobby      , Int(FOOTBALL)  , beverage, Int(ORANGE_JUICE)) && return false    # 13
    test_conflict(nationality, Int(JAPANESE)  , hobby   , Int(CHESS)       ) && return false    # 14

    column == Int(PET) && !check_11_12(houses)                               && return false    # 11, 12

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

#const CACHE = Ref{Any}(nothing)

const PuzzleResult = NamedTuple{(:water, :zebra), Tuple{String, String}}
const CACHE = Ref{Union{Nothing, PuzzleResult}}(nothing)

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

    #(water=drinks_water, zebra=owns_zebra)
    (water=something(drinks_water), zebra=something(owns_zebra))
end

drinkswater() = get_solution().water
ownszebra()   = get_solution().zebra