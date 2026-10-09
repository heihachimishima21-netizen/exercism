const CODON_MAP = Dict(
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine", "UUC" => "Phenylalanine",
    "UUA" => "Leucine",       "UUG" => "Leucine",
    "UCU" => "Serine",        "UCC" => "Serine",        "UCA" => "Serine",    "UCG" => "Serine",
    "UAU" => "Tyrosine",      "UAC" => "Tyrosine",
    "UGU" => "Cysteine",      "UGC" => "Cysteine",
    "UGG" => "Tryptophan"
)

const STOP_CODONS = ("UAA", "UAG", "UGA")

function proteins(strand)
    proteins, ln = String[], length(strand)
    for idx in 1:3:ln
        idx > ln - 2 && throw(DomainError(strand))
        codon = SubString(strand, idx, idx + 2)
        codon ∈ STOP_CODONS && break
        haskey(CODON_MAP, codon) || throw(DomainError(codon))
        push!(proteins, CODON_MAP[codon])
    end
    proteins
end