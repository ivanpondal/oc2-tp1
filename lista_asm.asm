
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
			jb .esMenor	; p1[i] < p2[i]
			ja .fin		; p1[i] > p2[i]
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

		call rsi

		pop rbp
		ret

	; void palabraImprimir( char *p, FILE *file );
	palabraImprimir:
		push rbp

		mov rdx, rdi	; mando la palabra a rdx
		mov rdi, rsi	; el file lo paso a rdi
		mov rsi, imprimirMsg

		call fprintf

		pop rbp
		ret

	; char *palabraCopiar( char *p );
	palabraCopiar:
		push rbp
		mov rbp, rsp
		push rbx
		push r12

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

		pop r12
		pop rbx
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

		mov rbx, rdi
		mov rdi, NODO_SIZE

		call malloc

		mov qword [rax + OFFSET_SIGUIENTE], NULL
		mov [rax + OFFSET_PALABRA], rbx

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

		mov rbx, rdi

		mov qword rdi, [rbx + OFFSET_PALABRA]
		call free

		mov rdi, rbx
		call free

		pop rbx
		add rsp, 8
		pop rbp
		ret

	; lista *oracionCrear( void );
	oracionCrear:
		push rbp

		mov rdi, LISTA_SIZE

		call malloc

		mov qword [rax + OFFSET_PRIMERO], NULL

		pop rbp
		ret

	; void oracionBorrar( lista *l );
	oracionBorrar:
		push rbp
		mov rbp, rsp
		push rbx
		push r12

		mov rbx, rdi
		cmp qword [rbx + OFFSET_PRIMERO], NULL
		je .fin	; si la lista esta vacía no hay nodos que borrar
		mov rdi, [rbx + OFFSET_PRIMERO]	; cargo el primer nodo en rdi
		.ciclo:
			mov r12, [rdi + OFFSET_SIGUIENTE] ; me guardo el siguiente
			call nodoBorrar
			mov rdi, r12
			cmp rdi, NULL
			jne .ciclo
		.fin:
		mov rdi, rbx

		call free

		pop r12
		pop rbx
		pop rbp
		ret

	; void oracionImprimir( lista *l, char *archivo, void (*funcImprimirPalabra)(char*,FILE*) );
	oracionImprimir:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13
		push r14

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

		pop r14
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

;/** FUNCIONES AVANZADAS **/
;-----------------------------------------------------------

	; float longitudMedia( lista *l );
	longitudMedia:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13

		xor r12, r12	; contador total
		xor r13, r13	; suma total
		cvtsi2ss xmm0, r12
		mov rbx, [rdi + OFFSET_PRIMERO]
		cmp rbx, NULL
		je .fin
		.ciclo:
			mov rdi, [rbx + OFFSET_PALABRA]	; cargo la palabra
			call palabraLongitud			; calculo su longitud
			add r13, rax	; la sumo al total
			inc r12			; sumo el contador de palabras
			mov rbx, [rbx + OFFSET_SIGUIENTE]
			cmp rbx, NULL
			jne .ciclo
		cvtsi2ss xmm0, r13
		cvtsi2ss xmm1, r12
		divss xmm0, xmm1
		.fin:

		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void insertarOrdenado( lista *l, char *palabra, bool (*funcCompararPalabra)(char*,char*) );
	insertarOrdenado:
		push rbp
		mov rbp, rsp
		push rbx
		push r12
		push r13

		mov rbx, rdi	; lista
		mov r12, rsi	; palabra
		mov r13, rdx	; funcion comparar
		mov r14, NULL	; anterior

		mov r15, [rbx + OFFSET_PRIMERO]
		cmp r15, NULL
		je .insertarAtras
		.ciclo:
			mov rdi, r12
			mov rsi, [r15 + OFFSET_PALABRA]
			call palabraMenor
			cmp rax, TRUE
			je .esMenor
			mov r14, r15
			mov r15, [r15 + OFFSET_SIGUIENTE]
			cmp r15, NULL
			je .insertarAtras
			jmp .ciclo
		.esMenor:
		mov rdi, r12
		call nodoCrear
		mov [rax + OFFSET_SIGUIENTE], r15
		cmp r14, NULL
		je .insertarAdelante
		mov [r14 + OFFSET_SIGUIENTE], rax
		jmp .fin
		.insertarAdelante:
		mov [rbx + OFFSET_PRIMERO], rax
		jmp .fin

		.insertarAtras:
		mov rdi, rbx
		mov rsi, r12
		call insertarAtras
		.fin:
		pop r13
		pop r12
		pop rbx
		pop rbp
		ret

	; void filtrarAltaLista( lista *l, bool (*funcCompararPalabra)(char*,char*), char *palabraCmp );
	filtrarPalabra:
		push rbp
		mov rbp, rsp
		sub rsp, 8
		push rbx
		push r12
		push r13
		push r14
		push r15

		mov rbx, rdi	; lista
		mov r12, rsi	; funcion comparar
		mov r13, rdx	; palabra comparar

		xor r14, r14	; nodo anterior
		mov r15, [rbx + OFFSET_PRIMERO]
		cmp r15, NULL
		je .fin
		.ciclo:
			mov rdi, [r15 + OFFSET_PALABRA]
			mov rsi, r13
			call r12
			mov rdi, r15	; nodo actual
			mov r15, [r15 + OFFSET_SIGUIENTE]	; actualizo actual
			cmp rax, TRUE
			je .actualizarAnterior
			.borrarNodo:
			call nodoBorrar	; borro el nodo actual
			cmp r14, NULL	; si el anterior es NULL, era el primero
			je .borrarPrimero
			mov [r14 + OFFSET_SIGUIENTE], r15
			jmp .siguienteNodo
			.borrarPrimero:
			mov [rbx + OFFSET_PRIMERO], r15
			jmp .siguienteNodo
			.actualizarAnterior:
			mov r14, rdi	; actualizo anterior
			.siguienteNodo:
			cmp r15, NULL
			je .fin
			jmp .ciclo
		.fin:
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx
		add rsp, 8
		pop rbp
		ret

	; void descifrarMensajeDiabolico( lista *l, char *archivo, void (*funcImpPbr)(char*,FILE* ) );
	descifrarMensajeDiabolico:
		; COMPLETAR AQUI EL CODIGO
