function encode(s)
    segments = []
    while s != ""
        i = 1
        while i < length(s) && s[i] == s[i+1]; i += 1; end
        push!(segments, (i > 1 ? string(i) : "") * s[1])
        s = s[i+1:end]
    end
    segments |> join
end

function decode(s)
    output = ""
    for seg in eachmatch(r"(\d*)([\w ])", s)
        n = isempty(seg[1]) ? 1 : parse(Int, seg[1])
        output *= repeat(seg[2], n)
    end
    output
end