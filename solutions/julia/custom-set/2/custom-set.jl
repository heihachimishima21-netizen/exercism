struct CustomSet{T}
    elements::Vector{T}

    function CustomSet(vector::Vector{T}) where {T}
        new{T}([item for (i, item) in enumerate(vector) if item ∉ @view(vector[1:i-1])])
    end
    
end

Base.length(s::CustomSet) = s.elements |> length

Base.isempty(s::CustomSet) = s |> length |> iszero

Base.in(element, s::CustomSet) = element ∈ s.elements

Base.iterate(s::CustomSet)             = iszero(length(s)) ? nothing : (s.elements[1], 2)
Base.iterate(s::CustomSet, state::Int) = length(s) < state ? nothing : (s.elements[state], state + 1)

Base.issubset(s1::CustomSet, s2::CustomSet) = all(x -> x in s2, s1.elements)
disjoint(     s1::CustomSet, s2::CustomSet) = all(x -> x ∉  s2, s1.elements)

Base.:(==)(s1::CustomSet, s2::CustomSet) = issubset(s1, s2) && issubset(s2, s1)

Base.push!(s::CustomSet, element) = element ∉ s && push!(s.elements, element)

Base.intersect!(s1::CustomSet, s2::CustomSet) = filter!(x -> x in s2, s1.elements)
Base.intersect( s1::CustomSet, s2::CustomSet) = CustomSet([element for element in s1 if element in s2])

complement!(s1::CustomSet, s2::CustomSet) = filter!(x -> x ∉ s2, s1.elements)
complement( s1::CustomSet, s2::CustomSet) = CustomSet([element for element in s1 if element ∉ s2])

Base.union!(s1::CustomSet, s2::CustomSet) = append!(s1.elements, complement(s2, s1))
Base.union( s1::CustomSet, s2::CustomSet) = CustomSet([s1.elements; s2.elements])