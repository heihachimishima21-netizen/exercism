const STUDENTS = Dict("Alice"=>1, "Bob"=>3, "Charlie"=>5, "David"=>7, "Eve"=>9, "Fred"=>11, "Ginny"=>13, "Harriet"=>15, "Ileana"=>17, "Joseph"=>19, "Kincaid"=>21, "Larry"=>23)

const PLANTS = Dict('G' => "grass", 'C' => "clover", 'R' => "radishes", 'V' => "violets")

function plants(diagram, student)
    idx, diagram = STUDENTS[student], split(diagram, '\n') .|> collect
    (diagram[i][j] for i in 1:2 for j in idx:idx+1) .|> (x -> PLANTS[x])
end