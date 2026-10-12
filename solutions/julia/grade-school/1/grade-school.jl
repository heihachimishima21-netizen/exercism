new_school() = Dict((-1 => Set{String}(),))

function add!(students, school)
    bools = []
    for student in students
        if student.name ∉ school[-1]
            haskey(school, student.grade) ? 
                push!(school[student.grade], student.name) : 
                school[student.grade] = Set((student.name,))
            push!(school[-1], student.name)
            push!(bools, true)
        else
            push!(bools, false)
        end
    end
    bools
end

grade(num, school) = school |> (x -> get(x, num, [])) |> collect |> sort

function roster(school)
    classes = school |> keys |> collect |> sort |> (x -> x[2:end]) #ordered grades
    [name for class in classes for name in grade(class, school)]
end