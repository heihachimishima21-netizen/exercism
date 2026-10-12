function spiral_matrix(n)
    spiral = zeros(Int, n, n)
    left, top, right, bottom, k = 1, 1, n, n, 1
    while k <= n^2
        for i in left:right
            spiral[top, i] = k
            k += 1
        end
        for i in top+1:bottom
            spiral[i, right] = k;
            k += 1
        end
        for i in right-1:-1:left
            spiral[bottom, i] = k;
            k += 1
        end
        for i in bottom-1:-1:top+1
            spiral[i, left] = k;
            k += 1
        end
        left += 1; right -= 1; top += 1; bottom -= 1;
    end
    spiral
end