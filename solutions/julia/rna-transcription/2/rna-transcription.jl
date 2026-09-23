const TRANS = Dict('G' => 'C', 'C' => 'G', 'T' => 'A', 'A' => 'U')

to_rna(dna) = join(tide ∈ "GCTA" ? TRANS[tide] : throw(ErrorException("")) for tide in dna)