function ispangram(input)
    bool_flags = Dict(letter => false for letter in 'a':'z')
    count = 0
    for char in input
        if isletter(char) && isascii(char) && bool_flags[lowercase(char)] == false
            bool_flags[lowercase(char)] = true
            count += 1
        end
        if count == 26 && return true; end
    end
    false
end