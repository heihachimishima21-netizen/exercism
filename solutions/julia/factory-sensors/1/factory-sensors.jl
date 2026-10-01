function humiditycheck(pct_humidity)
    if pct_humidity <= 70
        @info "humidity level check passed: $pct_humidity%"
    else
        error("humidity check failed: $pct_humidity%")
    end
end

function temperaturecheck(temperature)
    if isnothing(temperature)
        throw(ArgumentError("sensor is broken"))
    elseif temperature > 500
        throw(DomainError(temperature, "overheating detected"))
    else
        @info "temperature check passed: $temperature °C"
    end
end

struct MachineError <: Exception end

function machinemonitor(pct_humidity, temperature)
    functioning = true
    try
        humid = humiditycheck(pct_humidity)
    catch problem
        functioning = false
        @error "humidity level check failed: $pct_humidity%"
    end
    try
        temp = temperaturecheck(temperature)
    catch problem
        functioning = false
        if problem isa ArgumentError
            @warn "sensor is broken"
        elseif problem isa DomainError
            @error "overheating detected: $temperature °C"
        end
    end
    if !functioning; throw(MachineError()); end
end