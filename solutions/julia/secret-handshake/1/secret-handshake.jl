const actions = ["wink", "double blink", "close your eyes", "jump"]

function secret_handshake(code)
    reversed = Bool((code >> 4) & 1)
    handshake = []
    for i in 0:3
        if code >> ((reversed) ? 3 - i : i) & 1 == 1
            push!(handshake, actions[(reversed) ? 4 - i : i + 1])
        end
    end
    handshake
end