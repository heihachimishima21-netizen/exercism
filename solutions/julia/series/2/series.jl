function slices(series, slicelength)
    !(0 < slicelength <= length(series)) && error()
    [series[i:i+slicelength-1] for i in 1:length(series)-slicelength+1]
end