struct RationalNumber
    a::Int; b::Int
    
    function RationalNumber(a::Int, b::Int)
        iszero(b) && throw(ArgumentError(""))
        d = gcd(a, b) * sign(b)
        new(a÷d, b÷d)
    end
    
end

numerator(  r::RationalNumber) = r.a
denominator(r::RationalNumber) = r.b

Base.:+(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b + y.a * x.b, x.b * y.b)
Base.:-(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b - y.a * x.b, x.b * y.b)
Base.:*(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.a            , x.b * y.b)
Base.:/(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b            , x.b * y.a)

Base.abs(x::RationalNumber) = RationalNumber(abs(x.a), x.b)
Base.inv(x::RationalNumber) = RationalNumber(x.b     , x.a)

Base.:^(x::RationalNumber, n::Int) = n   >= 0 ? RationalNumber(x.a ^ n, x.b ^ n) : inv(x) ^ abs(n)
Base.:^(y::Int, x::RationalNumber) = x.a >= 0 ? (y ^ x.a) ^ (1/x.b)              : inv(y ^ abs(x))