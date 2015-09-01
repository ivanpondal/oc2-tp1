
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
	extern fopen
	extern fclose
	extern fprintf
	extern malloc
	extern free

; /** DEFINES **/    >> SE RECOMIENDA COMPLETAR LOS DEFINES CON LOS VALORES CORRECTOS
	%define NULL 		0
	%define TRUE 		1
	%define FALSE 		0

	%define LISTA_SIZE 	    	 8
	%define OFFSET_PRIMERO 		 0

	%define NODO_SIZE     		 16
	%define OFFSET_SIGUIENTE   	 0
	%define OFFSET_PALABRA 		 8

section .rodata


section .data
	imprimirMsg: DB '%s', 10, 0
	modoAppend: DB 'a', 0
	oracionVaciaMsg: DB '<oracionVacia>', 10, 0

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
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi
		mov rdi, NODO_SIZE

		call malloc

		mov qword [rax + OFFSET_SIGUIENTE], NULL
		mov [rax + OFFSET_PALABRA], rbx

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void nodoBorrar( nodo *n );
	nodoBorrar:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi

		mov qword rdi, [rbx + OFFSET_PALABRA]
		call free

		mov rdi, rbx
		call free

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; lista *oracionCrear( void );
	oracionCrear:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rdi, LISTA_SIZE

		call malloc

		mov qword [rax + OFFSET_PRIMERO], NULL

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void oracionBorrar( lista *l );
	oracionBorrar:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi
		cmp qword [rbx + OFFSET_PRIMERO], NULL
		je .fin
		mov rdi, [rbx + OFFSET_PRIMERO]
		.ciclo:
			mov r12, [rdi + OFFSET_SIGUIENTE]
			call nodoBorrar
			mov rdi, r12
			cmp rdi, NULL
			jne .ciclo
		.fin:
		mov rdi, rbx

		call free

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void oracionImprimir( lista *l, char *archivo, void (*funcImprimirPalabra)(char*,FILE*) );
	oracionImprimir:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi	; muevo lista a reg seguro
		mov r12, rdx	; muevo funcion imprimir a reg seguro
		mov rdi, rsi	; paso el archivo como primer parametro
		mov rsi, modoAppend

		call fopen		; en rax deja el puntero a FILE
		mov r13, rax	; muevo *FILE a reg seguro

		mov r14, [rbx + OFFSET_PRIMERO]
		cmp r14, NULL
		je .oracionVacia

		.ciclo:
			mov rdi, [r14 + OFFSET_PALABRA]
			mov rsi, r13
			call r12
			mov r14, [r14 + OFFSET_SIGUIENTE]
			cmp r14, NULL
			je .fin
			jmp .ciclo

		.oracionVacia:
		mov rdi, oracionVaciaMsg
		mov rsi, r13

		call r12
		.fin:
		mov rdi, r13
		call fclose

		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

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
