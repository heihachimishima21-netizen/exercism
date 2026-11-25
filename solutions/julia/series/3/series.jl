function slices(series, slicelength)
    !(0 < slicelength <= length(series)) && error()
    [series[i+1:i+slicelength] for i in 0:length(series)-slicelength]
end