#ifndef BINARY_SEARCH_TREE_H
#define BINARY_SEARCH_TREE_H

#include <stddef.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct node node_t;

struct node {
   node_t *right;
   node_t *left;
   int data;
};

node_t *build_tree(int *tree_data, size_t tree_data_len);
void free_tree(node_t *tree);
int size(node_t *tree);
void getlist(node_t *node, int *list, int *index);
int *sorted_data(node_t *tree);

#endif