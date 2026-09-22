const SECONDS_IN_YEAR = 31536000

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

convert(planet, seconds) = seconds / (PERIODS[planet] * SECONDS_IN_YEAR)

onEarth(seconds)   = convert("Earth", seconds)
onMercury(seconds) = convert("Mercury", seconds)
onVenus(seconds)   = convert("Venus", seconds)
onMars(seconds)    = convert("Mars", seconds)
onJupiter(seconds) = convert("Jupiter", seconds)
onSaturn(seconds)  = convert("Saturn", seconds)
onUranus(seconds)  = convert("Uranus", seconds)
onNeptune(seconds) = convert("Neptune", seconds)