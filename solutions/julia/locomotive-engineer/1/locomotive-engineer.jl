function get_vector_of_wagons(args...)
    collect(args)
end

function fix_vector_of_wagons(each_wagons_id, missing_wagons)
    a, b, c, rest... = each_wagons_id
    vcat(c, missing_wagons, rest, a, b)
end

function add_missing_stops(route, stops...)
    Dict(route..., "stops" => [last(pair) for pair in stops])
end

function extend_route_information(route; more_route_information...)
    new_route = Dict(route..., pairs(more_route_information)...)
end