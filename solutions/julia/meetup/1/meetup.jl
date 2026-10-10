const DOTW = Dict(
    "Monday"    => 1,
    "Tuesday"   => 2,
    "Wednesday" => 3,
    "Thursday"  => 4,
    "Friday"    => 5,
    "Saturday"  => 6,
    "Sunday"    => 7
)

const WEEK = Dict(
    "first"  => 0,
    "second" => 1,
    "third"  => 2,
    "fourth" => 3,
    "teenth" => 4,
    "last"   => 5
)

function meetup(year, month, week, dayofweek)
    date = Date(year, month)
    day_num = Dates.dayofweek(date)
    requested_day, requested_week = DOTW[dayofweek], WEEK[week]
    if 0 <= requested_week <= 4
        incr = mod(requested_day - day_num, 7)
        requested_week == 4 && (requested_week = incr < 5 ? 2 : 1)
        date += Day(incr + 7*requested_week)
    else
        date = Dates.lastdayofmonth(date)
        day_num = Dates.dayofweek(date)
        date -= Day(mod(day_num - requested_day, 7))
    end
end