@enum BucketID BUCKET_ID_1=1 BUCKET_ID_2=2

struct queue_item
    move_count::Int
    buckets_state::Tuple{Int, Int}
end

fill(buckets::Tuple{Int, Int}, bucket::BucketID, bucket1_size::Int, bucket2_size::Int) = bucket == BUCKET_ID_1 ? (bucket1_size, buckets[2]) : (buckets[1], bucket2_size)

function pour(buckets::Tuple{Int, Int}, bucket::BucketID, bucket1_size::Int, bucket2_size::Int)
    if bucket == BUCKET_ID_1
        volume = min(buckets[1], bucket2_size - buckets[2])
        buckets .+ (-volume, volume)
    else
        volume = min(buckets[2], bucket1_size - buckets[1])
        buckets .+ (volume, -volume)
    end
end

empty(buckets::Tuple{Int, Int}, bucket::BucketID) = bucket == BUCKET_ID_1 ? (0, buckets[2]) : (buckets[1], 0)

function enqueue_state(buckets_state, state, goal, visited, queue, rear)
    if !visited[(buckets_state .+ 1)...]
        visited[(buckets_state .+ 1)...] = true
        push!(queue, queue_item(state.move_count + 1, buckets_state))
        goal in buckets_state && return true
        rear[] += 1
    end
    false
end

function move(bucket1, bucket2, goal, start, visited, queue, front, rear)
    state = queue[front]; buckets = state.buckets_state
    
    if buckets[1] < bucket1 && (state.move_count != 0 || start == 1)
        buckets_state = fill(buckets, BUCKET_ID_1, bucket1, bucket2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    if buckets[2] < bucket2 && (state.move_count != 0 || start == 2)
        buckets_state = fill(buckets, BUCKET_ID_2, bucket1, bucket2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    
    if buckets[1] > 0
        buckets_state = empty(buckets, BUCKET_ID_1)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
        if buckets[2] < bucket2
            buckets_state = pour(buckets, BUCKET_ID_1, bucket1, bucket2)
            enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
        end
    end
    if buckets[2] > 0
        buckets_state = empty(buckets, BUCKET_ID_2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
        if buckets[1] < bucket1
            buckets_state = pour(buckets, BUCKET_ID_2, bucket1, bucket2)
            enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
        end
    end
    
    false 
end

function twobucket(bucket1, bucket2, goal, start)
    if iszero(goal) return (0, 0, 0); end
    visited = falses(bucket1 + 1, bucket2 + 1); visited[1, 1] = 0
    queue = [queue_item(0, (0, 0))]
    front, rear = 1, Ref(2)
    (BucketID(start) == BUCKET_ID_1) ? (visited[1, bucket2 + 1] = true) : (visited[bucket1 + 1, 1] = true)
    while rear[] > front
        if move(bucket1, bucket2, goal, start, visited, queue, front, rear)
            i = queue[end].buckets_state[1] == goal ? 1 : 2
            return (queue[end].move_count, i, queue[end].buckets_state[3-i])
            break
        end
        front += 1
    end
    throw(DomainError("Impossible"))
end