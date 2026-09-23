function distance(a, b)
    if length(a) != length(b); throw(ArgumentError("")); end
    distance = 0
    for i in 1:length(a)
        if a[i] != b[i]
            distance += 1
        end
    end
    distance
end