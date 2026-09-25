tested_bonus_tasks = (rev = true, by = true, lt = true, multiple_matches = true)

function binarysearch(data, value; rev = false, by = false, lt = <)
    min = 1; max = length(data)
    if max == 0; return min:max; end
    m = (min + max)÷2
    
    if by != false
        data .= by.(data)
        value = by(value)
    end
    
    while true
        m = (min + max)÷2
        if data[m] == value; break
        elseif min == max; return m:(m-1)
        elseif lt(data[m], value)
            if rev == true; max = m
            else
                if min == m; min += 1
                else min = m
                end
            end
        else
            if rev == true
                if min == m; min += 1
                else min = m
                end
            else; max = m
            end
        end
    end

    a, b, l = m, m, length(data)
    while true
        flag = true
        if a > 1 && data[a-1] == data[a]
            a -= 1
            flag = false
        end
        if b < l && data[b+1] == data[b]
            b += 1
            flag = false
        end
        if flag; return a:b; end
    end

end