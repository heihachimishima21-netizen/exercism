const BASES = ('I', 'X', 'C', 'M')
const FIVES = ('V', 'L', 'D')

function to_roman(n)
    if n <= 0 || n >= 4000;        throw(ErrorException("Out of range")); end
    numeral, m = "", 1000
    for i in 4:-1:1
        if       n >=  9*m;   numeral *= BASES[i]*BASES[1+i];  n -=  9*m; end
        if       n >=  5*m;   numeral *=            FIVES[i];  n -=  5*m; end
        if       n >=  4*m;   numeral *=   BASES[i]*FIVES[i];  n -=  4*m; end
        while    n >=    m;   numeral *=            BASES[i];  n -=    m; end
        m /= 10;
    end
    numeral
end