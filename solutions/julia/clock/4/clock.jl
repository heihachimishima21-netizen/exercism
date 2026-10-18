struct Clock
    min::Int
    Clock(h::Int, m::Int) = new(mod(60h + m, 1440))
end

Base.:+(clock::Clock, minutes::Dates.Minute) = Clock(0, clock.min + Dates.value(minutes))
Base.:-(clock::Clock, minutes::Dates.Minute) = clock + -minutes

Base.show(io::IO, c::Clock) = print(io, "\"$(string(fld(c.min, 60), pad=2)):$(string(mod(c.min, 60), pad=2))\"")