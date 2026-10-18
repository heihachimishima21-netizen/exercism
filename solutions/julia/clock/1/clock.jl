struct Clock
    hour::Int
    minute::Int

    function Clock(h, m)
        (hour_adjust, minutes) = fldmod(m, 60)
        (_, hours) = fldmod(h + hour_adjust, 24)
        new(hours, minutes)
    end
end

Base.:+(clock::Clock, minutes::Dates.Minute) = Clock(clock.hour, clock.minute + minutes.value)
Base.:-(clock::Clock, minutes::Dates.Minute) = Clock(clock.hour, clock.minute - minutes.value)

Base.show(io::IO, c::Clock) = print(io, "\"$(string(c.hour, pad=2)):$(string(c.minute, pad=2))\"")