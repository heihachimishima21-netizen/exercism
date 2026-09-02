#include "two_bucket.h"

bucket_liters_t min(bucket_liters_t a, bucket_liters_t b){
    return (a < b) ? a : b;
}

void fill(buckets_t *buckets, 
          bucket_id_t bucket, 
          const bucket_liters_t *sizes)
{ 
    if (bucket == BUCKET_ID_1) 
        buckets->bucket1 = sizes[BUCKET_ID_1]; 
    else if (bucket == BUCKET_ID_2) 
        buckets->bucket2 = sizes[BUCKET_ID_2];
}

void empty(buckets_t *buckets, bucket_id_t bucket)
{
    if (bucket == BUCKET_ID_1) 
        buckets->bucket1 = 0;
    else if (bucket == BUCKET_ID_2) 
        buckets->bucket2 = 0;
}

void pour(buckets_t *buckets, 
          bucket_id_t bucket, 
          const bucket_liters_t *sizes)
{
    bucket_liters_t volume;
    if (bucket == BUCKET_ID_1) 
    { 
        volume = min(buckets->bucket1, sizes[BUCKET_ID_2] - buckets->bucket2); 
        buckets->bucket1 -= volume; 
        buckets->bucket2 += volume; 
    } 
    else if (bucket == BUCKET_ID_2) 
    { 
        volume = min(buckets->bucket2, sizes[BUCKET_ID_1] - buckets->bucket1); 
        buckets->bucket2 -= volume; 
        buckets->bucket1 += volume; 
    }   
}

bool check(bucket_liters_t bucket_2_size, 
          bool visited[][bucket_2_size + 1],
          queue_item_t *queue,
          const bucket_liters_t *sizes, 
          unsigned int front, 
          unsigned int *end, 
          bucket_liters_t goal_volume,
          bucket_id_t start_bucket)
{
    queue_item_t state = queue[front];
    buckets_t buckets = state.state;
    if (state.move_count == 0){
        if (start_bucket == BUCKET_ID_1)
            goto fill1;
        else
            goto fill2;
    }
    if (buckets.bucket1 > 0 && 
        buckets.bucket2 < sizes[BUCKET_ID_2]){
        pour(&buckets, BUCKET_ID_1, sizes);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    if (buckets.bucket2 > 0 && 
        buckets.bucket1 < sizes[BUCKET_ID_1]){
        pour(&buckets, BUCKET_ID_2, sizes);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    if (buckets.bucket1 > 0){
        empty(&buckets, BUCKET_ID_1);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    if (buckets.bucket2 > 0){
        empty(&buckets, BUCKET_ID_2);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    if (buckets.bucket1 < sizes[BUCKET_ID_1]){
        fill1:
        fill(&buckets, BUCKET_ID_1, sizes);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    if (buckets.bucket2 < sizes[BUCKET_ID_2]){
        fill2:
        fill(&buckets, BUCKET_ID_2, sizes);
        if (visited[buckets.bucket1][buckets.bucket2] == false){
            visited[buckets.bucket1][buckets.bucket2] = true;
            queue[*end] = (queue_item_t){state.move_count + 1, buckets};
            if (buckets.bucket1 == goal_volume || buckets.bucket2 == goal_volume)
                return true;
            (*end)++;
        }
        buckets = state.state;       
    }
    return false;
}

bucket_result_t measure(bucket_liters_t bucket_1_size,
                        bucket_liters_t bucket_2_size,
                        bucket_liters_t goal_volume,
                        bucket_id_t start_bucket)
{
    bool found;
    bucket_result_t process = {0};
    if (goal_volume == 0) return (bucket_result_t){true, 0, start_bucket, 0};
    const bucket_liters_t sizes[] = {bucket_1_size, bucket_2_size};
    bool visited[bucket_1_size + 1][bucket_2_size + 1];
    memset(visited, 0, sizeof(visited));
    queue_item_t queue[(bucket_1_size + 1)*(bucket_2_size + 1)];
    unsigned int front = 0, end = 1;
    queue[0] = (queue_item_t){0, (buckets_t){0, 0}};
    visited[0][0] = true;
    if (start_bucket == BUCKET_ID_1)
        visited[0][bucket_2_size] = true;
    else
        visited[bucket_1_size][0] = true;
    while (end > front){
        found = check(bucket_2_size, visited, queue, sizes, 
                      front, &end, goal_volume, start_bucket);
        front++;
        if (found){
            process.possible = true;
            process.move_count = queue[end].move_count;
            if (queue[end].state.bucket1 == goal_volume){
                process.goal_bucket = BUCKET_ID_1;
                process.other_bucket_liters = queue[end].state.bucket2;
            }
            else{
                process.goal_bucket = BUCKET_ID_2;
                process.other_bucket_liters = queue[end].state.bucket1; 
            }
            break;
        }
    }
    return process;
}