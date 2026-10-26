@enum BucketID BUCKET_ID_1=1 BUCKET_ID_2

struct queue_item
    move_count::Int
    buckets_state::Tuple{Int, Int}
end

function fill(buckets::Tuple{Int, Int}, bucket::BucketID,
              bucket1_size::Int, bucket2_size::Int)
    #iszero(buckets[1])   ? (bucket1_size, 0) : (0, bucket2_size)
    bucket == BUCKET_ID_1 ? (bucket1_size, buckets[2]) : (buckets[1], bucket2_size)
end

function empty(buckets::Tuple{Int, Int}, bucket::BucketID,
               bucket1_size::Int, bucket2_size::Int)
    bucket == BUCKET_ID_1 ? (0, buckets[2]) : (buckets[1], 0)
end

function pour(buckets::Tuple{Int, Int}, bucket::BucketID,
              bucket1_size::Int, bucket2_size::Int)
    if bucket == BUCKET_ID_1
        volume = min(buckets[1], bucket2_size - buckets[2])
        return buckets .+ (-volume, volume)##########
    else
        volume = min(buckets[2], bucket1_size - buckets[1])
        return buckets .+ (volume, -volume)##########
    end
end





function move(bucket1, bucket2, goal, start, visited, queue, front, rear)
    state = queue[front]
    buckets = state.buckets_state
    #@show state
    if buckets[1] < bucket1  && (state.move_count != 0 || start == 1)
        buckets_state = fill(buckets, BUCKET_ID_1, bucket1, bucket2)
        #@show (buckets_state .+ 1)
       # @show visited[4, 1]
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, @show queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    if buckets[2] < bucket2 && (state.move_count != 0 || start == 2)
        buckets_state = fill(buckets, BUCKET_ID_2, bucket1, bucket2)
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    
    if buckets[1] > 0 && buckets[2] < bucket2
        buckets_state = pour(buckets, BUCKET_ID_1, bucket1, bucket2)
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    if buckets[2] > 0 && buckets[1] < bucket1
        buckets_state = pour(buckets, BUCKET_ID_2, bucket1, bucket2)
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    
    if buckets[1] > 0
        buckets_state = empty(buckets, BUCKET_ID_1, bucket1, bucket2)
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    if buckets[2] > 0
        buckets_state = empty(buckets, BUCKET_ID_2, bucket1, bucket2)
        if visited[(buckets_state .+ 1)...] == false
            visited[(buckets_state .+ 1)...] = true
            push!(queue, queue_item(state.move_count + 1, buckets_state))
            if goal in buckets_state
                return true
            end
            rear[] += 1
        end
    end
    
    false 
end

function twobucket(bucket1, bucket2, goal, start)
    @show start == BUCKET_ID_1
@show typeof(start)
@show typeof(BUCKET_ID_1)
    if iszero(goal) return (0, 0, 0); end
    visited = falses(bucket1 + 1, bucket2 + 1)
    visited[1, 1] = 0
    queue = [queue_item(0, (0, 0))]
    front, rear = 1, Ref(2)
    if (BucketID(start) == BUCKET_ID_1)
        visited[1, bucket2 + 1] = true
    else
        visited[bucket1 + 1, 1] = true
    end
   # @show start
    #@show visited[4, 1]
    process = (0, 0, 0)
    #@show bucket1, bucket2, goal, start, front, rear[]
    #@show visited[4, 1]
    while rear[] > front
        found = move(bucket1, bucket2, goal, start, visited, queue, front, rear)
        if found
            count = queue[end].move_count#
            if queue[end].buckets_state[1] == goal #i = queue[end].buckets_state[1] == goal ? 1 : 2
                bucket = 1
                other = queue[end].buckets_state[2]
            else
                bucket = 2
                other = queue[end].buckets_state[1]
            end
            return process = (count, bucket, other) #(queue[end].move_count, i, queue[end].buckets_state[3-i])
            break
        end
        front += 1
    end
    throw(DomainError("")) #process
end