function pig(word)
    if      occursin(r"^(xr|yt|[aeiou])", word);   axis = 1
    elseif  occursin(r"^[^aeiou]*qu", word);       axis = first(findfirst("qu", word)) + 2
    elseif  occursin(r"^[^aeiou]+y", word);        axis = findfirst(==('y'), word)
    else                                           axis = match(r"[aeiou]", word).offset
    end
    word[axis:end] * word[1:(axis-1)] * "ay"
end

translate(phrase) = phrase |> split .|> pig |> (x -> join(x, " "))