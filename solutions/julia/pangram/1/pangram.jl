function ispangram(input)
    bool_flags = Dict(letter => false for letter in 'a':'z')
    for char in input
        if isletter(char)
            bool_flags[lowercase(char)] = true
        end
    end
    false ∉ Set(values(bool_flags))
end