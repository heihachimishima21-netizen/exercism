function count_nucleotides(strand)
    invalids = setdiff(Set(strand), Set(['A', 'C', 'G', 'T']))
    if !isempty(invalids); throw(DomainError(first(invalids))); end
    nucleo = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for tide in ('A', 'C', 'G', 'T')
        nucleo[tide] += count(isequal(tide), strand)
    end
    nucleo
end