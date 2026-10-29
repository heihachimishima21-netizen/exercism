enable_bonus_tests = true

struct RationalNumber{T<:Integer} <: Real
    a::T
    b::T
    
    function RationalNumber{T}(a::T, b::T) where {T <: Integer}
        iszero(b) && throw(ArgumentError(""))
        d = gcd(a, b)
        (b < 0) && (d = -d)
        new(a÷d, b÷d)
    end
    
end

RationalNumber{T}(n::Integer) where {T <: Integer} = RationalNumber{T}(T(n), one(T))

function RationalNumber(a::T1, b::T2) where {T1<:Integer, T2<:Integer}
    T = promote_type(T1, T2)
    RationalNumber{T}(T(a), T(b))
end

Base.promote_rule(::Type{RationalNumber{T}}, ::Type{S}) where {T<:Integer,S<:Integer} = RationalNumber{promote_type(T, S)}

numerator(  r::RationalNumber) = r.a
denominator(r::RationalNumber) = r.b

Base.:+(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b + y.a * x.b, x.b * y.b)
Base.:-(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b - y.a * x.b, x.b * y.b)
Base.:*(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.a            , x.b * y.b)
Base.:/(x::RationalNumber, y::RationalNumber) = RationalNumber(x.a * y.b            , x.b * y.a)

Base.abs(x::RationalNumber) = RationalNumber(abs(x.a), x.b)
Base.inv(x::RationalNumber) = RationalNumber(x.b     , x.a)

Base.:^(x::RationalNumber, n::Int) = n   >= 0 ? RationalNumber(x.a ^ n, x.b ^ n) : inv(x) ^ abs(n)
Base.:^(n::Int, x::RationalNumber) = x.a >= 0 ? (n ^ x.a) ^ (1.0/x.b)            : inv(n ^ abs(x))

Base.:(==)(x::RationalNumber, y::RationalNumber) = (x.a, x.b) == (y.a, y.b)
Base.:<(   x::RationalNumber, y::RationalNumber) =  x.a * y.b <   y.a * x.b