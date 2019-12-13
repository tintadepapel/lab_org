jmp main

;Codigo principal
main:
	call ApagaTela
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1536  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #512  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela3Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	loadn R1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #256   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
	
	call AguardaEnter
	
	call ApagaTela
	loadn R1, #tela5Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #256   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
	
	call AguardaOpcao1
	
	

	halt

;********************************************************
;                       IMPRIME TELA2
;********************************************************	

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING2
;********************************************************
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6			; Incrementa o ponteiro da String da Tela 0
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

;------------------------	
;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
	
;------------------------	
	
;********************************************************
;                       AGUARDA ENTER
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do ENTER
AguardaEnter:
    inchar r6
    loadn r7, #13
    cmp r7, r6
    jne AguardaEnter
    rts
    
;********************************************************
;                       AGUARDA OPCAO 1
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao1:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next1
    cmp r5, r6
    jeq next2
    jne AguardaOpcao1 ; Se nao apertar 1 ou 2 continua aqui
    rts
    
;********************************************************
;                       AGUARDA OPCAO 2
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao2:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next3
    cmp r5, r6
    jeq next4
    jne AguardaOpcao2 ; Se nao apertar 1 ou 2 continua aqui
    rts
    
;********************************************************
;                       AGUARDA OPCAO 3
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao3:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next5
    cmp r5, r6
    jeq next6
    jne AguardaOpcao3 ; Se nao apertar 1 ou 2 continua aqui
    rts
    
;********************************************************
;                       AGUARDA OPCAO 4
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao4:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next7
    cmp r5, r6
    jeq next8
    jne AguardaOpcao4 ; Se nao apertar 1 ou 2 continua aqui
    rts
    
;********************************************************
;                       AGUARDA OPCAO 5
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao5:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    ;jeq next9
    jeq next7
    cmp r5, r6
    ;jeq next10
    jeq next8
    jne AguardaOpcao5 ; Se nao apertar 1 ou 2 continua aqui
    rts

;********************************************************
;                       AGUARDA OPCAO 6
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao6:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next11
    cmp r5, r6
    jeq next12
    jne AguardaOpcao6 ; Se nao apertar 1 ou 2 continua aqui
    rts
    
;********************************************************
;                       AGUARDA OPCAO 7
;********************************************************
;r6: Leitura do Caractere
;r7: valor ASCII do numero 1
;r5: valor ASCII do numero 2
AguardaOpcao7:
    inchar r6
    loadn r7, #49 ; Opcao 1
    loadn r5, #50 ; Opcao 2
    cmp r7, r6
    jeq next13
    cmp r5, r6
    jeq next14
    jne AguardaOpcao7 ; Se nao apertar 1 ou 2 continua aqui
    rts

;********************************************************
;                       NEXT 1
;******************************************************** 
next1:
	call ApagaTela
	loadn R1, #tela6Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao2 
	rts

;********************************************************
;                       NEXT 2
;******************************************************** 
next2:
	call ApagaTela
	loadn R1, #tela7Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao3
	rts
	
;********************************************************
;                       NEXT 3
;******************************************************** 
next3:
	call ApagaTela
	loadn R1, #tela8Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao4 
	rts

;********************************************************
;                       NEXT 4
;******************************************************** 
next4:
	call ApagaTela
	loadn R1, #tela9Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao5
	rts

;********************************************************
;                       NEXT 5
;******************************************************** 
next5:
	call ApagaTela
	loadn R1, #tela10Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao6 
	rts

;********************************************************
;                       NEXT 6
;******************************************************** 
next6:
	call ApagaTela
	loadn R1, #tela11Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao7
	rts

;********************************************************
;                       NEXT 7
;******************************************************** 
next7:
	call ApagaTela
	loadn R1, #tela12Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao8
	rts

;********************************************************
;                       NEXT 8
;******************************************************** 
next8:
	call ApagaTela
	loadn R1, #tela13Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao9
	rts

;********************************************************
;                       NEXT 9
;******************************************************** 
next9:
	call ApagaTela
	loadn R1, #tela14Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao10
	rts

