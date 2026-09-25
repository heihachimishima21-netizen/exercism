function wordcount(sentence)
    words = Dict()
    matches = eachmatch(r"\b\w+('\w{1,2})?\b", lowercase(sentence))
    for word in (x -> x.match).(matches)
        words[word] = get(words, word, 0) + 1
    end
    words
end