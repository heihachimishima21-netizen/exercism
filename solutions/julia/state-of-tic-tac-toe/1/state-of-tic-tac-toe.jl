const BOARD_LINES = tuple([ntuple(c -> (r, c), 3) for r in 1:3]..., [ntuple(r -> (r, c), 3) for c in 1:3]..., ntuple(i -> (i, i), 3), ntuple(i -> (i, 4 - i), 3))

function win(mark, board)
    any(all(board[i][j] == mark for (i, j) in line) for line in BOARD_LINES)
end

function marks(board)
    map(c -> count(==(c), join(board)), ('X', 'O', ' '))
end

function gamestate(board)
    diff = marks(board)[1] - marks(board)[2]
    diff ∉ (0, 1) && error("")
    if win('X', board)
        diff == 1 && !win('O', board) ? (return "win") : error("")
    elseif win('O', board)
        diff == 0 && !win('X', board) ? (return "win") : error("")
    elseif marks(board)[3] |> iszero
        return "draw"
    else
        return "ongoing"
    end
end