;********************************************************
;                       NEXT 10
;******************************************************** 
next10:
	call ApagaTela
	loadn R1, #tela15Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao11
	rts

;********************************************************
;                       NEXT 11
;******************************************************** 
next11:
	call ApagaTela
	loadn R1, #tela16Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao12
	rts

;********************************************************
;                       NEXT 12
;******************************************************** 
next12:
	call ApagaTela
	loadn R1, #tela17Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao13
	rts

;********************************************************
;                       NEXT 13
;******************************************************** 
next13:
	call ApagaTela
	loadn R1, #tela18Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao14
	rts

;********************************************************
;                       NEXT 14
;******************************************************** 
next14:
	call ApagaTela
	loadn R1, #tela19Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao15
	rts

;------------------------
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "	

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "                                        "
tela1Linha1  : string "                                        "
tela1Linha2  : string "                                        "
tela1Linha3  : string "                                        "
tela1Linha4  : string "                                        "
tela1Linha5  : string "                                        ";"          ____   ____  ______           "
tela1Linha6  : string "           ____   ____  ______          ";"         |  o ) |  o \|  ___/           "
tela1Linha7  : string "          |  o ) |  o ||  ___/          ";"         |    \ |  __/| |___--          "
tela1Linha8  : string "          |   /  |  __/| |___--         ";"         |__|\_\|_|    \___  |          "
tela1Linha9  : string "          |_|_|  |_|   |____  |         ";"         UNIVERSITÁRIO      \|          "
tela1Linha10 : string "          UNIVERSITARIO     |/          "
tela1Linha11 : string "                                        "
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "                                        "
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "                                        "
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "                                        "
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "                                        "
tela1Linha26 : string "                                        "
tela1Linha27 : string "                                        "
tela1Linha28 : string "                                        "
tela1Linha29 : string "                                        "



; Declara e preenche tela linha por linha (40 caracteres):
tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                                        "
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                                        "
tela2Linha18 : string "                                        "
tela2Linha19 : string "                                        "
tela2Linha20 : string "                                        "
tela2Linha21 : string "                                        "
tela2Linha22 : string "                                        "
tela2Linha23 : string "             [PRESS ENTER]              "
tela2Linha24 : string "                                        "
tela2Linha25 : string "                                        "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "


; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "                                        "
tela3Linha1  : string "                                        "
tela3Linha2  : string "                                        "
tela3Linha3  : string "                                        "
tela3Linha4  : string "                                        "
tela3Linha5  : string "                                        "
tela3Linha6  : string "                                        "
tela3Linha7  : string "                                        "
tela3Linha8  : string "                                        "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "         _________                      "
tela3Linha13 : string "        |         |                     "
tela3Linha14 : string "        | CALCULO |                     "
tela3Linha15 : string "        |    I    |                     "
tela3Linha16 : string "        |         |                     "
tela3Linha17 : string "        |_________|                     "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                                        "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "                                        "
tela3Linha27 : string "                                        "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "



tela4Linha0  : string "                                        "
tela4Linha1  : string "                                        "
tela4Linha2  : string "                                        "
tela4Linha3  : string "                                        "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "                                        "
tela4Linha8  : string "                                        "
tela4Linha9  : string "                                        "
tela4Linha10 : string "                                        "
tela4Linha11 : string "                                        "
tela4Linha12 : string "                           _            "
tela4Linha13 : string "                          |_|           "
tela4Linha14 : string "                         _| |_          "
tela4Linha15 : string "                        (_____)         "
tela4Linha16 : string "                        (     )         "
tela4Linha17 : string "                        (  51 )         "
tela4Linha18 : string "                        (_____)         "
tela4Linha19 : string "                        (_____)         "
tela4Linha20 : string "                                        "
tela4Linha21 : string "                                        "
tela4Linha22 : string "                                        "
tela4Linha23 : string "                                        "
tela4Linha24 : string "                                        "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                                        "



