#include "lista.h"
#include <stdio.h>

int main (void){
	// palabraLongitud
	printf("la longitud de ’hola’ es = %d \n", palabraLongitud("hola"));
	printf("la longitud de ’’ es = %d \n", palabraLongitud(""));

	// palabraMenor
	printf("la palabra 'casa' < 'casas' = %d \n", palabraMenor("casa", "casas"));
	printf("la palabra 'casa' < 'casa' = %d \n", palabraMenor("casa", "casa"));
	printf("la palabra 'cal' < 'casa' = %d \n", palabraMenor("cal", "casa"));
	printf("la palabra '' < 'a' = %d \n", palabraMenor("", "a"));
	printf("la palabra '' < '' = %d \n", palabraMenor("", ""));
	return 0;
}
