function palindromeproducts(low::Int, high::Int, smallest::Bool)
    high < low && throw(ArgumentError(""))
    palindrome, factors = nothing, []
    for i in low:high, j in i:high
        n = i*j
        if (isnothing(palindrome) || (smallest ? n < palindrome : n > palindrome)) && (digits(n) == reverse(digits(n)))
            palindrome = n
            factors = [[i, j]]
        elseif n == palindrome
            push!(factors, [i, j])
        end
    end
    palindrome, factors
end