tela5Linha0  : string "                                        "
tela5Linha1  : string "                                        "
tela5Linha2  : string "                                        "
tela5Linha3  : string "                                        "
tela5Linha4  : string "                                        "
tela5Linha5  : string "     Voce conseguiu ser aprovado na     "
tela5Linha6  : string "     USP! Parabens!                     "
tela5Linha7  : string "                                        "
tela5Linha8  : string "     Hoje e seu primeiro dia de aula    "
tela5Linha9  : string "     e, infelizmente, voce chegou       "
tela5Linha10 : string "     atrasado em sua primeira aula.     "
tela5Linha11 : string "                                        "
tela5Linha12 : string "     Da porta voce consegue notar       "
tela5Linha13 : string "     que ha um grupo de nerds que       "
tela5Linha14 : string "     estao sentados na frente da        "
tela5Linha15 : string "     sala e uma outra galera que        "
tela5Linha16 : string "     esta sentada no fundo da sala.     "
tela5Linha17 : string "                                        "
tela5Linha18 : string "     Onde voce vai sentar?              "
tela5Linha19 : string "                                        "
tela5Linha20 : string "         1. Na frente, sou nerdao       "
tela5Linha21 : string "         2. Vou pro fundo pra dormir    "
tela5Linha22 : string "                                        "
tela5Linha23 : string "                                        "
tela5Linha24 : string "                                        "
tela5Linha25 : string "                                        "
tela5Linha26 : string "                                        "
tela5Linha27 : string "                 PRESS                  "
tela5Linha28 : string "               [1] or [2]               "
tela5Linha29 : string "                                        "



tela6Linha0  : string "                                    A1  "
tela6Linha1  : string "                                        "
tela6Linha2  : string "                                        "
tela6Linha3  : string "     Muito bem, nerdao, voce foi        "
tela6Linha4  : string "     sentar na primeira cadeira da      "
tela6Linha5  : string "     fileira dessa aula de Calculo I.   "
tela6Linha6  : string "                                        "
tela6Linha7  : string "     Depois de 5 minutos voce percebe   "
tela6Linha8  : string "     que nao esta entendendo nada       "
tela6Linha9  : string "     da aula. Do seu lado direito       "
tela6Linha10 : string "     tem um garoto de oculos com cara   "
tela6Linha11 : string "     de nerd tipico. A sua esquerda     "
tela6Linha12 : string "     tem um outro que esta mexendo no   "
tela6Linha13 : string "     celular.                           "
tela6Linha14 : string "                                        "
tela6Linha15 : string "     Voce, como bom nerd, quer          "
tela6Linha16 : string "     entender a materia que esta        "
tela6Linha17 : string "     sendo ensinada.                    "
tela6Linha18 : string "                                        "
tela6Linha19 : string "                                        "
tela6Linha20 : string "      Pra qual dos dois voce pergunta?  "
tela6Linha21 : string "                                        "
tela6Linha22 : string "          1. Cara do celular            "
tela6Linha23 : string "          2. Nerd de oculos             "
tela6Linha24 : string "                                        "
tela6Linha25 : string "                                        "
tela6Linha26 : string "                                        "
tela6Linha27 : string "                 PRESS                  "
tela6Linha28 : string "               [1] or [2]               "
tela6Linha29 : string "                                        "



tela7Linha0  : string "                                    A2  "
tela7Linha1  : string "                                        "
tela7Linha2  : string "                                        "
tela7Linha3  : string "     Passou na USP e nao quer ser       "
tela7Linha4  : string "     nerdao? Ok. Voce vai pro fundo     "
tela7Linha5  : string "     da sala.                           "
tela7Linha6  : string "                                        "
tela7Linha7  : string "     Conforme a aula passa voce fica    "
tela7Linha8  : string "     totalmente perdido e o sono bate   "
tela7Linha9  : string "     forte. Quando voce percebe ja      "
tela7Linha10 : string "     estava pescando. A aula termina    "
tela7Linha11 : string "     e voce nao faz ideia do que se     "
tela7Linha12 : string "     passou. No intervalo voce conversa "
tela7Linha13 : string "     com o pessoal do fundao e descobre "
tela7Linha14 : string "     que hoje a noite tera uma festa.   "
tela7Linha15 : string "                                        "
tela7Linha16 : string "     Voce decide ir mas nao sabe se     "
tela7Linha17 : string "     chega no horario ou se chega       "
tela7Linha18 : string "     mais tarde.                        "
tela7Linha19 : string "                                        "
tela7Linha20 : string "     O que voce vai fazer?              "
tela7Linha21 : string "                                        "
tela7Linha22 : string "          1. Chegar na hora marcada     "
tela7Linha23 : string "          2. Chegar mais tarde          "
tela7Linha24 : string "                                        "
tela7Linha25 : string "                                        "
tela7Linha26 : string "                                        "
tela7Linha27 : string "                 PRESS                  "
tela7Linha28 : string "               [1] or [2]               "
tela7Linha29 : string "                                        "



