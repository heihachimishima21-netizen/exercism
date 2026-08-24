#include "linked_list.h"

struct list_node {
   struct list_node *prev, *next;
   ll_data_t data;
};

struct list {
   struct list_node *first, *last;
};


struct list *list_create(void){
    struct list *new = malloc(sizeof(struct list));
    *new = (struct list){NULL};
    return new;
}

size_t list_count(const struct list *list){
    if (list->first == NULL) return 0;
    size_t count = 1;
    struct list_node *station = list->first;
    while (station->next){
        station = station->next;
        count++;
    }
    return count;    
}

void list_push(struct list *list, ll_data_t item_data){
    struct list_node *new = malloc(sizeof(struct list_node));
    new->data = item_data;
    new->next = NULL;
    if (list_count(list)){
        new->prev = list->last;
        list->last->next = new;
    }
    else list->first = new;
    list->last = new;
}

ll_data_t list_pop(struct list *list){
    if (list->first == NULL) return 0;
    ll_data_t data = list->last->data;
    struct list_node *tmpPtr = list->last;
    if (list->first != list->last){
        list->last = list->last->prev;
        list->last->next = NULL;
    }
    else list->first = list->last = NULL;
    free(tmpPtr);
    return data;
}

void list_unshift(struct list *list, ll_data_t item_data){
    struct list_node *new = malloc(sizeof(struct list_node));
    new->data = item_data;
    new->prev = NULL;
    if (list_count(list)){
        new->next = list->first;
        list->first->prev = new;
    }
    else list->last = new;
    list->first = new;
}

ll_data_t list_shift(struct list *list){
    if (list->first == NULL) return 0;
    ll_data_t data = list->first->data;
    struct list_node *tmpPtr = list->first;
    if (list->first != list->last){
        list->first = list->first->next;
        list->first->prev = NULL;
    }
    else list->first = list->last = NULL;
    free(tmpPtr);
    return data;
}

void list_delete(struct list *list, ll_data_t data){
    struct list_node *nodePtr = list->first;
    while (nodePtr)
        if (nodePtr->data == data){
            if (nodePtr == list->first) list_shift(list);
            else if (nodePtr == list->last) list_pop(list);
            else{
                nodePtr->prev->next = nodePtr->next;
                nodePtr->next->prev = nodePtr->prev;
                free(nodePtr);
            }
            break;  
        }
        else nodePtr = nodePtr->next;
}

void list_destroy(struct list *list){
    struct list_node *nodePtr, *tmpPtr;
    if (list->first !=NULL){
        nodePtr = list->first;
        while (nodePtr->next != NULL){
            tmpPtr = nodePtr;
            nodePtr = nodePtr->next;
            free(tmpPtr);
        }
        free(nodePtr);
    }
    free(list);
}