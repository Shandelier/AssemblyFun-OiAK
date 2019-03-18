#include <stdio.h>
#include <stdint.h>

float fun(float x) 
{
	return 1/x;
}

extern float calka(float (*ptr)(float), long n);
extern uint64_t czas();

int main()
{
	uint64_t start, end;
	double wynik_f;
	float wynik;
	float procesor = 1200.200; 
	int i = 0;
	for(i =0; i< 5;i++)
	{
		start= czas(); 
		wynik = calka(fun, 1000000);
		end = czas();
		wynik_f += (end - start);
	}
	
	printf ("Czas wynosi %lf \n", (wynik_f/5)/procesor);
	printf("Wynik calki to: %f \n",wynik/5);
	return 0;
}
