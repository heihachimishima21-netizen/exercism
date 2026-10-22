function rectangles(str)
    rows, cols, rectangles = length(str), isempty(str) ? 0 : length(str[begin]), 0
    for i in 1:rows, j in 1:cols
        if str[i][j] == '+'
            for x in i+1:rows, y in j+1:cols
                if str[i][y] == '+' && str[x][j] == '+' && str[x][y] == '+'
                    horizontal = all(k -> str[i][k] in "-+" && str[x][k] in "-+", j+1:y-1)
                    vertical   = all(k -> str[k][j] in "|+" && str[k][y] in "|+", i+1:x-1)
                    horizontal && vertical && (rectangles += 1)
                end
            end
        end
    end
    rectangles
end