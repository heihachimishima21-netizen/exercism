function slices(series, slicelength)
    (slicelength <= 0 || (difference = length(series) - slicelength) < 0) && error()
    @views (series[i+1:i+slicelength] for i in 0:difference) |> collect
end