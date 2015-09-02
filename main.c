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

	// nodoCrear
	nodo *miNodo = nodoCrear(palabraCopiar("palabraNodo"));
	palabraImprimir(miNodo->palabra, stdout);

	// nodoBorrar
	nodoBorrar(miNodo);

	// oracionCrear
	lista *miListaVacia = oracionCrear();
	lista *miLista = oracionCrear();

	miLista->primero = nodoCrear(palabraCopiar("primerNodo"));
	miLista->primero->siguiente = nodoCrear(palabraCopiar("segundoNodo"));

	oracionImprimir(miLista, "/dev/stdout", palabraImprimir);
	oracionImprimir(miListaVacia, "/dev/stdout", palabraImprimir);

	// longitudMedia
	printf("Longitud media 'miLista': %f \n", longitudMedia(miLista));
	printf("Longitud media 'miListaVacia': %f \n", longitudMedia(miListaVacia));

	// oracionBorrar
	oracionBorrar(miListaVacia);
	oracionBorrar(miLista);

	// insertarOrdenado
	lista *listaOrdenada = oracionCrear();
	insertarOrdenado(listaOrdenada, palabraCopiar("arbol"), palabraMenor);
	insertarOrdenado(listaOrdenada, palabraCopiar("abaco"), palabraMenor);
	insertarOrdenado(listaOrdenada, palabraCopiar("barco"), palabraMenor);
	insertarOrdenado(listaOrdenada, palabraCopiar("carro"), palabraMenor);

	printf("Lista insertada ordenado:\n");
	oracionImprimir(listaOrdenada, "/dev/stdout", palabraImprimir);
	oracionBorrar(listaOrdenada);

	// filtrarPalabra
	lista *listaAFiltrar = oracionCrear();
	insertarOrdenado(listaAFiltrar, palabraCopiar("arbol"), palabraMenor);
	insertarOrdenado(listaAFiltrar, palabraCopiar("aguja"), palabraMenor);
	insertarOrdenado(listaAFiltrar, palabraCopiar("gaviota"), palabraMenor);
	insertarOrdenado(listaAFiltrar, palabraCopiar("bisonte"), palabraMenor);
	printf("Lista a filtrar:\n");
	oracionImprimir(listaAFiltrar, "/dev/stdout", palabraImprimir);

	printf("Lista filtrada por 'canasto':\n");
	filtrarPalabra(listaAFiltrar, palabraMenor, "canasto");
	oracionImprimir(listaAFiltrar, "/dev/stdout", palabraImprimir);

	printf("Lista filtrada por 'arbol':\n");
	filtrarPalabra(listaAFiltrar, palabraMenor, "arbol");
	oracionImprimir(listaAFiltrar, "/dev/stdout", palabraImprimir);

	printf("Lista filtrada por 'aguja':\n");
	filtrarPalabra(listaAFiltrar, palabraMenor, "aguja");
	oracionImprimir(listaAFiltrar, "/dev/stdout", palabraImprimir);

	oracionBorrar(listaAFiltrar);
	return 0;
}
