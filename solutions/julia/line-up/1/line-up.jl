suffixes = ("st", "nd", "rd", "th")

function line_up(name, number)
    ones = number % 10
    tens = (number % 100 - ones) / 10
    suffix = suffixes[(tens != 1 && 1 <= ones <= 3) ? ones : 4]
    "$name, you are the $number$suffix customer we serve today. Thank you!"
end