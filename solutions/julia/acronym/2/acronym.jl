function acronym(phrase)
    words = eachmatch(r"(?:\b|_)([^\W_]+(?:'\w)?)(?:\b|_)", phrase)
    words .|> (x -> x[1][1]) .|> uppercase |> join
end