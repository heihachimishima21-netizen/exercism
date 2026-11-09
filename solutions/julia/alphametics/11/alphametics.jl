function solve(input_string)

    function search!(slot, numbers, carry)
    
        function column_sum(carry)
            summation = carry + sum(x -> x == 0 ? 0 : code[x], @view puzzle[begin:end-1, column])
            return summation % 10, summation ÷ 10
        end
    
    
        slot == final + 1 && return iszero(carry)
        
        row, column = 1 + (slot - 1)%height, width - (slot - 1)÷height
        letter = puzzle[row, column]
        preset = letter != 0 && code[letter] != -1
    
        if  letter == 0
            search!(slot + 1, numbers, carry) && return true
    
        elseif !preset
            if row == height
                unit, carry = column_sum(carry)
                if !iszero(numbers & (1 << unit))
                    iszero(unit) && (letter ∈ front_letters) && return false
                    code[letter] = unit
                    numbers &= ~(1 << unit)
                    search!(slot + 1, numbers, carry) && return true
                    numbers |= (1 << unit)
                    code[letter] = -1
                end
            else
                for num in 0:9
                    (iszero(numbers & (1 << num)) || (iszero(num) && (letter ∈ front_letters))) && continue
                    code[letter] = num
                    numbers &= ~(1 << num)
                    search!(slot + 1, numbers, carry) && return true
                    numbers |= (1 << num)
                    code[letter] = -1
                end
            end
    
        else
            if row == height
                unit, carry = column_sum(carry)
                if code[letter] == unit
                    search!(slot + 1, numbers, carry) && return true
                end
            else
                search!(slot + 1, numbers, carry) && return true
            end
        end
        return false
    end


    sums  = (m -> m.captures[1]).(eachmatch(r"([A-Z]+) ", input_string)) .|> collect
    total = match(r"== ([A-Z]+)", input_string)[1] |> collect
    any(length(s) > length(total) for s in sums) && return nothing
    front_letters = Set(Int(c) - 64 for c in [first.(sums)..., total[1]])
    padded_sums = sums .|> v -> vcat(fill(0, length(total) - length(v)), v)
    sum_matrix = reduce(vcat, permutedims.(padded_sums))
    letter_puzzle = vcat(sum_matrix, permutedims(total))
    puzzle = map(c -> c == 0 ? 0 : Int(c) - 64, letter_puzzle)

    code  = fill(-1, 26)
    height, width, final = size(puzzle)..., length(puzzle)
    length(unique(filter(!iszero, puzzle))) > 10 && return nothing
    
    search!(1, 0x03ff, 0) ? Dict(Char(i + 64) => c for (i, c) in enumerate(code) if c != -1) : nothing
end