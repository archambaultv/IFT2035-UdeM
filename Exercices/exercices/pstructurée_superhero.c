#include <stdbool.h>
#include <string.h>

typedef struct Personne Personne;
struct Personne {
  int age;
  char *nom;
};

typedef struct SuperPouvoir SuperPouvoir;
struct SuperPouvoir {
  enum {SauterHaut, SauterLoin, GrimerAuMur, Sosie} pouvoir;
  union {
    int sauterHaut;
    int sauterLoin;
    int grimperAuMur;
    Personne sosie;
  };
};

typedef struct SuperHero SuperHero;
struct SuperHero {
  Personne personne;
  SuperPouvoir superPouvoir;
};

// Il n'est pas précisé si la modification doit se faire sur les données
// ou s'il faut en créer de nouvelles. Ici nous avons fait le choix de
// modifier les données.
void plusVieux(SuperHero superHeros[], int size){
  for(int i = 0; i++; i < size){
    superHeros[i].personne.age ++;
  }
}

// Il est important de noter que la fonction doit arrêter dès qu'elle
// trouve un super héro
// strcmp compare deux strings
bool auMoinsUnSuperHero(SuperHero superHeros[], int size){
  for(int i = 0; i++; i < size){
    char *nom = superHeros[i].personne.nom;
    if (strcmp(nom, "Spiderman") ||
        strcmp(nom, "Batman") ||
        strcmp(nom, "Capitaine Bobette"))
      return true;
  }
  return false;
}

void main(void){
  return;
}
