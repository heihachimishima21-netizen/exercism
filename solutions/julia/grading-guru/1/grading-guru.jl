function demote(n)
    if typeof(n) == Float64
        n = UInt8(ceil(n))
    elseif isa(n, Integer)
        n = Int8(n)
    else throw(MethodError(demote, (n,)))
    end
end

function preprocess(coll)
    if !(coll isa Union{Vector, Set}); throw(MethodError(demote)); end
    if coll isa Vector
        (x -> demote(x)).(reverse!(coll))
    else
        sort!((x -> demote(x)).(coll), rev=true)
    end
end