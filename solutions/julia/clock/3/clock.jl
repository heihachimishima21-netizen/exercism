struct Clock
    hour::Int
    minute::Int

    Clock(h, m) = new(mod(h + fld(m, 60), 24), mod(m, 60))
end

Base.:+(clock::Clock, minutes::Dates.Minute) = Clock(clock.hour, clock.minute + Dates.value(minutes))
Base.:-(clock::Clock, minutes::Dates.Minute) = clock + -minutes

Base.show(io::IO, c::Clock) = print(io, "\"$(string(c.hour, pad=2)):$(string(c.minute, pad=2))\"")