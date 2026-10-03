function pig(word)
    if occursin(r"^(?:xr|yt|[aeiou])", word);           axis = 1
    elseif occursin(r"^[b-df-hj-np-tv-z]*(qu)", word);  axis = first(findfirst("qu", word)) + 2
    elseif occursin(r"^[b-df-hj-np-tv-z]+y", word);     axis = findfirst(==('y'), word)
    else                                                axis = match(r"([aeiou])", word).offset
    end
    (axis == 1 ? word : word[axis:end] * word[1:(axis-1)]) * "ay"
end

translate(phrase) = join((pig(word) for word in split(phrase)), " ")