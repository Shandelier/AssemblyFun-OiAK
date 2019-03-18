#include <inttypes.h>
#include <math.h>
#include <stdio.h>
#include <inttypes.h>
#include <sys/time.h>


extern float calc(float arr[], int size);
extern uint64_t czas();

float suma_classic(float arr[], int size){
  float sum;
  for (int i =0; i < size; i++){
    sum = sum + arr[i];
  }
  return sum;
}

void init_tab(float arr[], int size){
  for(int i = 0; i <size; i++){
    arr[i] = i;
  }
  return;
}

void init_tab_int(int arr[], int size){
  for(int i = 0; i <size; i++){
    arr[i] = i;
  }
  return;
}


int main(void)
{
    float wynikA;
    float wynikB;

    uint64_t start, end;
    int rozmiar = 1024;
    float tab[rozmiar];

    init_tab(tab, rozmiar);
    start = czas();
		wynikB = suma_classic(tab, rozmiar);
		end = czas();

    printf ("Czas wynosi %" PRIu64 "\n", (end-start));
	  printf("Wynik średni to: %f \n",wynikB);

    init_tab(tab, rozmiar);
    start = czas();
		wynikA = calc(tab, rozmiar);
		end = czas();

    printf ("Czas wynosi %" PRIu64 "\n", (end-start));
	  printf("Wynik średni to: %f \n",wynikA);

    return 0;
}