tela8Linha0  : string "                                    B1  "
tela8Linha1  : string "                                        "
tela8Linha2  : string "                                        "
tela8Linha3  : string "     O cara nao fazia ideia do          "
tela8Linha4  : string "     que estava acontecendo, logico,    "
tela8Linha5  : string "     voce foi muito inocente.           "
tela8Linha6  : string "                                        "
tela8Linha7  : string "     O professor percebeu que voce      "
tela8Linha8  : string "     estava conversando - quem mandou   "
tela8Linha9  : string "     sentar na frente? - e resolveu     "
tela8Linha10 : string "     te usar como exemplo fazendo uma   "
tela8Linha11 : string "     pergunta. Voce nao soube o que     "
tela8Linha12 : string "     responder e o professor marcou     "
tela8Linha13 : string "     sua cara.                          "
tela8Linha14 : string "                                        "
tela8Linha15 : string "     O cara do celular se chama Jose    "
tela8Linha16 : string "     e voces acabam conversando depois  "
tela8Linha17 : string "     da aula. Ele nao e calouro e       "
tela8Linha18 : string "     essa e a sexta vez que faz         "
tela8Linha19 : string "     Calculo I. Ele comenta de uma      "
tela8Linha20 : string "     festa para os bixos hoje a noite.  "
tela8Linha21 : string "                                        "
tela8Linha22 : string "     Voce:                              "
tela8Linha23 : string "          1. Diz que vai a festa        "
tela8Linha24 : string "          2. Recusa pois precisa        "
tela8Linha25 : string "             estudar                    "
tela8Linha26 : string "                                        "
tela8Linha27 : string "                 PRESS                  "
tela8Linha28 : string "               [1] or [2]               "
tela8Linha29 : string "                                        "



tela9Linha0  : string "                                    B2  "
tela9Linha1  : string "                                        "
tela9Linha2  : string "                                        "
tela9Linha3  : string "     O rapaz de oculos parecia que      "
tela9Linha4  : string "     estava entendendo melhor o que     "
tela9Linha5  : string "     o professor falava.                "
tela9Linha6  : string "                                        "
tela9Linha7  : string "     Pedro, nome do nerd, conseguiu     "
tela9Linha8  : string "     te explicar rapidamente a materia  "
tela9Linha9  : string "     mas ainda assim era complicada.    "
tela9Linha10 : string "                                        "
tela9Linha11 : string "     Ele pergunta se voce gostaria de   "
tela9Linha12 : string "     ir a biblioteca mais tarde rever   "
tela9Linha13 : string "     o que foi dito em aula e se        "
tela9Linha14 : string "     adiantar pra proxima aula.         "
tela9Linha15 : string "                                        "
tela9Linha16 : string "     Nesse momento o cara do celular    "
tela9Linha17 : string "     vira pra voces e fala da recepcao  "
tela9Linha18 : string "     dos calouros hoje a noite.         "
tela9Linha19 : string "                                        "
tela9Linha20 : string "     Voce:                              "
tela9Linha21 : string "          1. Diz que vai a festa        "
tela9Linha22 : string "          2. Recusa pois precisa        "
tela9Linha23 : string "             estudar                    "
tela9Linha24 : string "                                        "
tela9Linha25 : string "                                        "
tela9Linha26 : string "                                        "
tela9Linha27 : string "                 PRESS                  "
tela9Linha28 : string "               [1] or [2]               "
tela9Linha29 : string "                                        "



