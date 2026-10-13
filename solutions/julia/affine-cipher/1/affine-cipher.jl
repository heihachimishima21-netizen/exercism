affine(c, a, b) = (isletter(c)) ? 'a' + mod(a * (c - 'a') + b, 26) :  c

decrypt(c, a, b) = (isletter(c)) ? 'a' + mod(invmod(a, 26) * ((c - 'a') - b), 26) : c

function encode(plaintext, a, b)
    gcd(a, 26) != 1 && throw(ArgumentError(""))
    encoded = (affine(lowercase(c), a, b) for c in plaintext if isletter(c) || isnumeric(c))
    replace(join(encoded), r"(.{5})(?=.)" => s"\1 ")
end

function decode(ciphertext, a, b)
    gcd(a, 26) != 1 && throw(ArgumentError(""))
    decoded = (decrypt(c, a, b) for c in ciphertext if !isspace(c)) |> join
end