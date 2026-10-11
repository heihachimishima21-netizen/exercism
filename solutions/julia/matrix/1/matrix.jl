function matrix(strmatrix)
    rows = strmatrix |> (x -> split(x, '\n')) .|> (x -> split(x, ' ')) .|> (x -> (y -> parse(Int, y)).(x))
    rows, zip(rows...) .|> collect
end