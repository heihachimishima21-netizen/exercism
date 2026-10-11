function recite(pieces)
    lines = ("For want of a $(pieces[i]) the $(pieces[i+1]) was lost." for i in 1:length(pieces)-1)
    Iterators.flatten((lines, (length(pieces) > 0 ? "And all for the want of a $(pieces[1])." : "",))) |> (x -> join(x, '\n'))
end