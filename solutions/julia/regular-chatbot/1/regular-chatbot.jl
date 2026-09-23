is_valid_command(msg) = occursin(r"^chatbot"i, msg)

remove_emoji(msg) = replace(msg, r"emoji\d*" => "")

check_phone_number(number) = (occursin(r"^\(\+\d{2}\) (?:\d{3}-){2}\d{3}$", number) ? 
    "Thanks! You can now download me to your phone." : 
    "Oops, it seems like I can't reach out to $number")

getURL(msg) = (m -> m.match).(eachmatch(r"(\w+\.\w+)", msg))

nice_to_meet_you(str) = replace(str, r"(\w+), (\w+)" => s"Nice to meet you, \2 \1")