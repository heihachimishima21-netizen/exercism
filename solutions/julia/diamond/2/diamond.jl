function string(letter, size, row)
    string = fill(' ', size)
    mid = (size + 1) ÷ 2
    adj = row <= mid ? row - 1 : size - row
    string[mid + adj] = 'A' + adj
    string[mid - adj] = 'A' + adj
    join(string)
end

function rows(letter)
    size = 2*(letter[1] - 'A') + 1
    [string(letter, size, row) for row in 1:size]
end