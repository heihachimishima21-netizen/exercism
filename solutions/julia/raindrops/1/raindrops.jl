DROPS = ((3, "Pling"), (5, "Plang"), (7, "Plong"))

function raindrops(number)
    sounds = []
    for (factor, drop) in DROPS
        if number % factor == 0
            push!(sounds, drop)
        end
    end
    isempty(sounds) ? string(number) : join(sounds)
end