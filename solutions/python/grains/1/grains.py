def square(number):
    if number < 1 or number > 64:
        raise ValueError("square must be between 1 and 64")
    grains = 1
    number -= 1
    while number > 0:
        grains *= 2
        number -= 1
    return grains

def total():
    grains = 0
    for n in range(1, 65):
        grains += square(n)
    return grains
