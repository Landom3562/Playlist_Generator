#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct linked_list_node_t {
    void* data;
    struct linked_list_node_t* next;
} linked_list_node_t;
void create_array_of_linked_list_ptrs(linked_list_node_t*** destination, int size) {
    linked_list_node_t** array_of_linked_list_ptrs = (linked_list_node_t**)malloc(sizeof(linked_list_node_t)*size);
    for(int i = 0; i<size ; i++){
        array_of_linked_list_ptrs[i] = NULL;
    }
    *destination = array_of_linked_list_ptrs;
}
void get_element_of_array_of_linked_list_ptrs(linked_list_node_t** array, int index, linked_list_node_t** destination){
    *destination = array[index];
}
void set_element_of_array_of_linked_list_ptrs(linked_list_node_t** array, int index, linked_list_node_t* head) {
    linked_list_node_t* replaced = array[index];
    if(replaced != NULL){
        free(replaced);
    }
    array[index] = head;
}
void destroy_array_of_linked_list_ptrs(linked_list_node_t** array) {
    free(array);
}
void resize_array_of_linked_list_ptrs(linked_list_node_t*** destination, linked_list_node_t** array, int size, int new_size){
    *destination = (linked_list_node_t**)realloc(array, new_size*sizeof(linked_list_node_t));
}

void create_link_list(linked_list_node_t** destination){
    linked_list_node_t* head = (linked_list_node_t*)malloc(sizeof(linked_list_node_t));
    head->data = NULL;
    head->next = NULL;
    *destination = head;
}
void destroy_linked_list(linked_list_node_t* head) {
    if(head == NULL){
        return;
    }
    linked_list_node_t* next = head->next;
    while(next != NULL){
        free(head);
        head = next;
        next = next->next;
    }
    free(head);
}
void add_to_linked_list(linked_list_node_t* head, const void* data) {
    if(head->data == NULL){
        head->data = (void*)data;
    }else{
        while(head->next != NULL){
            head = head->next;
        }
        linked_list_node_t* added = (linked_list_node_t*)malloc(sizeof(linked_list_node_t));
        added->data = (void*)data;
        added->next = NULL;
        head->next = added;
    }
}
void remove_from_linked_list(linked_list_node_t** destination, linked_list_node_t* head, const void* data) { 
    linked_list_node_t* previous = NULL;
    while(head != NULL){
        if((void*)data == head->data){
            if(previous == NULL){
                linked_list_node_t* removed = head->next;
                head->data = removed->data;
                head->next = removed->next;
                removed->next =NULL; //This is done because after removing the node and trying to destroy it, the function destroyed every node after the removed node.
                *destination = removed;
            }else{
                previous->next = head->next;
                head->next = NULL;
                *destination = head;
                return;
            }
        }
        previous = head;
        head = head->next;
    }
}

typedef struct song_t {
    const char* name;
    float duration;
} song_t;
void create_song(song_t* destination, const char* name, float duration) {
    destination->name = name;
    destination->duration = duration;
}

linked_list_node_t** array_of_playlist_ptrs = NULL;

int main(void){
    srand(time(NULL));

    char *titles[] = {
        "Song of the Wind", "Moonlight Sonata", "Bohemian Rhapsody", "Stairway to Heaven",
        "Imagine", "Yesterday", "Purple Haze", "Black Dog", "Hotel California",
        "Paint It Black", "Hallelujah", "Thriller", "All Star", "Sweet Child o' Mine",
        "Smells Like Teen Spirit", "Billie Jean", "Like a Rolling Stone", "Let It Be",
        "Hey Jude", "Comfortably Numb", "Piano Man", "Wonderwall", "Lose Yourself",
        "My Heart Will Go On", "Radioactive", "All You Need Is Love", "Under the Bridge",
        "Let's Get It On", "I Want to Hold Your Hand", "Otherside"
    };//Random song titles.

    //Part 1
    create_array_of_linked_list_ptrs(&array_of_playlist_ptrs,5);

    //Part 2
    for(int i = 0; i < 5; i++){
        linked_list_node_t* playlist;
        create_link_list(&playlist);
        set_element_of_array_of_linked_list_ptrs(array_of_playlist_ptrs,i,playlist);
    }
    linked_list_node_t** resized_array_of_playlist_ptrs;
    resize_array_of_linked_list_ptrs(&resized_array_of_playlist_ptrs,array_of_playlist_ptrs,5,10);
    for(int i = 5; i < 10; i++){
        linked_list_node_t* playlist;
        create_link_list(&playlist);
        set_element_of_array_of_linked_list_ptrs(resized_array_of_playlist_ptrs,i,playlist);
    }

    //Part 3
    song_t* songsToBeRemoved[10];
    for(int i = 0; i < 10; i++){
        for(int j = 0; j < 4; j++){
            int title_index = rand() % 30;
            const char* title = titles[title_index];
            float duration = ((float)rand() / (float)RAND_MAX)*5 + 3; //This generates a random float between 3 and 8.
            song_t* song = (song_t*)malloc(sizeof(song));
            create_song(song,title,duration);
            add_to_linked_list(resized_array_of_playlist_ptrs[i],song);
            if(j ==  1){
                songsToBeRemoved[i] = song;
            }
        }
    }

    //Part 4
    for(int i = 0; i < 10; i++){
        linked_list_node_t* removed;
        remove_from_linked_list(&removed,resized_array_of_playlist_ptrs[i],songsToBeRemoved[i]);
        destroy_linked_list(removed);
    }

    //Part 5
    for(int i = 0; i < 10; i++){
        linked_list_node_t* playlist = resized_array_of_playlist_ptrs[i];
        printf("Playlist #%d\n", i);
        while(playlist != NULL){
            song_t* song = (song_t*)playlist->data;
            printf("Name: %s, Duration: %f\n",song->name, song->duration);
            playlist = playlist->next;
        }
    }

    //Part 6
    for(int i = 0; i < 10; i++){
        destroy_linked_list(resized_array_of_playlist_ptrs[i]);
    }

    //Part 7
    destroy_array_of_linked_list_ptrs(resized_array_of_playlist_ptrs);

    return 0;
}