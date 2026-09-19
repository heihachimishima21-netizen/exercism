def degen(sides):
    return min(sides) <= 0 or sum(sides) < 2 * max(sides)

def equilateral(sides):
    return len(set(sides)) == 1 and not degen(sides)

def isosceles(sides):
    return len(set(sides)) <= 2 and not degen(sides)

def scalene(sides):
    return len(set(sides)) == 3 and not degen(sides)