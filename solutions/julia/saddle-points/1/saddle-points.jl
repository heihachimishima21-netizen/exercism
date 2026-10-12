function saddlepoints(M)
    isempty(M) ? (return []) : (saddles = [])
    for row in axes(M, 1), col in axes(M, 2)
        M[row, col] == maximum(M[row, :]) == minimum(M[:, col]) && push!(saddles, (row, col))
    end
    saddles
end