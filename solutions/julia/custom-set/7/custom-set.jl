struct CustomSet{T}  <: AbstractSet{T}
    elements::Vector{T}

    CustomSet(vector::AbstractVector{T}) where {T} = new{T}(unique(vector))
    
end

Base.length(     s::CustomSet) = s.elements |> length
Base.isempty(    s::CustomSet) = s |> length |> iszero
Base.in(element, s::CustomSet) = element ∈ s.elements

Base.iterate(s::CustomSet)             = iszero(length(s)) ? nothing : (s.elements[1], 2)
Base.iterate(s::CustomSet, state::Int) = length(s) < state ? nothing : (s.elements[state], state + 1)

Base.issubset(s1::CustomSet, s2::CustomSet) = all(x -> x in s2, s1.elements)
disjoint(     s1::CustomSet, s2::CustomSet) = all(x -> x ∉  s2, s1.elements)
Base.:(==)(   s1::CustomSet, s2::CustomSet) = issubset(s1, s2) && issubset(s2, s1)
Base.push!(    s::CustomSet, element)       = element ∉ s && push!(s.elements, element)

Base.intersect!(s1::CustomSet, s2::CustomSet) = filter!(x -> x in s2, s1.elements)
Base.union!(    s1::CustomSet, s2::CustomSet) = append!(s1.elements, complement(s2, s1))

complement!(s1::CustomSet, s2::CustomSet) = filter!(x -> x ∉ s2, s1.elements)
complement( s1::CustomSet, s2::CustomSet) = CustomSet([element for element in s1 if element ∉ s2])