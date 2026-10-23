const ADJACENT = ((0,-1), (0,1), (-1,0), (1,0), (-1,1), (1,-1))

function connect(board)
    matrix = permutedims(reduce(hcat, collect.(replace.(board, " " => ""))))
    neighbours = [[(x+i, y+j) for (i, j) in ADJACENT
            if checkbounds(Bool, matrix, x+i, y+j)] for x in axes(matrix, 1), y in axes(matrix, 2)]
    result = ""
    @show matrix[1, :] matrix[:, 1]
    O_neighbours, X_neighbours = filter.(x -> matrix[x...] == 'O', neighbours), filter.(x -> matrix[x...] == 'X', neighbours)
    for j in axes(matrix, 2)
        if matrix[1, j] == 'O'
            current = [(1, j)]
           # @show (1, j, matrix[1, j])
            function recur1(x, y)
                if x == size(matrix, 1)
                    return true
                elseif isempty(setdiff(O_neighbours[x, y], current)) ###
                    return false
                end
                #@show (x, y)
                for neighbour in O_neighbours[x, y]
                    #@show neighbour
                    if matrix[neighbour...] == 'O' && neighbour ∉ current
                        push!(current, neighbour)
                     #   @show current
                        recur1(neighbour...) && return true
                        pop!(current)         
                  #      @show current
                    end
                end
                false
            end
            if recur1(1, j)
                result *= "O"
                break
            end
        end
    end

    for i in axes(matrix, 1)
        if matrix[i, 1] == 'X'
            current = [(i, 1)]
            @show current
           # @show (1, j, matrix[1, j])
            
            function recur2(x, y)
                if y == size(matrix, 2)
                    return true
                elseif isempty(setdiff(X_neighbours[x, y], current))####
                    return false
                end
                #@show (x, y)
                for neighbour in X_neighbours[x, y]
                    @show neighbour
                    if matrix[neighbour...] == 'X' && neighbour ∉ current
                        push!(current, neighbour)
                        @show current
                        recur2(neighbour...) && return true
                        pop!(current)         
                        @show current
                    end
                end
                false
            end
            
            if recur2(i, 1)
                result *= "X"
                break
            end
        end
    end











    
    result
end