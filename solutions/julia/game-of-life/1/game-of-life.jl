const COORDINATES = ((x, y) for x in -1:1, y in -1:1 if x != 0 || y != 0)

neighbours(M, i, j) = [M[i+x, j+y] for (x, y) in COORDINATES if checkbounds(Bool, M, i+x, j+y)] |> sum

function gameoflife(M)
    new = zeros(Int, size(M, 1), size(M, 2))
    for i in axes(M, 1), j in axes(M, 2)
        live = neighbours(M, i, j)
        new[i, j] = Int((M[i, j] == 1 && live == 2) || live == 3)
    end
    new
end