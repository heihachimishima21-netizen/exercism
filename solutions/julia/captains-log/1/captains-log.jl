using Random

random_planet() = rand(collect("DHJKLMNRTY"))

random_ship_registry_number() = "NCC-$(rand(1000:9999))"

random_stardate() = 41000.0 + 1000rand()

random_stardate_v2() = rand(41000.0:0.1:42000.0)

pick_starships(starships, number_needed) = shuffle(starships)[1:number_needed]