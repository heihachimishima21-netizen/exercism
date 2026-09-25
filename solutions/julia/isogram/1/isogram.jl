function isisogram(s)
    letters = setdiff(Set(lowercase(s)), Set([' ', '-']))
    filtered = replace(lowercase(s), r"[ -]" => "")
    length(filtered) == length(letters)
end