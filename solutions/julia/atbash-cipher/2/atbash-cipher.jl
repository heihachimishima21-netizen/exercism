convert(ch) = isletter(ch) ? Char(Int('a') + Int('z') - Int(ch)) : ch

function encode(input)
    code = [convert(lowercase(char)) for char in input if isletter(char) || isdigit(char)]
    join(Iterators.partition(join(code), 5), ' ')
end

decode(input) = join(convert(char) for char in input if !(isspace(char)))