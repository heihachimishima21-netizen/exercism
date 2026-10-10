function luhn(cardnum)
    num = replace(cardnum, ' ' => "")
    len = length(num)
    if len <= 1 || occursin(r"[^\d]", num); return false; end
    num = parse.(Int, collect(num))
    num[(len-1):-2:1] = (x -> x < 5 ? 2x : 2x - 9).(num[(len-1):-2:1])
    reduce((a, b) -> mod(a + b, 10), num) == 0
end