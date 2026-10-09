const L = ('I', 'V', 'X', 'L', 'C', 'D', 'M')

function to_roman(n)
    if    n <=    0;   throw(ErrorException(""));   end
    numeral = ""
    while n >= 1000;   numeral *=  L[7];  n -= 1000; end
    for i in 2:-1:0
        if    n >=  9*10^i;   numeral *= L[1+2i]*L[3+2i];  n -=  9*10^i; end
        if    n >=  5*10^i;   numeral *=         L[2+2i];  n -=  5*10^i; end
        if    n >=  4*10^i;   numeral *= L[1+2i]*L[2+2i];  n -=  4*10^i; end
        while n >=    10^i;   numeral *=         L[1+2i];  n -=    10^i; end
    end
    numeral
end