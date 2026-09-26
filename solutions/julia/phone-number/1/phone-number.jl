function clean(phone_number)
    phone_number = replace(phone_number, r"[ \p{P}]" => "")
    number = match(r"^(?:\+?1)?(?<digits>[2-9]\d{2}[2-9]\d{6})$", phone_number)
    if isnothing(number); throw(ArgumentError("phone_number")); end
    number[:digits]
end