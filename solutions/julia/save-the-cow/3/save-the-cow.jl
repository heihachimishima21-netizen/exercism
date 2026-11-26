const ONGOING, WIN, LOSE = :ongoing, :win, :lose

mutable struct GuessingGame
    word     :: String
    letters  :: Set{Char}
    found    :: Set{Char}
    failures :: Int
    GuessingGame(word::String) = new(word, Set(word), Set{Char}(), 0)
end

new_game                               = GuessingGame
masked_word(game::GuessingGame)        = join(l ∈ game.found ? l : '_' for l in game.word)
remaining_failures(game::GuessingGame) = max(0, 9 - game.failures)
state(game::GuessingGame)              = game.letters ⊆ game.found ? WIN : game.failures == 10 ? LOSE : ONGOING

function guess!(game::GuessingGame, letter::Char)
    if state(game) == ONGOING
        letter ∈ setdiff(game.letters, game.found) ? push!(game.found, letter) : game.failures += 1
    else
        error()
    end
end