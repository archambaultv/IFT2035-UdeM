#include <stdio.h>

void bad (void){
  int c;
  int last= EOF;
  while ((c = getchar ()) != EOF) {
    if (c == last) {
      if (c == '\n') {
        break;
      } else {
        continue;
      }
    }
    putchar (last = c);
  }
}

// Programmation structurée stricte
void strict (void){
  int c;
  int last= EOF;
  int exit = 0; // Ajout d'une condition de sortie
  while (exit != 1 && (c = getchar ()) != EOF) {
    if (c == last) {
      if (c == '\n') {
        exit = 1;
      }
    } else {
      putchar (last = c);
    }
  }
}

// Programmation fonctionnelle
void foo(char c, char last){
  if (c != EOF){
    if (c == last){
      if (c != '\n'){
        foo(getchar(), c);
      }
    } else {
      putchar(c);
      foo(getchar(), c);
    }
  }
}

void func (void){
  int last= EOF;
  foo(getchar(),last);
}

int main(void){
  // bad();
  // strict();
  func();

  return 0;
}
