function acronym(phrase)
    words = eachmatch(r"(?:\b|_)([^\W_]+(?:'\w)?)(?:\b|_)", phrase)
    join([uppercase(word[1][1]) for word in words])
end