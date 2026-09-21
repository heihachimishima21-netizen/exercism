function today(birds_per_day)
    birds_per_day[length(birds_per_day)]
end

function increment_todays_count(birds_per_day)
    birds_per_day[length(birds_per_day)] += 1
    birds_per_day
end

function has_day_without_birds(birds_per_day)
    for birds in birds_per_day
        if birds == 0
            return true
        end
    end
    false
end

function count_for_first_days(birds_per_day, num_days)
    sum(birds_per_day[1:num_days])
end

function busy_days(birds_per_day) 
    count = 0
    for birds in birds_per_day
        if birds >= 5
            count += 1
        end
    end
    count
end

function average_per_day(week1, week2)
    total = week1 + week2
    average = total ./ 2
end