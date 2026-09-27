cleanupname(name) = (strip ∘ replace)(name, "-" => " ")

firstletter(name) = name |> cleanupname |> first |> string

initial(name) = (uppercase ∘ firstletter)(name)*"."

couple(name1, name2) = "❤ $(initial(name1))  +  $(initial(name2)) ❤"