const PREPARATION_TIME = Dict(
    "Pure Strawberry Joy" => 0.5,
    "Energizer"           => 1.5,
    "Green Garden"        => 1.5,
    "Tropical Island"     => 3.0,
    "All or Nothing"      => 5.0
)

const WEDGES = Dict(
    "small"  => 6,
    "medium" => 8,
    "large"  => 10
)

function time_to_mix_juice(juice)
    get(PREPARATION_TIME, juice, 2.5)
end

function wedges_from_lime(size)
    WEDGES[size]
end

function limes_to_cut(needed, limes)
    wedges = 0
    for (count, lime) in enumerate(limes)
        if wedges >= needed; return count - 1; end
        wedges += wedges_from_lime(lime)
    end
    length(limes)
end

function order_times(orders)
    [time_to_mix_juice(juice) for juice in orders]
end

function remaining_orders(time_left, orders)
    times, i, n = order_times(orders), 1, length(orders)
    while time_left > 0 && i <= n
        time_left -= times[i]
        i += 1
    end
    i <= n ? orders[i:end] : []
end