PROCESSOR 16F877A
#include <xc.inc>
;Juan sebastian Corredor gongora 2420172014 y david santiago guttierez 2420181064
;*CONFIGURACION**    
                                                      
CONFIG CP=OFF ; PFM and Data EEPROM code protection disabled
CONFIG DEBUG=OFF ; Background debugger disabled
CONFIG WRT=OFF
CONFIG CPD=OFF
CONFIG WDTE=OFF ; WDT Disabled; SWDTEN is ignored
CONFIG LVP=ON ; Low voltage programming enabled, MCLR pin, MCLRE ignored
CONFIG FOSC=XT
CONFIG PWRTE=ON
CONFIG BOREN=OFF

;*MEMORIA Y BANCOS*
PSECT udata_bank0
max:
 DS 1 ;reserve 1 byte for max
tmp:
 DS 1 ;reserve 1 byte for tmp
PSECT resetVec,class=CODE,delta=2
INISYS:
    ;CAMBIO A BANCO 1
    BCF STATUS, 6
    BSF STATUS, 5 ; Bank1
    ;Declarando solo los bits de entrada que se van a usar
    BSF TRISB, 0 ;Entrada punto 3
    BSF TRISB, 1 ;Entrada punto 3
    BSF TRISB, 2 ; Entrada punto 2
    BSF TRISB, 3 ; Entrada punto 3
    ;Declarando solo los bits de salida que se van a usar
    BCF TRISA, 0 ;Salida Punto 3
    BCF TRISA, 1 ;Salida Punto2
    BCF TRISA, 2 ;Salida punto1
    ;REGRESAR A BANCO 0
    BCF STATUS, 5 
    
;**CODIGO**
    ;Punto3_Examen
    main:
    ;A negado
    MOVF    PORTB,0    ;Mover puertoB a w
    ANDLW   00000001B; mascara para s0
    MOVWF   22H,1   ; guardar s0 en 22h
    COMF    22H,1    ; A negado en 22
    MOVF    22H,0
    MOVWF   PORTA
;**CODIGO**
    ;Punto2_Examen
    MOVF    PORTB,0    
    MOVWF   23H,1   
    BTFSC   23H,2
    GOTO    APAGA
    BSF	    PORTA,1
    GOTO    main
    APAGA:
    BCF	    PORTA,1
   ;**CODIGO
   MOVF    PORTB,0    
    MOVWF   27H,1   
    BTFSS   27H,3
    GOTO    PRENDE
    BCF	    PORTA,2
    GOTO    main
    PRENDE:
    BSF	    PORTA,2
    END

