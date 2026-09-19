answers = ("Whatever.", 
           "Sure.", 
           "Whoa, chill out!", 
           "Calm down, I know what I'm doing!")

function bob(stimulus)
    stimulus = strip(stimulus)
    if length(stimulus) == 0
        return "Fine. Be that way!"
    end
    index, words, yell = 1, false, true
    if stimulus[end] == '?'
        index += 1
    end    
    for char in stimulus
        if isletter(char) 
            words = true
            if islowercase(char)
                yell = false
                break
            end
        end
    end
    index += words && yell ? 2 : 0
    answers[index]     
end