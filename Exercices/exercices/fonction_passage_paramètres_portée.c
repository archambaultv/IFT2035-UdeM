#include <stdio.h>

int nom = 0;
int valeurResultat = 1;
int reference = 2;
int portee = 0;

// Test de portée
int bar(){
  return portee;
};

int foo(int testRef, int testNom){
  // Si y est passé par nom, son effet de bord sera dupliqué
  int b1 = testNom + testNom;

  // On modifie le paramètre
  // Cela affectera l'appelant avec passage par référence
  // et valeur-résultat
  // Avec passage par nom, on peut considérer que cela va aussi le
  // modifier si l'utilisation du paramètre a gauche du = est permise
  testRef = testRef + 1;

  // Avec un passage par référence, référence est immédiatement modifié
  // Avec un passage par valeurRésultat, référence est modifié seulement
  // a la fin de la fonction et non lors de l'exécution de cette ligne
  valeurResultat = reference;

  // On cache la variable portee
  int portee = 1;
    
  return bar();
}

void main(){
  int p = foo(reference, nom++); // Appel à foo pour effectuer le test
  printf("(%d, %d, %d, %d)", nom, valeurResultat, reference, p);
  return;
}

// Portée statique et :
//  Par valeur : (1, 2, 2, 0)
//  Par référence : (1, 3, 3, 0)
//  Par nom : (2, 3, 3, 0)
//  Par valeur résultat : (1, 2, 3, 0)

// Portée dynamique et :
//  Par valeur : (1, 2, 2, 1)
//  Par référence : (1, 3, 3, 1)
//  Par nom : (2, 3, 3, 1)
//  Par valeur résultat : (1, 2, 3, 1)
