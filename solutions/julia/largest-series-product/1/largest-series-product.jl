function prod(str)
    str |> collect |> (x -> parse.(Int, x)) |> (x -> reduce(*, x))
end

function largest_product(str, span)
    (span > length(str) || span < 1 || any(!isdigit, str)) && throw(ArgumentError(""))
    max = 0
    for i in 1:length(str)-span+1
        product = prod(str[i:i+span-1])
        max = product > max ? product : max
    end
    max 
end