tela10Linha0  : string "                                    C1  "
tela10Linha1  : string "                                        "
tela10Linha2  : string "                                        "
tela10Linha3  : string "    Voce fica bem ansioso sobre a       "
tela10Linha4  : string "    festa e decide chegar na hora       "
tela10Linha5  : string "    em que estava marcada.              "
tela10Linha6  : string "                                        "
tela10Linha7  : string "    So os organzadores estavam          "
tela10Linha8  : string "    na rep nesse momento e, e claro,    "
tela10Linha9  : string "    ficaram te alugando por ser o       "
tela10Linha10 : string "    unico bixo do recinto.              "
tela10Linha11 : string "                                        "
tela10Linha12 : string "    Ate o fim da festa nao te largam    "
tela10Linha13 : string "    e voce logo fica marcado pelos      "
tela10Linha14 : string "    veteranos. Pelo menos voce ja esta  "
tela10Linha15 : string "    bem bebado.                         "
tela10Linha16 : string "                                        "
tela10Linha17 : string "    Um grupo de veteranos chega         "
tela10Linha18 : string "    com uma bebida duvidosa num balde   "
tela10Linha19 : string "    e querem que voce seja o primeiro   "
tela10Linha20 : string "    a beber, por motivos obvios.        "
tela10Linha21 : string "                                        "
tela10Linha22 : string "    Voce:                               "
tela10Linha23 : string "         1. Recusa beber essa coisa     "
tela10Linha24 : string "            estranha                    "
tela10Linha25 : string "         2. Ja ta no inferno e abraca   "
tela10Linha26 : string "            o capeta                    "
tela10Linha27 : string "                 PRESS                  "
tela10Linha28 : string "               [1] or [2]               "
tela10Linha29 : string "                                        "



tela11Linha0  : string "                                    C2  "
tela11Linha1  : string "                                        "
tela11Linha2  : string "                                        "
tela11Linha3  : string "    E claro que voce nao vai ser        "
tela11Linha4  : string "    o primeiro a chegar, seria um       "
tela11Linha5  : string "    grande erro.                        "
tela11Linha6  : string "                                        "
tela11Linha7  : string "    Depois de um tempo da hora marcada  "
tela11Linha8  : string "    para a festa voce aparece. O som    "
tela11Linha9  : string "    ja esta rolando e aparentemente     "
tela11Linha10 : string "    o pessoal ja esta bem bebado.       "
tela11Linha11 : string "                                        "
tela11Linha12 : string "    Quando voce entra na rep ja da      "
tela11Linha13 : string "    de cara com um colega virando um    "
tela11Linha14 : string "    balde de alguma mistura alcoolica   "
tela11Linha15 : string "    com um cheiro estranho. O cara      "
tela11Linha16 : string "    Nao deu dois goles e ja caiu duro   "
tela11Linha17 : string "    no chao. Ainda bem que nao era      "
tela11Linha18 : string "    voce.                               "
tela11Linha19 : string "                                        "
tela11Linha20 : string "    Voce conhece uma galera na festa.   "
tela11Linha21 : string "    Um pessoal ja te convida para o     "
tela11Linha22 : string "    proximo role e voce:                "
tela11Linha23 : string "                                        "
tela11Linha24 : string "         1. Aceita sem nem pensar       "
tela11Linha25 : string "         2. Diz que vai ver e avisa     "
tela11Linha26 : string "                                        "
tela11Linha27 : string "                 PRESS                  "
tela11Linha28 : string "               [1] or [2]               "
tela11Linha29 : string "                                        "



