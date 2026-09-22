const PERIODS = Dict(
    "Mercury" => 0.2408467,
    "Venus"   => 0.61519726,
    "Earth"   => 1.0,
    "Mars"    => 1.8808158,
    "Jupiter" => 11.862615,
    "Saturn"  => 29.447498,
    "Uranus"  => 84.016846,
    "Neptune" => 164.79132
)

function convert(planet, seconds)
    seconds/(PERIODS[planet]*3600*24*365);
end

function onEarth(seconds)
    convert("Earth", seconds)
end

function onMercury(seconds)
    convert("Mercury", seconds)
end

function onVenus(seconds)
    convert("Venus", seconds)
end

function onMars(seconds)
    convert("Mars", seconds)
end

function onJupiter(seconds)
    convert("Jupiter", seconds)
end

function onSaturn(seconds)
    convert("Saturn", seconds)
end

function onUranus(seconds)
    convert("Uranus", seconds)
end

function onNeptune(seconds)
    convert("Neptune", seconds)
end