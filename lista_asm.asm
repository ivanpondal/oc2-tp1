
; PALABRA
	global palabraLongitud
	global palabraMenor
	global palabraFormatear
	global palabraImprimir
	global palabraCopiar
	
; LISTA y NODO
	global nodoCrear
	global nodoBorrar
	global oracionCrear
	global oracionBorrar
	global oracionImprimir

; AVANZADAS
	global longitudMedia
	global insertarOrdenado
	global filtrarPalabra
	global descifrarMensajeDiabolico

; YA IMPLEMENTADAS EN C
	extern palabraIgual
	extern insertarAtras

; /** DEFINES **/    >> SE RECOMIENDA COMPLETAR LOS DEFINES CON LOS VALORES CORRECTOS
	%define NULL 		0
	%define TRUE 		0
	%define FALSE 		0

	%define LISTA_SIZE 	    	 0
	%define OFFSET_PRIMERO 		 0

	%define NODO_SIZE     		 0
	%define OFFSET_SIGUIENTE   	 0
	%define OFFSET_PALABRA 		 0


section .rodata


section .data


section .text


;/** FUNCIONES DE PALABRAS **/
;-----------------------------------------------------------

	; unsigned char palabraLongitud( char *p );
	palabraLongitud:
		; COMPLETAR AQUI EL CODIGO

	; bool palabraMenor( char *p1, char *p2 );
	palabraMenor:
		; COMPLETAR AQUI EL CODIGO

	; void palabraFormatear( char *p, void (*funcModificarString)(char*) );
	palabraFormatear:
		; COMPLETAR AQUI EL CODIGO

	; void palabraImprimir( char *p, FILE *file );
	palabraImprimir:
		; COMPLETAR AQUI EL CODIGO

	; char *palabraCopiar( char *p );
	palabraCopiar:
		; COMPLETAR AQUI EL CODIGO


;/** FUNCIONES DE LISTA Y NODO **/
;-----------------------------------------------------------

	; nodo *nodoCrear( char *palabra );
	nodoCrear:
		; COMPLETAR AQUI EL CODIGO

	; void nodoBorrar( nodo *n );
	nodoBorrar:
		; COMPLETAR AQUI EL CODIGO

	; lista *oracionCrear( void );
	oracionCrear:
		; COMPLETAR AQUI EL CODIGO

	; void oracionBorrar( lista *l );
	oracionBorrar:
		; COMPLETAR AQUI EL CODIGO

	; void oracionImprimir( lista *l, char *archivo, void (*funcImprimirPalabra)(char*,FILE*) );
	oracionImprimir:
		; COMPLETAR AQUI EL CODIGO


;/** FUNCIONES AVANZADAS **/
;-----------------------------------------------------------

	; float longitudMedia( lista *l );
	longitudMedia:
		; COMPLETAR AQUI EL CODIGO

	; void insertarOrdenado( lista *l, char *palabra, bool (*funcCompararPalabra)(char*,char*) );
	insertarOrdenado:
		; COMPLETAR AQUI EL CODIGO

	; void filtrarAltaLista( lista *l, bool (*funcCompararPalabra)(char*,char*), char *palabraCmp );
	filtrarPalabra:
		; COMPLETAR AQUI EL CODIGO

	; void descifrarMensajeDiabolico( lista *l, char *archivo, void (*funcImpPbr)(char*,FILE* ) );
	descifrarMensajeDiabolico:
		; COMPLETAR AQUI EL CODIGO
