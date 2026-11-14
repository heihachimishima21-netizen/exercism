function solve(input_string)
    
    words = [m.match for m in eachmatch(r"[A-Z]+", input_string)] .|> collect
    sums, total = words[1:end-1], words[end]
    any(length(s) > length(total) for s in sums) && return nothing
    front_letters = mapreduce(c -> 1 << (c - 'A'), |, [first(s) for s in (sums..., total) if length(s) > 1]; init=0)
    
    convert_letter = c -> (c - 'A' + 1)
    pad = v -> vcat(fill(0, length(total) - length(v)), v)
    padded_sums = sums .|> (v -> convert_letter.(v)) .|> pad
    
    puzzle = reduce(vcat, permutedims.([padded_sums..., convert_letter.(total)]))

    code  = fill(-1, 26)
    height, width = size(puzzle)
    length(unique(filter(!iszero, puzzle))) > 10 && return nothing

    counts = zeros(Int, 26, width)
    for col in 1:width, row in 1:height-1
        cell = puzzle[row, col]
        cell != 0 && (counts[cell, col] += 1)
    end
    column_letters = [findall(!iszero, @view counts[:, col]) for col in 1:width]

    
    function search!(column, letter_idx, numbers, carry)

        column == 0 && return iszero(carry)
        
        letters = column_letters[column]
        if letter_idx <= length(letters)
            letter = letters[letter_idx]
            code[letter] != -1 && return search!(column, letter_idx + 1, numbers, carry)
            for num in 0:9
                bit = 1 << num
                iszero(numbers & bit) && continue
                iszero(num) && !iszero(front_letters & (1 << (letter - 1))) && continue
                
                code[letter] = num
                search!(column, letter_idx + 1, numbers & ~bit, carry) && return true
                code[letter] = -1
            end
            return false
        end
        
        column_total = carry + sum(l -> counts[l, column] * code[l], letters; init = 0)
        carry, unit = divrem(column_total, 10)
        letter = puzzle[height, column]
        if code[letter] != -1
            return code[letter] == unit && search!(column - 1, 1, numbers, carry)
        end

        unit_bit = 1 << unit
        iszero(numbers & unit_bit) && return false
        iszero(unit) && !iszero(front_letters & (1 << (letter - 1))) && return false
        
        code[letter] = unit
        search!(column - 1, 1, numbers & ~unit_bit, carry) && return true
        code[letter] = -1
        
        return false
    end

    search!(width, 1, Int(0x03ff), 0) ? Dict('A' + i - 1 => c for (i, c) in enumerate(code) if c != -1) : nothing
end