function schedule_appointment(appointment::String)
    DateTime("$appointment", dateformat"m/d/y H:M:S")
end

function has_passed(appointment::DateTime)
    appointment < now()
end

function is_afternoon_appointment(appointment::DateTime)
    12 <= hour(appointment) <= 17
end

function describe(a::DateTime)
    "You have an appointment on "*Dates.format(a, "E, U d, yyyy \\a\\t HH:MM")
end

function anniversary_date()
    Date(year(now()), 09, 15)
end