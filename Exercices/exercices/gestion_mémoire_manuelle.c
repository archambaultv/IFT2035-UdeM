// Gestion mémoire manuel
#include <stdio.h>
#include <stdlib.h>

typedef struct list_elem list_elem;
struct list_elem {
  void *value;
  list_elem *next;
};

typedef struct list list;
struct list { list_elem *head; };

list* list_alloc () {
  list *newlst = malloc(sizeof(list));
  if (newlst) { /* newlst != NULL */
    newlst->head = NULL;
  }
  return newlst;
}

void list_insert (list *l, void *v) {
  if(l) {
    list_elem *elem = malloc(sizeof(list_elem));
    if (elem) { // elem != NULL
      elem->next = l->head;
      l->head = elem;
      elem->value = v;
    }
  }
}

void *list_get   (list *l, int n) {
  if(!l) return NULL;
  list_elem *elem = l->head;
  while(elem && n > 0) { // elem != NULL
    elem = elem->next;
    n--;
  }
  return n == 0 && elem != NULL ? elem->value : NULL;
}

void* list_remove (list *l) {
  void *elem = NULL;
  if (l != NULL) {
    list_elem *head = l->head;
    elem = head->value;
    l->head = head != NULL ? head->next : NULL;
    free(head);
  }
  return elem;
}

void list_free(list *l) {
  if(l) {
    while(l->head) {
      list_remove(l);
    }
    free(l);
  }
}

// Exemple utilisation
int main(int argc, char **argv) {
  list *lst = list_alloc();
  const int size = 5;
  for(long i = 0; i < size; ++i) {
    list_insert(lst, (void*)i);
  }
  int i = 0;
  while(i < size) {
    printf("list_get(lst, %i): %ld\n", i, (long)list_get(lst, i));
    i++;
  }
  list_free(lst);
  return 0;
}