tela12Linha0  : string "                                    D1  "
tela12Linha1  : string "                                        "
tela12Linha2  : string "                                        "
tela12Linha3  : string "    Voce diz que vai a festa. E melhor  "
tela12Linha4  : string "    relaxar um pouco depois de um       "
tela12Linha5  : string "    comeco de semestre assim, ne?       "
tela12Linha6  : string "                                        "
tela12Linha7  : string "    Voce chega na festa um pouco        "
tela12Linha8  : string "    depois de ter comecado, as pessoas  "
tela12Linha9  : string "    ainda nao estavam muito bebadas,    "
tela12Linha10 : string "    com excecao de uns poucos que ja    "
tela12Linha11 : string "    tinham queimado a largada.          "
tela12Linha12 : string "                                        "
tela12Linha13 : string "    Deu pra conhecer bastante gente     "
tela12Linha14 : string "    da sua turma, muitos veteranos      "
tela12Linha15 : string "    e fazer um bom networking.          "
tela12Linha16 : string "                                        "
tela12Linha17 : string "    No fim das contas esse evento foi   "
tela12Linha18 : string "    decisivo para seu semestre pois     "
tela12Linha19 : string "    aqui conseguiu formar um grupo      "
tela12Linha20 : string "    que parmaneceu unido e passando     "
tela12Linha21 : string "    cola uns aos outros nas provas      "
tela12Linha22 : string "    e trabalhos.                        "
tela12Linha23 : string "                                        "
tela12Linha24 : string "    Seu semestre foi um sucesso!        "
tela12Linha25 : string "                                        "
tela12Linha26 : string "                                        "
tela12Linha27 : string "                  FIM                   "
tela12Linha28 : string "                                        "
tela12Linha29 : string "                                        "



tela13Linha0  : string "                                    D2  "
tela13Linha1  : string "                                        "
tela13Linha2  : string "                                        "
tela13Linha3  : string "    Melhor nao arriscar, ne? Voce       "
tela13Linha4  : string "    diz que vai precisar estudar.       "
tela13Linha5  : string "    O cara te olha estranho e tenta     "
tela13Linha6  : string "    te convencer a ir a festa mas voce  "
tela13Linha7  : string "    esta resoluto.                      "
tela13Linha8  : string "                                        "
tela13Linha9  : string "    Mais tarde nesse dia voce estava    "
tela13Linha10 : string "    na biblioteca estudando. Essa foi   "
tela13Linha11 : string "    basicamente a sua atitude durante   "
tela13Linha12 : string "    o semestre.                         "
tela13Linha13 : string "                                        "
tela13Linha14 : string "    Isso te garantiu notas razoaveis,   "
tela13Linha15 : string "    porque voce nao e um genio, mas     "
tela13Linha16 : string "    voce se sentiu um pouco isolado     "
tela13Linha17 : string "    do resto da turma.                  "
tela13Linha18 : string "                                        "
tela13Linha19 : string "    Talvez no proximo semestre voce     "
tela13Linha20 : string "    va em alguma festa ou faca algo     "
tela13Linha21 : string "    diferente de apenas ir a biblioteca "
tela13Linha22 : string "    todo dia.                           "
tela13Linha23 : string "                                        "
tela13Linha24 : string "    Seu semestre foi ok.                "
tela13Linha25 : string "                                        "
tela13Linha26 : string "                                        "
tela13Linha27 : string "                  FIM                   "
tela13Linha28 : string "                                        "
tela13Linha29 : string "                                        "



tela14Linha0  : string "                                    E1  "
tela14Linha1  : string "                                        "
tela14Linha2  : string "                                        "
tela14Linha3  : string "                                        "
tela14Linha4  : string "                                        "
tela14Linha5  : string "                                        "
tela14Linha6  : string "                                        "
tela14Linha7  : string "                                        "
tela14Linha8  : string "                                        "
tela14Linha9  : string "                                        "
tela14Linha10 : string "                                        "
tela14Linha11 : string "                                        "
tela14Linha12 : string "                                        "
tela14Linha13 : string "                                        "
tela14Linha14 : string "                                        "
tela14Linha15 : string "                                        "
tela14Linha16 : string "                                        "
tela14Linha17 : string "                                        "
tela14Linha18 : string "                                        "
tela14Linha19 : string "                                        "
tela14Linha20 : string "                                        "
tela14Linha21 : string "                                        "
tela14Linha22 : string "                                        "
tela14Linha23 : string "                                        "
tela14Linha24 : string "                                        "
tela14Linha25 : string "                                        "
tela14Linha26 : string "                                        "
tela14Linha27 : string "                 PRESS                  "
tela14Linha28 : string "               [1] or [2]               "
tela14Linha29 : string "                                        "



