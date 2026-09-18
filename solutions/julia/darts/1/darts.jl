function score(x, y)
    radius = hypot(x, y)
    if radius > 10
        0
    elseif radius > 5
        1
    elseif radius > 1
        5
    else
        10
    end
end