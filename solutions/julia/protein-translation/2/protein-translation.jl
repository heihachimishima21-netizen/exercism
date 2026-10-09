const CODON_MAP = Dict(
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine", "UUC" => "Phenylalanine",
    "UUA" => "Leucine",       "UUG" => "Leucine",
    "UCU" => "Serine",        "UCC" => "Serine",         "UCA" => "Serine",    "UCG" => "Serine",
    "UAU" => "Tyrosine",      "UAC" => "Tyrosine",
    "UGU" => "Cysteine",      "UGC" => "Cysteine",
    "UGG" => "Tryptophan"
)

const STOP_CODONS = ("UAA", "UAG", "UGA")

function proteins(strand)
    proteins = String[]
    for codon in Iterators.map(String, Iterators.partition(strand, 3))
        length(codon) < 3 && throw(DomainError(strand))
        codon ∈ STOP_CODONS && break
        haskey(CODON_MAP, codon) || throw(DomainError(codon))
        push!(proteins, CODON_MAP[codon])
    end
    proteins
end