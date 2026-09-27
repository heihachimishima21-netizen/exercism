cleanupname(name) = strip(replace(name, "-" => " "))

firstletter(name) = string(cleanupname(name)[1])

initial(name) = uppercase(firstletter(name))*"."

couple(name1, name2) = "❤ $(initial(name1))  +  $(initial(name2)) ❤"