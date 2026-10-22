function rectangles(strings)
    rows, cols, rectangles = length(strings), isempty(strings) ? 0 : length(strings[begin]), 0
    for i in 1:rows, j in 1:cols
        if strings[i][j] == '+'
            for x in i+1:rows, y in j+1:cols
                if strings[i][y] == strings[x][j] == strings[x][y] == '+'
                    horizontal = Set(strings[r][k] for r in (i, x) for k in j+1:y-1)
                    vertical   = Set(strings[k][r] for r in (j, y) for k in i+1:x-1)
                    horizontal ⊆ Set(['-', '+']) && vertical ⊆ Set(['|', '+']) && (rectangles += 1)
                end
            end
        end
    end
    rectangles
end