tela15Linha0  : string "                                    E2  "
tela15Linha1  : string "                                        "
tela15Linha2  : string "                                        "
tela15Linha3  : string "                                        "
tela15Linha4  : string "                                        "
tela15Linha5  : string "                                        "
tela15Linha6  : string "                                        "
tela15Linha7  : string "                                        "
tela15Linha8  : string "                                        "
tela15Linha9  : string "                                        "
tela15Linha10 : string "                                        "
tela15Linha11 : string "                                        "
tela15Linha12 : string "                                        "
tela15Linha13 : string "                                        "
tela15Linha14 : string "                                        "
tela15Linha15 : string "                                        "
tela15Linha16 : string "                                        "
tela15Linha17 : string "                                        "
tela15Linha18 : string "                                        "
tela15Linha19 : string "                                        "
tela15Linha20 : string "                                        "
tela15Linha21 : string "                                        "
tela15Linha22 : string "                                        "
tela15Linha23 : string "                                        "
tela15Linha24 : string "                                        "
tela15Linha25 : string "                                        "
tela15Linha26 : string "                                        "
tela15Linha27 : string "                 PRESS                  "
tela15Linha28 : string "               [1] or [2]               "
tela15Linha29 : string "                                        "



tela16Linha0  : string "                                    F1  "
tela16Linha1  : string "                                        "
tela16Linha2  : string "                                        "
tela16Linha3  : string "    Voce se recusa a beber. Poderia     "
tela16Linha4  : string "    ter feito algo pior? Provavelmente  "
tela16Linha5  : string "    nao, agora alem de marcado voce     "
tela16Linha6  : string "    esta marcado mal. Os veteranos      "
tela16Linha7  : string "    nao gostaram de voce.               "
tela16Linha8  : string "                                        "
tela16Linha9  : string "    No fim das contas talvez tivesse    "
tela16Linha10 : string "    sido melhor dar PT como aconteceu   "
tela16Linha11 : string "    com o bixo que aceitou beber.       "
tela16Linha12 : string "                                        "
tela16Linha13 : string "    Pelo resto do semestre voce foi     "
tela16Linha14 : string "    alugado pelos veteranos. O lado     "
tela16Linha15 : string "    bom e que isso nao afetou muito     "
tela16Linha16 : string "    suas notas, mas nenhum veterano     "
tela16Linha17 : string "    quis te ajudar com provas antigas   "
tela16Linha18 : string "    ou dicas sobre professores.         "
tela16Linha19 : string "                                        "
tela16Linha20 : string "    Seu semestre foi ok mas vc acabou   "
tela16Linha21 : string "    se matriculando com um professor    "
tela16Linha22 : string "    carrasco pro proximo semestre,      "
tela16Linha23 : string "    entao se prepare.                   "
tela16Linha24 : string "                                        "
tela16Linha25 : string "                                        "
tela16Linha26 : string "                                        "
tela16Linha27 : string "                  FIM                   "
tela16Linha28 : string "                                        "
tela16Linha29 : string "                                        "



tela17Linha0  : string "                                    F2  "
tela17Linha1  : string "                                        "
tela17Linha2  : string "                                        "
tela17Linha3  : string "    E como diz aquela frase de Clarice  "
tela17Linha4  : string "    Lispector: Ta no inferno abraca o   "
tela17Linha5  : string "    capeta!                             "
tela17Linha6  : string "                                        "
tela17Linha7  : string "    Talvez nao seja dela essa frase     "
tela17Linha8  : string "    mas foi o que voce fez. Agarrou o   "
tela17Linha9  : string "    balde, virou e isso e tudo o que    "
tela17Linha10 : string "    lembra.                             "
tela17Linha11 : string "                                        "
tela17Linha12 : string "    No dia seguinte voce percebe que    "
tela17Linha13 : string "    esta vestindo roupas que nao sao    "
tela17Linha14 : string "    suas e nao faz ideia de onde esta.  "
tela17Linha15 : string "                                        "
tela17Linha16 : string "    E logico que voce decide fazer      "
tela17Linha17 : string "    isso mais vezes. Seu apelido vira   "
tela17Linha18 : string "    Cachaca e vc reprova em algumas     "
tela17Linha19 : string "    disciplinas nesse semestre mas      "
tela17Linha20 : string "    consegue pegar rec em outras.       "
tela17Linha21 : string "                                        "
tela17Linha22 : string "    Foi um semestre muito bom, se nao   "
tela17Linha23 : string "    considerar a faculdade...           "
tela17Linha24 : string "                                        "
tela17Linha25 : string "                                        "
tela17Linha26 : string "                                        "
tela17Linha27 : string "                  FIM                   "
tela17Linha28 : string "                                        "
tela17Linha29 : string "                                        "


