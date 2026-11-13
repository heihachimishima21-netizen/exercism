function solve(input_string)
    
    sums  = (m -> m.captures[1]).(eachmatch(r"([A-Z]+) ", input_string)) .|> collect
    total = match(r"== ([A-Z]+)", input_string)[1] |> collect
    any(length(s) > length(total) for s in sums) && return nothing
    front_letters = mapreduce(c -> 1 << (c - 'A'), |, [first.(sums)..., total[1]]; init=0)
    
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
    column_letters = [findall(!iszero, counts[:, col]) for col in 1:width]

    function search!(column, k, numbers, carry)

        column == 0 && return iszero(carry)
        
        letters = column_letters[column]
        if k <= length(letters)
            letter = letters[k]
            code[letter] != -1 && return search!(column, k + 1, numbers, carry)
            for num in 0:9
                bit = 1 << num
                (iszero(numbers & bit) || (iszero(num) && !iszero(front_letters & (1 << (letter - 1))))) && continue##############abreviatefrontletters
                code[letter] = num
                search!(column, k + 1, numbers & ~bit, carry) && return true
                code[letter] = -1
            end
            return false
        end

        column_total = carry + sum(l -> counts[l, column] * code[l], letters; init = 0)
        #=column_total = carry
        for l in letters
            column_total += counts[l, column] * code[l]
        end=#
        
        carry, unit = divrem(column_total, 10)
        letter = puzzle[height, column]
        if code[letter] != -1
            if code[letter] == unit
                search!(column - 1, 1, numbers, carry) && return true
            end
            return false
        end

        unit_bit = 1 << unit
        iszero(numbers & unit_bit) && return false
        iszero(unit) && !iszero(front_letters & (1 << (letter - 1))) && return false
        code[letter] = unit
        search!(column - 1, 1, numbers & ~unit_bit, carry) && return true
        code[letter] = -1
        
        
        #=if  letter |> iszero
            search!(slot + 1, numbers, carry) && return true
    
        elseif !preset
            if row == height
                carry, unit = column_sum(column, carry)
                if !iszero(numbers & (1 << unit))
                    iszero(unit) && !iszero(front_letters & (1 << (letter - 1))) && return false
                    code[letter] = unit
                    #numbers &= ~(1 << unit)
                    search!(slot + 1, numbers & ~(1 << unit), carry) && return true
                    #numbers |= (1 << unit)
                    code[letter] = -1
                end
            else
                for num in 0:9
                    (iszero(numbers & (1 << num)) || (iszero(num) && !iszero(front_letters & (1 << (letter - 1))))) && continue
                    code[letter] = num
                    #numbers &= ~(1 << num)
                    search!(slot + 1, numbers & ~(1 << unit), carry) && return true
                    #numbers |= (1 << num)
                    code[letter] = -1
                end
            end
    
        else
            if row == height
                carry, unit = column_sum(column, carry)
                if code[letter] == unit
                    search!(slot + 1, numbers, carry) && return true
                end
            else
                search!(slot + 1, numbers, carry) && return true
            end
        end=#
        return false
    end

    search!(width, 1, Int(0x03ff), 0) ? Dict('A' + i - 1 => c for (i, c) in enumerate(code) if c != -1) : nothing
    #search!(1, Int(0x03ff), 0) ? Dict('A' + i - 1 => c for (i, c) in enumerate(code) if c != -1) : nothing
end