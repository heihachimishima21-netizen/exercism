function clean(phone_number)
    number = match(r"^1?(?<digits>[2-9]\d{2}[2-9]\d{6})$", replace(phone_number, r"[^\d]" => ""))
    isnothing(number) ? throw(ArgumentError("phone_number")) : number[:digits]
end