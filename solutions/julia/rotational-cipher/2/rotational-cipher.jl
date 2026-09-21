function rotate(n, str)
    cipher = [
    isuppercase(char) ? 'A' + (n + char - 'A') % 26 :
    islowercase(char)  ? 'a' + (n + char - 'a') % 26 :
    char
    for char in str
]
    str isa Char ? cipher[1] : join(cipher)     
end