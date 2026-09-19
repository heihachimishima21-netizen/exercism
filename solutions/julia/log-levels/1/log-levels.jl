function message(msg)
    words = split(msg)
    join(words[2:length(words)], " ")
end

function log_level(msg)
    word = split(msg)[1]
    level = lowercase(word[2:length(word) - 2])
end

function reformat(msg)
    string(message(msg), " (", log_level(msg), ")")
end