tela18Linha0  : string "                                    G1  "
tela18Linha1  : string "                                        "
tela18Linha2  : string "                                        "
tela18Linha3  : string "    Vc gosta muito do role em que       "
tela18Linha4  : string "    esta, e mal pode esperar para       "
tela18Linha5  : string "    conhecer mais republicas e fazer    "
tela18Linha6  : string "    contatinhos.                        "
tela18Linha7  : string "                                        "
tela18Linha8  : string "    Na proxima festa de Rep, vc pensa   "
tela18Linha9  : string "    definitivamente em morar em Rep     "
tela18Linha10 : string "    para sempre ficar perto das         "
tela18Linha11 : string "    festinhas.                         	"
tela18Linha12 : string "                                        "
tela18Linha13 : string "    Em sua nova morada, sempre aparecem "
tela18Linha14 : string "    pessoas novas, vc tarta de amigar   "
tela18Linha15 : string "    com todas, e logo vc se torna       "
tela18Linha16 : string "    o paizao da casa.                   "
tela18Linha17 : string "                                        "
tela18Linha18 : string "    Sem antes ter se dado conta de      "
tela18Linha19 : string "    suas habilidades sociais, e         "
tela18Linha20 : string "    empreendedoras, vc abre uma casa    "
tela18Linha21 : string "    noturna na cidade e sai do curso    "
tela18Linha22 : string "    para seguir sua nova vocacao.       "
tela18Linha23 : string "                                        "
tela18Linha24 : string "                                        "
tela18Linha25 : string "                                        "
tela18Linha26 : string "                 FIM                    "
tela18Linha27 : string "                                        "
tela18Linha29 : string "                                        "



tela19Linha0  : string "                                    G2  "
tela19Linha1  : string "                                        "
tela19Linha2  : string "                                        "
tela19Linha3  : string "    Vc resolve sair cedo do role,       "
tela19Linha4  : string "    sem nada de marcante ter acontecido "
tela19Linha5  : string "    e nem conversa mais com o pessoal   "
tela19Linha6  : string "    que te convidou. No dia seguinte    "
tela19Linha7  : string "    vc ficou excluido da maioria dos    "
tela19Linha8  : string "    papos sobre o quao lokko fora       "
tela19Linha9  : string "    depois que vc saiu.                 "
tela19Linha10 : string "                                        "
tela19Linha11 : string "    Isso o deixa frustrado e fica so    "
tela19Linha12 : string "    no seu proprio canto.               "
tela19Linha13 : string "    Progressivamente, seus vicios em    "
tela19Linha14 : string "    jogos ficam mais graves ao longo    "
tela19Linha15 : string "    do semestre, pela afinidade com     "
tela19Linha16 : string "    jogos vc so conversa com a galera   "
tela19Linha17 : string "    nerd, fora isso as materias sempre  "
tela19Linha18 : string "    sao topico quente e vc esta por     "
tela19Linha19 : string "    dentro da materia quase que         "  
tela19Linha20 : string "    Automaticamente.                    "
tela19Linha21 : string "                                        "
tela19Linha22 : string "    Gracas ao ambiente propicio o       "
tela19Linha23 : string "    semestre foi facil. Contudo algo    "
tela19Linha24 : string "    mudou em vc. Seu corpo agora eh     "
tela19Linha25 : string "    morbido e bastante sedentario.      "
tela19Linha26 : string "                                        "
tela19Linha27 : string "                  FIM                   "
tela19Linha28 : string "                                        "
tela19Linha29 : string "                                        "
