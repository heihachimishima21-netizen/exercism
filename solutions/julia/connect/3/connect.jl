const ADJACENT = ((0,-1), (0,1), (-1,0), (1,0), (-1,1), (1,-1))

function connect(board)
    matrix = permutedims(reduce(hcat, collect.(replace.(board, " " => ""))))
    
    neighbours = [[(x+i, y+j) for (i, j) in ADJACENT if checkbounds(Bool, matrix, x+i, y+j)] for x in axes(matrix, 1), y in axes(matrix, 2)]
    
    result, current = "", Tuple{Int,Int}[]
    
    O_neighbours, X_neighbours = filter.(x -> matrix[x...] == 'O', neighbours), filter.(x -> matrix[x...] == 'X', neighbours)

    function recur1(x, y)
        if x == size(matrix, 1)
            return true
        elseif isempty(setdiff(O_neighbours[x, y], current))
            return false
        end
        
        for neighbour in O_neighbours[x, y]
            if matrix[neighbour...] == 'O' && neighbour ∉ current
                push!(current, neighbour)
                recur1(neighbour...) && return true
                pop!(current)         
            end
        end
        
        false
    end

    

    function recur2(x, y)
        if y == size(matrix, 2)
            return true
        elseif isempty(setdiff(X_neighbours[x, y], current))
            return false
        end
        
        for neighbour in X_neighbours[x, y]
            if matrix[neighbour...] == 'X' && neighbour ∉ current
                push!(current, neighbour)
                recur2(neighbour...) && return true
                pop!(current)         
            end
        end
        
        false
    end

    for j in axes(matrix, 2)
        if matrix[1, j] == 'O'
            current = [(1, j)]
            if recur1(1, j)
                result *= "O"
                break
            end
        end
    end
    
    for i in axes(matrix, 1)
        if matrix[i, 1] == 'X'
            current = [(i, 1)]
            if recur2(i, 1)
                result *= "X"
                break
            end
        end
    end
    
    result
end