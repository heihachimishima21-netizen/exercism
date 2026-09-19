function get_coordinate(line)
    line[2]
end

function convert_coordinate(coordinate)
    Tuple(coordinate)
end

function compare_records(azara_record, rui_record)
    convert_coordinate(get_coordinate(azara_record)) == rui_record[2]
end

function create_record(azara_record, rui_record)
    treasure, coord = azara_record
    loc, _, quad = rui_record
    compare_records(azara_record, rui_record) ? (coord, loc, quad, treasure) : ()
end