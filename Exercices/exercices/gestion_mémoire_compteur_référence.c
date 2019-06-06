
#include <stdio.h>
#include <stdlib.h>

typedef struct list list;
struct list {
  int refcount; // 4 bytes
  // 4 bytes 
  void *head; // 8 bytes
  list *tail; // 8 bytes
};

// list_cons
list* list_cons (void *head, list *tail) {
  list *newlst = malloc(sizeof(list));
  if (newlst != NULL) {
    newlst->refcount = 1;
    newlst->head = head;
    newlst->tail = tail;
  }
  return newlst;
}

// list_head
void* list_head(list *l) {
  return l != NULL ?  l->head : NULL;
}

// list_tail
list* list_tail(list *l) {
  list *cdr = l != NULL ? l->tail : NULL;
  if(cdr) {
    cdr->refcount++;
  }
  return cdr;
}

// Copie un pointeur (pas la list elle même)
list* list_copy (list *l) {
  if (l != NULL) {
    l->refcount++;
  }
  return l;
}

// list_free
void list_free (list *l) {
  list *next;
  while(l && l->refcount == 1) {
    next = l->tail;
    free(l);
    l = next;
  }
  if (l != NULL) {
    l->refcount --;
  }
}

void list_map (void (*f)(list*), list *l) {
  while(l) {
    f(l);
    l = l->tail;
  }
}


// Exemple utilisation.
void add2(list* l) {
  int *i = (int*) l->head;
  *i = *i + 2; 
}

void showElem(list* l) {
  int *i = (int*) l->head;
  printf(" %d", *i);
}

int main(int argc, char *argv) {
  int a = 1, b = 2;
  list *lst =list_cons(&a, list_cons(&b, NULL)); // 1 : 2 : []
  list *cp = list_copy(lst);
  printf("list before map:"); list_map(&showElem, lst);
  list_map(&add2, lst);
  printf("list after map:"); list_map(&showElem, lst);
  putchar('\n');
  list_free(lst);
  list_free(cp);
  return 0;
}

// Copy incrémente de 1 le compteur et free décrémente de 1 le compteur
// Lorsque le compteur arrive à 0, on libère la tête de liste

// Il faut absolument utiliser list_copy pour copier une liste
// et non pas une déclaration du type  list newlist = old;
// Le premier élément doit être créé avec NULL pour cdr.

// Liste de liste : Le compteur des listes dans la liste ne sont pas incrémentés
// si on copie la liste
