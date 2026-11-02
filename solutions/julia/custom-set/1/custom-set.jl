struct CustomSet{T}
    elements::Vector{T}

    function CustomSet(vector::Vector{T}) where {T}
        elements = T[]
        for item in vector
            if item ∉ elements
                push!(elements, item)
            end
        end
        new{T}(elements)
    end
end

Base.length(s::CustomSet) = length(s.elements)

function Base.isempty(s::CustomSet)
    iszero(length(s))
end

function Base.in(element, s::CustomSet)
    element ∈ s.elements
end

function Base.iterate(s::CustomSet)
    iszero(length(s)) ? nothing : (s.elements[1], 2)
end

function Base.iterate(s::CustomSet, state::Int)
    length(s) < state ? nothing : (s.elements[state], state + 1)
end

function Base.issubset(s1::CustomSet, s2::CustomSet)
    all(x -> x in s2, s1.elements)
end

function disjoint(s1::CustomSet, s2::CustomSet)
    all(x -> x ∉ s2, s1.elements)
end

function Base.:(==)(s1::CustomSet, s2::CustomSet)
    issubset(s1, s2) && issubset(s2, s1)
end

function Base.push!(s::CustomSet, element)
    element ∉ s && push!(s.elements, element)
end

function Base.intersect!(s1::CustomSet, s2::CustomSet)
    filter!(x -> x in s2, s1.elements)
end

function Base.intersect(s1::CustomSet, s2::CustomSet)
    CustomSet([element for element in s1 if element in s2])
end

function complement!(s1::CustomSet, s2::CustomSet)
    filter!(x -> x ∉ s2, s1.elements)
end

function complement(s1::CustomSet, s2::CustomSet)
    CustomSet([element for element in s1 if element ∉ s2])
end

function Base.union!(s1::CustomSet, s2::CustomSet)
    append!(s1.elements, complement(s2, s1))
end

function Base.union(s1::CustomSet, s2::CustomSet)
    CustomSet([s1.elements; s2.elements])
end