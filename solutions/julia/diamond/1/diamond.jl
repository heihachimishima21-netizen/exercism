function rows(letter)
    diamond = []
    size = 2*(letter[1] - 'A') + 1
    for row in 1:size
        string = fill(' ', size)
        mid = (size + 1) ÷ 2
        adj = row <= mid ? row - 1 : size - row
        string[mid + adj] = 'A' + adj
        string[mid - adj] = 'A' + adj
        push!(diamond, join(string))
    end
    diamond
end