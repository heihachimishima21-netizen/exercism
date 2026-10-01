function shared_birthday(birthdates)
    length(Set((x -> x[6:end]).(birthdates))) < length(birthdates)
end

function random_birthdates(groupsize)
    ran_days = rand(0:364, groupsize)
    dates = Date(1999, 01, 01) .+ (Day).(ran_days)
end

function estimate_probability_of_shared_birthday(groupsize, trials=400)
    count = 0
    for _ in 1:trials
        shared = groupsize |> random_birthdates |> (x -> string.(x)) |> shared_birthday
        if shared
            count += 1
        end
    end
    count/trials
end