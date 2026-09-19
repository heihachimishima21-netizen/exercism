function transform(ch)
    if ch == '-'
        str = "_"
    elseif isspace(ch)
        str = ""
    elseif isuppercase(ch)
        char = lowercase(ch)
        str = "-$char"
    elseif isdigit(ch)
        str = ""
    elseif Int('α') <= Int(ch) <= Int('ω')
        "?"
    else
        "$ch"
    end
end

function clean(str)
    chars = collect(str)
    join(transform.(chars))
end