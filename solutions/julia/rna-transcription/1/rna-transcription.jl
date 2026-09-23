const NUCLEOTIDES = ('G', 'C', 'T', 'A')

const TRANSCRIPTION = Dict(
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
)

function to_rna(dna)
    rna = []
    for tide in dna
        if tide ∉ NUCLEOTIDES; throw(ErrorException("")); end
        push!(rna, TRANSCRIPTION[tide])
    end
    join(rna)
end