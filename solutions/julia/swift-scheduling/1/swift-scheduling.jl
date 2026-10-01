using Dates
const ABBREV = ("NOW", "ASAP", "EOW")
const DAY_NAMES = ("Monday", "Tuesday", "Wednesday")

function delivery_date(start, description)
    dt = DateTime(start)
    if description in ABBREV
        if description == "NOW"
            delivery = dt + Hour(2)
        elseif description == "ASAP"
            if hour(dt) < 13
                delivery = DateTime(year(dt), month(dt), day(dt), 17, 00, 00)
            else
                dt += Day(1)
                delivery = DateTime(year(dt), month(dt), day(dt), 13, 00, 00)
            end
        elseif description == "EOW"
            if dayname(dt) in DAY_NAMES
                dt += Day(5 - dayofweek(dt))
                delivery = DateTime(year(dt), month(dt), day(dt), 17, 00, 00)
            else
                dt +=  Day(7 - dayofweek(dt))
                delivery = DateTime(year(dt), month(dt), day(dt), 20, 00, 00)
            end
        end
    else
        N = match(r"(\d{1,2})M", description)
        if !isnothing(N)
            N = parse(Int, N[1])
            if month(dt) >= N; dt += Year(1); end
            dt = DateTime(year(dt), N, 1, 8, 00, 00)
            delivery = dt + (dayofweek(dt) > 5 ? Day(8 - dayofweek(dt)) : Day(0))
        else
            quarter = parse(Int, match(r"Q(\d)", description)[1])
            if (month(dt) - 1) ÷ 3 + 1 > quarter; dt += Year(1); end
            dt = DateTime(year(dt), 3*quarter, daysinmonth(Date(year(dt), 3*quarter)), 8, 00, 00)
            delivery = dt - (dayofweek(dt) > 5 ? Day(dayofweek(dt) - 5) : Day(0))
        end
    end
    string(delivery)
end