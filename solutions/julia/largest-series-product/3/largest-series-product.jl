produc(str) = str |> collect |> (x -> parse.(Int, x)) |> prod

function largest_product(str, span)
    (span > length(str) || span < 1 || any(!isdigit, str)) && throw(ArgumentError(""))
    max = 0
    for i in 1:length(str)-span+1
        product = view(str, i:i+span-1) |> produc
        max = product > max ? product : max
    end
    max 
end