#include <stdio.h>
#include <stdlib.h>

typedef struct linked_list_node_t {
    void* data;
    struct linked_list_node_t* next;
} linked_list_node_t;
void create_array_of_linked_list_ptrs(???????? destination, int size) {
    //Fill this body
}
void get_element_of_array_of_linked_list_ptrs(???????? array, int index, ???????? destination){
    //Fill this body
}
void set_element_of_array_of_linked_list_ptrs(???????? array, int index, ???????? head) {
    //Fill this body
}
void destroy_array_of_linked_list_ptrs(???????? array) {
    //Fill this body
}
void resize_array_of_linked_list_ptrs(???????? destination, ???????? array, int size, int new_size){
    //Fill this body
}

void create_link_list(???????? destination){
    //Fill this body
}
void destroy_linked_list(???????? head) {
    //Fill this body
}
void add_to_linked_list(???????? head, const void* data) {
    //Fill this body
}
void remove_from_linked_list(???????? destination, ???????? head, const void* data) {
    //Fill this body
}

typedef struct song_t {
    const char* name;
    float duration;
} song_t;
void create_song(song_t* destination, const char* name, float duration) {
    //Fill this body
}

???????? array_of_playlist_ptrs = NULL;

int main(void){
    //Fill this body
    return 0;
}