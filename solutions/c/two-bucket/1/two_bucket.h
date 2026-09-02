#ifndef TWO_BUCKET_H
#define TWO_BUCKET_H

#include <stdbool.h>
#include <string.h>

typedef enum { BUCKET_ID_1, BUCKET_ID_2 } bucket_id_t;

typedef unsigned int bucket_liters_t;

typedef struct {
   bool possible;
   int move_count;
   bucket_id_t goal_bucket;
   bucket_liters_t other_bucket_liters;
} bucket_result_t;

typedef struct {
    bucket_liters_t bucket1;
    bucket_liters_t bucket2;
} buckets_t;

typedef struct {
    int move_count;
    buckets_t state;
} queue_item_t;

bucket_liters_t min(bucket_liters_t a, bucket_liters_t b);
void fill(buckets_t *buckets, bucket_id_t bucket, const bucket_liters_t *sizes);
void empty(buckets_t *buckets, bucket_id_t bucket);
void pour(buckets_t *buckets, bucket_id_t bucket, const bucket_liters_t *sizes);
bool check(bucket_liters_t bucket_2_size, 
           bool visited[][bucket_2_size + 1], 
           queue_item_t *queue, 
           const bucket_liters_t *sizes, 
           unsigned int front, 
           unsigned int *end, 
           bucket_liters_t goal_volume, 
           bucket_id_t start_bucket);
bucket_result_t measure(bucket_liters_t bucket_1_size,
                        bucket_liters_t bucket_2_size,
                        bucket_liters_t goal_volume, 
                        bucket_id_t start_bucket);

#endif