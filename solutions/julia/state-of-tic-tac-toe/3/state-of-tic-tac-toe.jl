const BOARD_LINES = tuple([ntuple(c -> (r, c), 3) for r in 1:3]..., [ntuple(r -> (r, c), 3) for c in 1:3]..., ntuple(i -> (i, i), 3), ntuple(i -> (i, 4 - i), 3))

win(mark, board) = any(all(board[i][j] == mark for (i, j) in line) for line in BOARD_LINES)

marks(board) = map(c -> count(==(c), join(board)), ('X', 'O', ' '))

function gamestate(board)
    diff = marks(board)[1] - marks(board)[2]
    diff ∉ (0, 1) && error("invalid")
    if win('X', board)
        isone(diff) && !win('O', board) ? (return "win") : error("invalid")
    elseif win('O', board)
        iszero(diff) && !win('X', board) ? (return "win") : error("invalid")
    end
    marks(board)[3] |> iszero && (return "draw")
    return "ongoing"
end