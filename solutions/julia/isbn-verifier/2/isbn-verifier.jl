struct ISBN
    number::String

    conv(digit::Char) = (digit == 'X') ? 10 : Int(digit - '0')

    function ISBN(code::String)
        c = eachmatch(r"([A-Za-z0-9])", code) |> collect .|> (m -> m.match) .|> only
        (length(c) != 10 || any(!isdigit(d) for d in c[1:9]) || !(isdigit(c[end]) || c[end] == 'X')) && throw(DomainError("Format fail"))
        validate = sum(d*i for (d, i) in zip(c .|> conv, 10:-1:1))
        mod(validate, 11) == 0 ? new(join(c)) : throw(DomainError("Validation fail"))
    end
end