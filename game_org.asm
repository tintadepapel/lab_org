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
	call AguardaOpcao2
	rts
	
;********************************************************
;                       NEXT 3
;******************************************************** 
next3:
	call ApagaTela
	loadn R1, #tela8Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao3 
	rts

;********************************************************
;                       NEXT 4
;******************************************************** 
next4:
	call ApagaTela
	loadn R1, #tela9Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	call AguardaOpcao3
	rts

;********************************************************
;                       NEXT 5
;******************************************************** 
next5:
	call ApagaTela
	loadn R1, #tela10Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao3 
	rts

;********************************************************
;                       NEXT 6
;******************************************************** 
next6:
	call ApagaTela
	loadn R1, #tela11Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2816   			; cor amarela!
	call ImprimeTela2
	;call AguardaOpcao3
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
tela8Linha5  : string "     voce foi muito inocente.            "
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
tela9Linha3  : string "               nerd de oculos           "
tela9Linha4  : string "                                        "
tela9Linha5  : string "                                        "
tela9Linha6  : string "                                        "
tela9Linha7  : string "                                        "
tela9Linha8  : string "                                        "
tela9Linha9  : string "                                        "
tela9Linha10 : string "                                        "
tela9Linha11 : string "                                        "
tela9Linha12 : string "                                        "
tela9Linha13 : string "                                        "
tela9Linha14 : string "                                        "
tela9Linha15 : string "                                        "
tela9Linha16 : string "                                        "
tela9Linha17 : string "                                        "
tela9Linha18 : string "                                        "
tela9Linha19 : string "                                        "
tela9Linha20 : string "                                        "
tela9Linha21 : string "                                        "
tela9Linha22 : string "                                        "
tela9Linha23 : string "                                        "
tela9Linha24 : string "                                        "
tela9Linha25 : string "                                        "
tela9Linha26 : string "                                        "
tela9Linha27 : string "                 PRESS                  "
tela9Linha28 : string "               [1] or [2]               "
tela9Linha29 : string "                                        "



tela10Linha0  : string "                                    C1  "
tela10Linha1  : string "                                        "
tela10Linha2  : string "                                        "
tela10Linha3  : string "                                        "
tela10Linha4  : string "                                        "
tela10Linha5  : string "            chegar na hora marcada      "
tela10Linha6  : string "                                        "
tela10Linha7  : string "                                        "
tela10Linha8  : string "                                        "
tela10Linha9  : string "                                        "
tela10Linha10 : string "                                        "
tela10Linha11 : string "                                        "
tela10Linha12 : string "                                        "
tela10Linha13 : string "                                        "
tela10Linha14 : string "                                        "
tela10Linha15 : string "                                        "
tela10Linha16 : string "                                        "
tela10Linha17 : string "                                        "
tela10Linha18 : string "                                        "
tela10Linha19 : string "                                        "
tela10Linha20 : string "                                        "
tela10Linha21 : string "                                        "
tela10Linha22 : string "                                        "
tela10Linha23 : string "                                        "
tela10Linha24 : string "                                        "
tela10Linha25 : string "                                        "
tela10Linha26 : string "                                        "
tela10Linha27 : string "                 PRESS                  "
tela10Linha28 : string "               [1] or [2]               "
tela10Linha29 : string "                                        "



tela11Linha0  : string "                                    C2  "
tela11Linha1  : string "                                        "
tela11Linha2  : string "                                        "
tela11Linha3  : string "                                        "
tela11Linha4  : string "         chegar mais tarde              "
tela11Linha5  : string "                                        "
tela11Linha6  : string "                                        "
tela11Linha7  : string "                                        "
tela11Linha8  : string "                                        "
tela11Linha9  : string "                                        "
tela11Linha10 : string "                                        "
tela11Linha11 : string "                                        "
tela11Linha12 : string "                                        "
tela11Linha13 : string "                                        "
tela11Linha14 : string "                                        "
tela11Linha15 : string "                                        "
tela11Linha16 : string "                                        "
tela11Linha17 : string "                                        "
tela11Linha18 : string "                                        "
tela11Linha19 : string "                                        "
tela11Linha20 : string "                                        "
tela11Linha21 : string "                                        "
tela11Linha22 : string "                                        "
tela11Linha23 : string "                                        "
tela11Linha24 : string "                                        "
tela11Linha25 : string "                                        "
tela11Linha26 : string "                                        "
tela11Linha27 : string "                 PRESS                  "
tela11Linha28 : string "               [1] or [2]               "
tela11Linha29 : string "                                        "



telaXLinha0  : string "                                    XX  "
telaXLinha1  : string "                                        "
telaXLinha2  : string "                                        "
telaXLinha3  : string "                                        "
telaXLinha4  : string "                                        "
telaXLinha5  : string "                                        "
telaXLinha6  : string "                                        "
telaXLinha7  : string "                                        "
telaXLinha8  : string "                                        "
telaXLinha9  : string "                                        "
telaXLinha10 : string "                                        "
telaXLinha11 : string "                                        "
telaXLinha12 : string "                                        "
telaXLinha13 : string "                                        "
telaXLinha14 : string "                                        "
telaXLinha15 : string "                                        "
telaXLinha16 : string "                                        "
telaXLinha17 : string "                                        "
telaXLinha18 : string "                                        "
telaXLinha19 : string "                                        "
telaXLinha20 : string "                                        "
telaXLinha21 : string "                                        "
telaXLinha22 : string "                                        "
telaXLinha23 : string "                                        "
telaXLinha24 : string "                                        "
telaXLinha25 : string "                                        "
telaXLinha26 : string "                                        "
telaXLinha27 : string "                 PRESS                  "
telaXLinha28 : string "               [1] or [2]               "
telaXLinha29 : string "                                        "