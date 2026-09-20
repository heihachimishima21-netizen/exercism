function rotate(n, str)
    cipher = []
    for char in str
        if isuppercase(char)
            push!(cipher, 'A' + (n + char - 'A') % 26)
        elseif islowercase(char)
            push!(cipher, 'a' + (n + char - 'a') % 26)
        else
            push!(cipher, char)
        end
    end
    str isa Char ? cipher[1] : join(cipher)     
end