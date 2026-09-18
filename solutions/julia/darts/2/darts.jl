function score(x, y)
    radius = hypot(x, y)
    radius > 10 ? 0 :
    radius > 5  ? 1 :
    radius > 1  ? 5 : 10
end