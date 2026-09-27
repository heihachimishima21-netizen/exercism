z(x, y) = complex(x, y)

euler(r, θ) = r * cis(θ)

rotate(x, y, θ) = reim(cis(θ) * z(x, y))

rdisplace(x, y, r) = reim(z(x, y) + r * sign(z(x, y)))

findsong(x, y, r, θ) = rotate(rdisplace(x, y, r)..., θ)