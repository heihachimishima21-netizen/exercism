struct Tree; root::String; left::Union{Tree, Nothing}; right::Union{Tree, Nothing}; end

function tree_from_traversals(preorder, inorder)
    if length(preorder) != length(inorder) || Set(preorder) != Set(inorder) || length(Set(preorder)) != length(preorder) throw(ArgumentError("")); end

    function build(pre, ino)
        if isempty(pre) return nothing; end
        
        i            = findfirst(==(pre[1]), ino)
        l_pre, r_pre = @view(pre[2:i  ]), @view(pre[i+1:end])
        l_in , r_in  = @view(ino[1:i-1]), @view(ino[i+1:end])
    
        Tree(pre[1], build(l_pre, l_in), build(r_pre, r_in))
    end
    
    build(preorder, inorder)
end