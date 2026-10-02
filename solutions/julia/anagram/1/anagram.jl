function detect_anagrams(subject, candidates)
    base = lowercase(subject)
    comparator = sort(collect(base))
    [word for word in candidates if lowercase(word) != base && sort(collect(lowercase(word))) == comparator]
end