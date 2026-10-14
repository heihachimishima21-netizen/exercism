function dftm(N)
    [exp(-2π*im*k*n/N) for k in 0:N-1, n in 0:N-1]
end

function diag(N)
    [k == n ? exp(-2π*im*n/N) : 0 for k in 0:N-1, n in 0:N-1]
end

function dft(x)
    dftm(length(x)) * x
end

#w(j, n) = exp(-2π*im*j/n)

function fft(x)
    N = length(x)
    if N > 2
        odd = fft(x[1:2:N])
        even = fft(x[2:2:N])
    else
        odd = x[1]
        even= x[2]
    end

    w(j, n) = exp.(-2π*im*j/n)

    n = 0:N-1

    half = N÷2

    fast = w(n, N)

    return vcat(odd .+ even .* fast[1:half], odd .- even .* fast[1:half])

    
    

    
end