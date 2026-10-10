const DOTW = Dict("Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6, "Sunday" => 7)

const WEEK = Dict("first" => 0, "second" => 1, "third" => 2, "fourth" => 3, "teenth" => 13, "last" => 31)

function meetup(year, month, week, dayofweek)
    date = Date(year, month)
    day_num = Dates.dayofweek(date)
    requested_day, requested_week = DOTW[dayofweek], WEEK[week]
    if requested_week == 31
        date = Dates.lastdayofmonth(date)
        day_num = Dates.dayofweek(date)
        date -= Day(mod(day_num - requested_day, 7))
    else
        incr = mod(requested_day - day_num, 7)
        requested_week == 13 && (requested_week = incr < 5 ? 2 : 1)
        date += Day(incr + 7*requested_week)
    end
end