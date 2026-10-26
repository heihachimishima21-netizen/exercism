struct queue_item move_count::Int; buckets_state::Tuple{Int, Int}; end

fill(buckets::Tuple{Int, Int}, bucket::Int, bucket1_size::Int, bucket2_size::Int) = isone(bucket) ? (bucket1_size, buckets[2]) : (buckets[1], bucket2_size)

function pour(buckets::Tuple{Int, Int}, bucket::Int, bucket_size::Tuple{Int, Int})
    volume = min(buckets[bucket], bucket_size[3-bucket] - buckets[3-bucket])
    buckets .+ (isone(bucket) ? (-volume, volume) : (volume, -volume))
end

empty(buckets::Tuple{Int, Int}, bucket::Int) = isone(bucket) ? (0, buckets[2]) : (buckets[1], 0)

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
        buckets_state = fill(buckets, 1, bucket1, bucket2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    if buckets[2] < bucket2 && (state.move_count != 0 || start == 2)
        buckets_state = fill(buckets, 2, bucket1, bucket2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    
    if buckets[1] > 0
        buckets_state = empty(buckets, 1)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    if buckets[2] > 0
        buckets_state = empty(buckets, 2)
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end

    if buckets[1] > 0 && buckets[2] < bucket2
        buckets_state = pour(buckets, 1, (bucket1, bucket2))
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    if buckets[2] > 0 && buckets[1] < bucket1
        buckets_state = pour(buckets, 2, (bucket1, bucket2))
        enqueue_state(buckets_state, state, goal, visited, queue, rear) && return true
    end
    
    false 
end

function twobucket(bucket1::Int, bucket2::Int, goal::Int, start::Int)
    visited = falses(bucket1 + 1, bucket2 + 1); visited[1, 1] = 0
    queue = [queue_item(0, (0, 0))]
    front, rear = 1, Ref(2)
    (isone(start)) ? (visited[1, bucket2 + 1] = true) : (visited[bucket1 + 1, 1] = true)
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