struct Tree; root::String; left::Union{Tree, Nothing}; right::Union{Tree, Nothing}; end

function tree_from_traversals(pre, ino)
    if length(pre) != length(ino) || Set(pre) != Set(ino) || length(Set(pre)) != length(pre) throw(ArgumentError(""))
    elseif iszero(length(pre)) return nothing; end
    
    l_in, r_in = @view(ino[1:findfirst(==(pre[1]), ino)-1]), @view(ino[findfirst(==(pre[1]), ino)+1:end])
    
    l_pre, r_pre = @view(pre[2:1+length(l_in)]), @view(pre[1+end-length(r_in):end])
    
    Tree(pre[1], tree_from_traversals(l_pre, l_in), tree_from_traversals(r_pre, r_in))
end