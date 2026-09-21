function parity(byte)
    folded_bits = byte
    i = 4
    while i > 0
        folded_bits ⊻= folded_bits >> i
        i >>= 1
    end
    folded_bits &= 1
    byte ⊻= folded_bits
    byte
end

function test(message)
    for byte in message
        folded_bits = byte
        j = 4
        while j > 0
            folded_bits ⊻= folded_bits >> j
            j >>= 1
        end
        if folded_bits & 1 == 1; return 1; end
    end
    0
end

function get_transmit_sequence(message)
    if isempty(message); return []; end
    buffer = UInt8[]
    for i in eachindex(message)
        if (i - 1) % 7 == 0
            push!(buffer, parity(message[i]))
        else
            byte = message[i] >> ((i - 1) % 7)
            byte |= message[i - 1] << (8 - (i - 1) % 7)
            push!(buffer, parity(byte))
            if (i - 1) % 7 == 6
                push!(buffer, parity(message[i] << 1))
            end
        end
    end
    j = length(buffer)
    if j % 7 != (length(message) ÷ 7) % 7
        byte = message[end] << (8 - j % 8)
        push!(buffer, parity(byte))
    end
    buffer
end

function decode_sequence(received_seq)
    if isempty(received_seq); return []; end
    if test(received_seq) != 0; error("Invalid parity"); end
    decoded_length = (length(received_seq) * 7) ÷ 8
    buffer = UInt8[]
    i = 1
    for j in 1:decoded_length
        if j > 1 && (j - 1) % 7 == 0
            i += 1
        end
        byte = (UInt8(received_seq[i]) & 0xfe) << ((j - 1) % 7)
        if i + 1 <= length(received_seq)
            byte |= UInt8(received_seq[i + 1] >> (7 - (j - 1) % 7))
        end
        push!(buffer, byte)
        i += 1
    end
    buffer
end