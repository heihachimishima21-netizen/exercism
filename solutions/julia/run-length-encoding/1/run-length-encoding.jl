function encode(s)
    segments = []
    while s != ""
        l = length(s)
        for i in 1:l
            if i == l || s[i+1] != s[i]
                push!(segments, (i > 1 ? string(i) : "") * s[1])
                s = s[i+1:end]
                break
            end
        end
    end
    join(segments)
end

function decode(s)
    output = ""
    for seg in (x -> x.match).(eachmatch(r"(\d*[\w| ])", s))
        output *= repeat(seg[end], length(seg) > 1 ? parse(Int, seg[begin:end-1]) : 1)
    end
    output
end