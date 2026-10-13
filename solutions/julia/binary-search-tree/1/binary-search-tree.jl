mutable struct BinarySearchTree
    data ::Union{Int,              Nothing}
    left ::Union{BinarySearchTree, Nothing}
    right::Union{BinarySearchTree, Nothing}

    function BinarySearchTree(arr::Vector{Int})
        data  = arr[begin]
        left  = [x for x in arr[2:end] if x <= arr[1]]
        right = [x for x in arr[2:end] if x >  arr[1]]
        left  = isempty(left)  ? nothing : BinarySearchTree(left)
        right = isempty(right) ? nothing : BinarySearchTree(right)
        new(data, left, right)
    end
    
    BinarySearchTree(arr::Int) = new(arr, nothing, nothing)
    
    BinarySearchTree() = new(nothing, nothing, nothing)
end

Base.in(item, B::BinarySearchTree) = (B.left !== nothing && item ∈ B.left) || B.data == item || (B.right !== nothing  && item ∈ B.right)

function Base.push!(B::BinarySearchTree, item::Int)
    if item <= B.data
        B.left  == nothing ? B.left  = BinarySearchTree(item) : push!(B.left,  item) 
    else
        B.right == nothing ? B.right = BinarySearchTree(item) : push!(B.right, item)
    end
    B
end

function Base.sort(tree::BinarySearchTree)
    list = Vector{Int}()
    tree.left  !== nothing && append!(list, sort(tree.left))
    tree.data  !== nothing && push!(list, tree.data)
    tree.right !== nothing && append!(list, sort(tree.right))
    list
end

nodedata(tree::BinarySearchTree) = tree.data
rightnode(tree::BinarySearchTree) = tree.right
leftnode(tree::BinarySearchTree) = tree.left