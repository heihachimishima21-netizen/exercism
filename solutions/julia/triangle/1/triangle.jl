is_degen(sides) = minimum(sides) <= 0 || sum(sides) < 2 * maximum(sides)

is_equilateral(sides) = length(Set(sides)) == 1 && !is_degen(sides)

is_isosceles(sides) = length(Set(sides)) <= 2 && !is_degen(sides)

is_scalene(sides) = length(Set(sides)) == 3 && !is_degen(sides)