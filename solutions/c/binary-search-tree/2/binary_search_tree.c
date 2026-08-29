#include "binary_search_tree.h"

node_t *build_tree(int *tree_data, size_t tree_data_len){
    if (tree_data == NULL || tree_data_len == 0)
        return NULL;
    node_t *root = malloc(sizeof(node_t)), *node, *newNode;
    *root = (node_t){NULL, NULL, tree_data[0]};
    for (size_t i = 1; i < tree_data_len; i++){
        node = root;
        while(true)
            if (tree_data[i] <= node->data)
                if(node->left == NULL){
                    newNode = malloc(sizeof(node_t));
                    *newNode = (node_t){NULL, NULL, tree_data[i]};
                    node->left = newNode;  
                    break;
                }
                else node = node->left;
            else
                if(node->right == NULL){
                    newNode = malloc(sizeof(node_t));
                    *newNode = (node_t){NULL, NULL, tree_data[i]};
                    node->right = newNode;
                    break;
                }
                else node = node->right;
    }        
    return root;
}

void free_tree(node_t *tree){
    if (tree == NULL) return;
    free_tree(tree->left);
    free_tree(tree->right);
    free(tree);
}

int size(node_t *tree){
    int count = 1;
    if (tree->left != NULL)
        count += size(tree->left);
    if (tree->right != NULL)
        count += size(tree->right);
    return count;
}

void getlist(node_t *node, int *list, int *index){
    if (node->left != NULL)
        getlist(node->left, list, index);
    list[(*index)++] = node->data;
    if (node->right != NULL)
        getlist(node->right, list, index);
}

int *sorted_data(node_t *tree){
    if (tree == NULL) return NULL;
    int count = size(tree), index = 0;
    int *list = malloc(count*sizeof(int));
    getlist(tree, list, &index);
    return list;
}