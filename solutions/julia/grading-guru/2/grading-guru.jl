function demote(n)
    if typeof(n) == Float64
        return UInt8(ceil(n))
    elseif isa(n, Integer)
        return Int8(n)
    else throw(MethodError(demote, (n,)))
    end
end

function preprocess(coll)
    if !(coll isa Union{Vector, Set}); throw(MethodError(preprocess, (coll,))); end
    if coll isa Vector
        return demote.(reverse!(coll))
    else
        return sort!(demote.(collect(coll)), rev=true)
    end
end