function z(x, y)
    complex(x, y)
end

function euler(r, θ)
    r * cis(θ)
end

function rotate(x, y, θ)
    reim(cis(θ) * z(x, y))
end

function rdisplace(x, y, r)
    mod = abs(z(x, y))
    arg = angle(z(x, y))
    reim(euler(mod + r, arg))
end

function findsong(x, y, r, θ)
    rotate(rdisplace(x, y, r)..., θ)
end