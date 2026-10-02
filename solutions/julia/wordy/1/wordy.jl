operations = Dict(
    " plus " => +,
    " minus " => -,
    " multiplied by " => *,
    " divided by " => ÷
)

function wordy(problem)
    s = match(r"^What is (-?\d+)(?: [A-Za-z ]+ -?\d+)*\?$", problem)
    if isnothing(s); throw(ArgumentError("nothing")); end
    result = parse(Int, s[1])
    matches = eachmatch(r"( [A-Za-z ]+ -?\d+)", problem[8:end])
    for operation in (x -> x.match).(matches)
        m = match(r"( [A-Za-z ]+ )(-?\d+)", operation)
        if m[1] ∉ keys(operations); throw(ArgumentError("$(m[1])")); end
        result = operations[m[1]](result, parse(Int, m[2]))
    end
    result
end