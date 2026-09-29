all_15(ratings) = all(x -> x == 1 || x == 5, ratings)

emphatics(customers) = filter(x -> all_15(collect(last(x))), customers)

tobinary(ratings) = (x -> x == 5 ? 1 : 0).(ratings)

tobinarymatrix(ratings) = mapreduce(tobinary∘transpose, vcat, ratings)