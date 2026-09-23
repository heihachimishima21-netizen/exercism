function count_nucleotides(strand)
    count = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for tide in strand
        if tide in ('A', 'C', 'G', 'T')
            count[tide] += 1
        else
            throw(DomainError(tide))
        end
    end
    count
end