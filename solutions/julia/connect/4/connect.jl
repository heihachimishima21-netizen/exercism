const ADJACENT = ((0,-1), (0,1), (-1,0), (1,0), (-1,1), (1,-1))

function connect(board)
    
    matrix = hcat(collect.(replace.(board, " " => ""))...) |> permutedims
    
    neighbours = [[(x+dx, y+dy) for (dx, dy) in ADJACENT if checkbounds(Bool, matrix, x+dx, y+dy)] for x in axes(matrix, 1), y in axes(matrix, 2)]
    
    O_neighbours, X_neighbours = filter.(x -> matrix[x...] == 'O', neighbours), filter.(x -> matrix[x...] == 'X', neighbours)

    result, current = "", Tuple{Int,Int}[]

    function recur(x, y, stone_neighbours, win)
        
        if win(x, y)
            return true
        elseif isempty(setdiff(stone_neighbours[x, y], current))
            return false
        end
        
        for neighbour in stone_neighbours[x, y]
            if neighbour ∉ current
                push!(current, neighbour)
                recur(neighbour..., stone_neighbours, win) && return true
                pop!(current)         
            end
        end
        
        false
    end

    for j in axes(matrix, 2)
        if matrix[1, j] == 'O'
            current = [(1, j)]
            if recur(1, j, O_neighbours, (x, y) -> x == size(matrix, 1))
                result *= "O"
                break
            end
        end
    end
    
    for i in axes(matrix, 1)
        if matrix[i, 1] == 'X'
            current = [(i, 1)]
            if recur(i, 1, X_neighbours, (x, y) -> y == size(matrix, 2))
                result *= "X"
                break
            end
        end
    end
    
    result
end