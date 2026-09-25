function wordcount(sentence)
    words = Dict()
    matches = eachmatch(r"\b\w+('\w{1,2})?\b", lowercase(sentence))
    for word in (x -> x.match).(matches)
        if haskey(words, word)
            words[word] += 1
        else
            words[word] = 1
        end
    end
    words
end