struct Tree; root::String; left::Union{Tree, Nothing}; right::Union{Tree, Nothing}; end

function tree_from_traversals(preorder, inorder)
    if length(preorder) != length(inorder) || Set(preorder) != Set(inorder) || length(Set(preorder)) != length(preorder) throw(ArgumentError("")); end
    if iszero(length(preorder)) return nothing; end
    
    left, right = @view(inorder[1:findfirst(==(preorder[1]), inorder)-1]), @view(inorder[findfirst(==(preorder[1]), inorder)+1:end])
    left_pre, right_pre = @view(preorder[2:1+length(left)]), @view(preorder[1+end-length(right):end])
    
    tree  = Tree(preorder[1], isempty(left) ? nothing : tree_from_traversals(left_pre, left), isempty(right) ? nothing : tree_from_traversals(right_pre, right))
end