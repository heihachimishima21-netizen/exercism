const BASES = ('I', 'X', 'C', 'M')
const FIVES = ('V', 'L', 'D')

function to_roman(n)
    if n <= 0 || n >= 4000;             throw(ErrorException("Out of range")); end
    numeral = ""
    for i in 3:-1:0
        if    n >=  9*10^i;   numeral *= BASES[1+i]*BASES[2+i];  n -=  9*10^i; end
        if    n >=  5*10^i;   numeral *=            FIVES[1+i];  n -=  5*10^i; end
        if    n >=  4*10^i;   numeral *= BASES[1+i]*FIVES[1+i];  n -=  4*10^i; end
        while n >=    10^i;   numeral *=            BASES[1+i];  n -=    10^i; end
    end
    numeral
end