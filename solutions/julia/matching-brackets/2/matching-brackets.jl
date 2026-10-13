function matching_brackets(input_string)
    arr, i = fill('\0', length(input_string)), 0
    for c in input_string
        if c in ('(', '[', '{'); i += 1; arr[i] = c
        elseif c in (')', ']', '}')
            (i == 0 || arr[i] != c - (c == ')' ? 1 : 2)) && return false
            i -= 1
        end
    end
    iszero(i)
end