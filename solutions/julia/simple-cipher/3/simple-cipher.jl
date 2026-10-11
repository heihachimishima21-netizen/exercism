generate_key() = String(rand('a':'z', 100))

function encode(plaintext, key)
    code = Vector{Char}()
    key_len = length(key)
    for (idx, letter) in enumerate(plaintext)
        cycle = key[1 + (idx - 1) % key_len] - 'a'
        new_letter = 'a' + mod(cycle + letter - 'a', 26)
        push!(code, new_letter)
    end
    String(code)
end

function decode(ciphertext, key)
    code = Vector{Char}()
    key_len = length(key)
    for (idx, letter) in enumerate(ciphertext)
        cycle = key[1 + (idx - 1) % key_len] - 'a'
        new_letter = 'a' + mod(-cycle + letter - 'a', 26)
        push!(code, new_letter)
    end
    String(code)
end