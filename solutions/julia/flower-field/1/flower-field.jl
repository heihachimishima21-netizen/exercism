function flower!(arr, x, y, h, l)
    for i = x-1:x+1, j = y-1:y+1
        if 1 <= i <= h && 1 <= j <= l && arr[i][j] != '*'
            arr[i][j] += 1
        end
    end
end

function annotate(arr)
    h = length(arr)
    l = h != 0 ? length(arr[1]) : 0
    arr = collect.(arr)
    for i = 1:h, j = 1:l
        arr[i][j] == '*' ? flower!(arr, i, j, h, l) : (arr[i][j] += 16)
    end
    for i = 1:h, j = 1:l
        arr[i][j] == '0' && (arr[i][j] = ' ')
    end
    arr = join.(arr)
end