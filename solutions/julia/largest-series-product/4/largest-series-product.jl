produc(str) = str |> collect |> (x -> parse.(Int, x)) |> prod

function largest_product(str, span)
    (span > length(str) || span < 1 || any(!isdigit, str)) && throw(ArgumentError(""))
    maxim = 0
    for i in 1:length(str)-span+1
        product = view(str, i:i+span-1) |> produc
        maxim = max(product, maxim)
    end
    maxim
end