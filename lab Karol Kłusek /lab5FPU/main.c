#include <stdio.h>
#include <stdint.h>

extern double calc();
extern uint64_t czas();

int main()
{
	uint64_t start, end;
	double wynik = 0.0f;

		start= czas();
		wynik = calc();
		end = czas();

	printf ("Czas wynosi %" PRIu64 "\n", (end-start));
	printf("Wynik calki to: %f \n",wynik);
	return 0;
}
