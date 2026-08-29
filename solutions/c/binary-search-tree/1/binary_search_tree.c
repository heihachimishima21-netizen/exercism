#include "binary_search_tree.h"


node_t *build_tree(int *tree_data, size_t tree_data_len){
    if (tree_data == NULL || tree_data_len == 0)
        return NULL;
    node_t *node;
/*
    int min = tree_data[0], max = tree_data[0], 
        midpoint, mid, ind, radius;
    for (size_t i = 1; i < tree_data_len; i++){
        if (tree_data[i] < min) min = tree_data[i];
        if (tree_data[i] > max) max = tree_data[i];}
    midpoint = (max + min)/2; mid = tree_data[0]; ind = 0; 
    radius = abs(mid - midpoint);
    for (size_t i = 0; i < tree_data_len; i++){
        if (abs(tree_data[i] - midpoint) < radius){
            mid = tree_data[i];
            ind = i;
            radius = abs(tree_data[i] - midpoint);
        }
    } Are you serious? The tests won't let me optimise?
*/
    node_t *root = malloc(sizeof(node_t)), *newNode;
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
    node_t *node = tree, *prevNode;
    char prevDirection = '0';
    while (tree != NULL)
        if (node->left != NULL){
            prevNode = node;
            prevDirection = 'l';
            node = node->left;
        }
        else if (node->right != NULL){
            prevNode = node;
            prevDirection = 'r';
            node = node->right;
        }
        else{
            free(node);
            if (prevDirection == 'l'){
                prevNode->left = NULL;
                node = tree;
                prevDirection = '0';
            }
            else if (prevDirection == 'r'){
                prevNode->right = NULL;
                node = tree;
                prevDirection = '0';
            }
            else
                tree = NULL;
        }
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
    list[*index] = node->data;
    (*index)++;
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