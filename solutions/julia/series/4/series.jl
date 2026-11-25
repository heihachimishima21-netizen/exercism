function slices(series, slicelength)
    (slicelength <= 0 || (difference = length(series) - slicelength) < 0) && error()
    @views [series[1+i:slicelength+i] for i in 0:difference]
end