convert(ch) = isletter(ch) ? Char(Int('a') + Int('z') - Int(ch)) : ch

function encode(input)
    code = Char[]
    for ch in input
        if isletter(ch) || isdigit(ch)
            push!(code, convert(lowercase(ch)))
        end
    end
    join(Iterators.partition(join(code), 5), ' ')
end

function decode(input)
    join(convert(char) for char in input if !(isspace(char)))
end