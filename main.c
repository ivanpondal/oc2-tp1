#include "lista.h"
#include <stdio.h>

void bypass(char *p){
	p = p;
}

void upper(char *p){
	int i = 0;
	while(p[i] > 0){
		p[i] -= p[i] > 96 ? 32 : 0;
		i++;
	}
}

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

	// palabraFormatear
	char p[] = "hola";
	palabraFormatear(p, bypass);
	printf("la palabra 'hola' formateada con bypass es '%s' \n", p);
	palabraFormatear(p, upper);
	printf("la palabra 'hola' formateada con upper es '%s' \n", p);

	// palabraImprimir
	palabraImprimir("Este es un mensaje impreso", stdout);

	// palabraCopiar
	char *unaPalabra = palabraCopiar("palabraCopiada");
	char *otraPalabra = palabraCopiar(unaPalabra);
	char *palabraVacia = palabraCopiar("");
	unaPalabra[1] = '@';
	palabraImprimir(unaPalabra, stdout);
	palabraImprimir(otraPalabra, stdout);
	palabraImprimir(palabraVacia, stdout);
	free(unaPalabra);
	free(otraPalabra);
	free(palabraVacia);

	return 0;
}
