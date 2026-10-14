dftm(N) = [exp(-2π*im*k*n/N) for k in 0:N-1, n in 0:N-1]

dft(x) = dftm(length(x)) * x

function fft(x)
    N = length(x)
    (even, odd) = N > 2 ? (fft(x[1:2:N]), fft(x[2:2:N])) : (x[1], x[2])
    fast(N) = exp.([-2π*im*k/N for k in 0:N-1])
    vcat(even .+ fast(N)[1:N÷2] .* odd, even .- fast(N)[1:N÷2] .* odd)    
end