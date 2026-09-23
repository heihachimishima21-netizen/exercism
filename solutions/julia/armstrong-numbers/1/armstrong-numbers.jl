function isarmstrong(num)
    len = 0; sum = 0; m = num; n = num
    while n != 0
        n ÷= 10
        len += 1
    end
    for i in 1:len
        sum += (m % 10)^len
        m ÷= 10
    end
    sum == num
end