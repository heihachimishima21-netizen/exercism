function isarmstrong(n)
    num = string(n); len = length(num)
    total = sum(parse(Int, digit)^len for digit in num)
    total == n
end