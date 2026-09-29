using LinearAlgebra

function orientrobot(vecs)
    mapreduce(x -> x ./ norm(x), hcat, vecs)
end

function rotaterobot(orientation, θ)
    [cos(θ) -sin(θ); sin(θ) cos(θ)] * orientation
end

function robotoriented(orientation, direction)
    orientation[:, 2]' * direction == norm(direction)
end

function bodylocation(orientation, position)
    position .+ orientation
end