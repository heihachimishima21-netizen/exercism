const ANIMALS = ("fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse")

function swallow(i)
    (
        "I know an old lady who swallowed a $(ANIMALS[i]).",
        "She swallowed the $(ANIMALS[min(8, i+1)]) to catch the $(ANIMALS[i])$(i!=2 ? "." : " ")",
    )
end

function comment(i, var=true)
    (
        "I don't know why she swallowed the $(ANIMALS[i]). Perhaps she'll die.",
        "$(var == true ? "It" : "that") wriggled and jiggled and tickled inside her.",
        "How absurd to swallow a $(ANIMALS[i])!",
        "Imagine that, to swallow a $(ANIMALS[i])!",
        "What a hog, to swallow a $(ANIMALS[i])!",
        "Just opened her throat and swallowed a $(ANIMALS[i])!",
        "I don't know how she swallowed a $(ANIMALS[i])!",
    )
end

const ENDING = "She's dead, of course!"

function recite(start_verse, end_verse)
    poem = []
    for (i, animal) in enumerate(ANIMALS)
        i < start_verse && continue
        
        push!(poem, swallow(i)[1])
        i == length(ANIMALS) && return push!(poem, ENDING)
        
        i > 1 && push!(poem, comment(i)[i])
        
        for j in i-1:-1:1
            if j != 2
                push!(poem, swallow(j)[2])
            else
                push!(poem, swallow(j)[j] * comment(j, false)[j])
            end
        end
        
        push!(poem, comment(1)[1])
        (i == end_verse) ? (return poem) : push!(poem, "")
    end
end