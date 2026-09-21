function rationalize(successes, trials)
    successes .// trials
end

function probabilities(successes, trials)
    float.(rationalize(successes, trials))
end

function checkmean(successes, trials)
    r_mean = (sum(rationalize(successes, trials))) // length(trials)
    f_mean = sum(probabilities(successes, trials)) / length(trials)
    (float(r_mean) == f_mean) ? true : r_mean
end

function checkprob(successes, trials)
    r_prod = prod(rationalize(successes, trials))
    f_prod = prod(probabilities(successes, trials))
    (float(r_prod) == f_prod) ? true : r_prod
end