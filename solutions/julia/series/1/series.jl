function slices(series, slicelength)
    (length(series) < slicelength || slicelength <= 0) && error()
    [series[i:i+slicelength-1] for i in 1:length(series)-slicelength+1]
end