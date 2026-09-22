function to_roman(n)
    if    n <= 0;    throw(ErrorException(""));    end
    numeral = ""
    while n >= 1000; numeral *= "M";  n -= 1000; end
    if    n >= 900;  numeral *= "CM"; n -= 900;  end
    if    n >= 500;  numeral *= "D";  n -= 500;  end
    if    n >= 400;  numeral *= "CD"; n -= 400;  end
    while n >= 100;  numeral *= "C";  n -= 100;  end
    if    n >= 90;   numeral *= "XC"; n -= 90;   end
    if    n >= 50;   numeral *= "L";  n -= 50;   end
    if    n >= 40;   numeral *= "XL"; n -= 40;   end
    while n >= 10;   numeral *= "X";  n -= 10;   end
    if    n >= 9;    numeral *= "IX"; n -= 9;    end
    if    n >= 5;    numeral *= "V";  n -= 5;    end
    if    n >= 4;    numeral *= "IV"; n -= 4;    end
    while n >= 1;    numeral *= "I";  n -= 1;    end
    numeral
end