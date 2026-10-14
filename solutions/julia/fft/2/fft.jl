dftm(N) = [exp(-2π*im*k*n/N) for k in 0:N-1, n in 0:N-1]

dft(x) = dftm(length(x)) * x

function fft(x)
    N = length(x)
    if N > 2
        odd, even = fft(x[1:2:N]), fft(x[2:2:N])
    else
        odd, even = x[1], x[2]
    end

    w(N) = exp.([-2π*im*k/N for k in 0:N-1])
    half = N÷2
    fast = w(N)

    vcat(odd .+ even .* fast[1:half], odd .- even .* fast[1:half])    
end