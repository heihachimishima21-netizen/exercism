function base10(digits, base)
    new_digits = [num*base^pow for (pow, num) in zip(length(digits)-1:-1:0, digits)]
    sum(new_digits, init=0)
end

function all_your_base(digits, base_in, base_out)
    (base_in < 2 || base_out < 2) && throw(DomainError(""))
    foreach(x -> (x < 0 || x >= base_in) && throw(DomainError("")), digits)
    number = base10(digits, base_in)
    output = []
    while number > 0
        pushfirst!(output, number % base_out)
        number ÷= base_out
    end
    isempty(output) ? [0] : output
end