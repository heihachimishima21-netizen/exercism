const ONGOING = :ongoing
const WIN     = :win
const LOSE    = :lose

mutable struct GuessingGame
    word     :: String
    letters  :: Set{Char}
    found    :: Set{Char}
    failures :: Int
end

new_game(word::String)   = GuessingGame(word, Set(word), Set{Char}(), 0)
masked_word(game)        = join(l ∈ game.found ? l : '_' for l in game.word)
remaining_failures(game) = max(0, 9 - game.failures)

function state(game)
    if game.letters ⊆ game.found
        WIN
    elseif game.failures == 10
        LOSE
    else
        ONGOING
    end
end

function guess!(game, letter)
    if state(game) == ONGOING
        if letter ∈ setdiff(game.letters, game.found)
            push!(game.found, letter)
        else
            game.failures += 1
        end
    else
        error()
    end
end