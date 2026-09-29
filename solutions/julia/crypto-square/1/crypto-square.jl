function ciphertext(plaintext)
    norm = filter(x -> isletter(x) || isnumeric(x), lowercase(plaintext))
    l = length(norm)
    c = trunc(Int, sqrt(l))
    if c^2 != l
        if l <= c * (c+1) ;  r, c = c, c + 1
        else                 r, c = c + 1, c + 1
        end
    else r = c
    end
    arr = reshape(collect(rpad(norm, r*c)), c, r)
    join([String(arr[i, :]) for i in 1:c], ' ')
end