function solve(slot, puzzle, code, numbers, front_letters, height, width, final, carry)
    slot == final + 1 && return iszero(carry)
    
    row, column = 1 + (slot - 1)%height, width - (slot - 1)÷height
    preset = puzzle[row, column] != 0 && code[puzzle[row, column]] isa Number
    
    if  puzzle[row, column] == 0
        solve(slot + 1, puzzle, code, numbers, front_letters, height, width, final, carry) && return true
        
    elseif !preset
        if row == height
            summation = carry + sum(x -> x == 0 ? 0 : code[x], @view puzzle[begin:end-1, column])
            unit, carry = summation%10, summation÷10
            if !iszero(numbers & (1 << unit))
                if iszero(unit) && (puzzle[row, column] ∈ front_letters)
                    return false
                end
                slot == final && iszero(unit) && return false
                code[puzzle[row, column]] = unit
                numbers &= ~(1 << unit)
                solve(slot + 1, puzzle, code, numbers, front_letters, height, width, final, carry) && return true
                numbers |= (1 << unit)
                code[puzzle[row, column]] = puzzle[row, column]
            end
        else
            for num in 0:9
                (iszero(numbers & (1 << num)) || (iszero(num) && (puzzle[row, column] ∈ front_letters))) && continue
                code[puzzle[row, column]] = num
                numbers &= ~(1 << num)
                solve(slot + 1, puzzle, code, numbers, front_letters, height, width, final, carry) && return true
                numbers |= (1 << num)
                code[puzzle[row, column]] = puzzle[row, column]
            end
        end
        
    else
        if row == height
            summation = carry + sum(x -> x == 0 ? 0 : code[x], @view puzzle[begin:end-1, column])
            unit, carry = summation%10, summation÷10
            if code[puzzle[row, column]] == unit
                solve(slot + 1, puzzle, code, numbers, front_letters, height, width, final, carry) && return true
            end
        else
            solve(slot + 1, puzzle, code, numbers, front_letters, height, width, final, carry) && return true
        end
    end
    return false
end

function solve(input_string)
    sums  = (m -> m.captures[1]).(eachmatch(r"([A-Z]+) ", input_string)) .|> collect
    total = match(r"== ([A-Z]+)", input_string)[1] |> collect
    any(length(s) > length(total) for s in sums) && return nothing
    front_letters = Set([first.(sums)..., total[1]])
    padded_sums = sums .|> v -> vcat(fill(0, length(total) - length(v)), v)
    sum_matrix = reduce(vcat, permutedims.(padded_sums))
    puzzle = vcat(sum_matrix, permutedims(total))

    numbers = mask::UInt16 = 0x03ff
    code  = Dict{Char, Union{Char, Int}}(x => x for x in input_string if isletter(x))
    height, width = size(puzzle)
    final = length(puzzle)
    letters = unique(puzzle[r, c] for c in width:-1:1 for r in 1:height if puzzle[r, c] != 0)
    length(letters) > 10 && return nothing
    
    solve(1, puzzle, code, numbers, front_letters, height, width, final, 0) ? code : nothing
end