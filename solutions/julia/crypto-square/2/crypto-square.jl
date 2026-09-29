ciphertext(plaintext) = begin
    norm = filter(x -> isletter(x) || isnumeric(x), lowercase(plaintext))
    len = length(norm)
    c = isqrt(len)
    if c^2 != len
        if len <= c * (c+1) ;  r, c = c, c + 1
        else                   r, c = c + 1, c + 1 ; end
    else r = c; end
    arr = reshape(collect(rpad(norm, r*c)), c, r)
    join([String(row) for row in eachrow(arr)], ' ')
end