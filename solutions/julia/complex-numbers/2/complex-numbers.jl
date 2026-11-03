struct ComplexNumber <: Number
    re::Float64
    im::Float64
end

ComplexNumber(re::Real, im::Real) = ComplexNumber(Float64(re), Float64(im))
ComplexNumber(x::Real) = ComplexNumber(x, 0)

Base.real(z::ComplexNumber) = z.re
Base.imag(z::ComplexNumber) = z.im
square(   z::ComplexNumber) = z.re^2 + z.im^2
Base.:(==)(z::ComplexNumber, w::ComplexNumber) = z.re == w.re && z.im == w.im

Base.:+(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(z.re + w.re, z.im + w.im)
Base.:+(z::ComplexNumber, x::Real) = z + ComplexNumber(x)
Base.:+(x::Real, z::ComplexNumber) = z + x

Base.:-(z::ComplexNumber) = ComplexNumber(-z.re, -z.im)
Base.:-(z::ComplexNumber, w::ComplexNumber) = z + (-w)
Base.:-(z::ComplexNumber, x::Real) = z + (-x)
Base.:-(x::Real, z::ComplexNumber) = (-z) + x

Base.:*(z::ComplexNumber, w::ComplexNumber) = ComplexNumber(z.re * w.re - z.im * w.im, z.im * w.re + z.re * w.im)
Base.:*(z::ComplexNumber, x::Real) = z * ComplexNumber(x)
Base.:*(x::Real, z::ComplexNumber) = z * x

Base.:/(z::ComplexNumber, w::ComplexNumber) = ComplexNumber((z.re * w.re + z.im * w.im)/square(w), (z.im * w.re - z.re * w.im)/square(w))
Base.:/(z::ComplexNumber, x::Real) = z / ComplexNumber(x)
Base.:/(x::Real, z::ComplexNumber) = ComplexNumber(x) / z

Base.abs( z::ComplexNumber) = sqrt(square(z))
Base.conj(z::ComplexNumber) = ComplexNumber(z.re, -z.im)
Base.exp( z::ComplexNumber) = ComplexNumber(exp(z.re) * cos(z.im), exp(z.re) * sin(z.im))

enable_realcomplex_tests = true

# Uncomment the following line to enable bonus tests for syntax sugar.
# enable_syntaxsugar_tests = true
