
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
	extern fprintf
	extern malloc

; /** DEFINES **/    >> SE RECOMIENDA COMPLETAR LOS DEFINES CON LOS VALORES CORRECTOS
	%define NULL 		0
	%define TRUE 		1
	%define FALSE 		0

	%define LISTA_SIZE 	    	 0
	%define OFFSET_PRIMERO 		 0

	%define NODO_SIZE     		 0
	%define OFFSET_SIGUIENTE   	 0
	%define OFFSET_PALABRA 		 0

section .rodata


section .data
	imprimirMsg: DB '%s', 10, 0

section .text


;/** FUNCIONES DE PALABRAS **/
;-----------------------------------------------------------

	; unsigned char palabraLongitud( char *p );
	palabraLongitud:
		push rbp
		xor rax, rax
		cmp byte [rdi], NULL
		je .fin
		.ciclo:
			inc al
			lea rdi, [rdi + 1]
			cmp byte [rdi], NULL
			jne .ciclo
		.fin:
			pop rbp
			ret

	; bool palabraMenor( char *p1, char *p2 );
	palabraMenor:
		push rbp
		xor rax, rax	; resultado bool
		xor dl, dl  	; var temp

		.ciclo:
			mov dl, [rsi]
			cmp [rdi], dl
			jl .esMenor	; p1[i] < p2[i]
			cmp dl, NULL
			je .fin    	; p1[i] >= p2[i] && p2[i] == NULL
			lea rdi, [rdi + 1]
			lea rsi, [rsi + 1]
			jmp .ciclo
		.esMenor:
			inc rax
		.fin:
			pop rbp
			ret

	; void palabraFormatear( char *p, void (*funcModificarString)(char*) );
	palabraFormatear:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		call rsi

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void palabraImprimir( char *p, FILE *file );
	palabraImprimir:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rdx, rdi	; mando la palabra a rdx
		mov rdi, rsi	; el file lo paso a rdi
		mov rsi, imprimirMsg

		call fprintf

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; char *palabraCopiar( char *p );
	palabraCopiar:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi	; guardo la palabra original
		xor rax, rax
		call palabraLongitud
		inc rax			; incremento en uno para poder guardar el caracter de fin
		mov r12, rax	; guardo resultado para no perderlo
		mov rdi, rax

		call malloc

		mov rcx, r12
		.ciclo:
			mov dil, [rbx + rcx - 1]
			mov [rax + rcx - 1], dil
			loop .ciclo

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

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
