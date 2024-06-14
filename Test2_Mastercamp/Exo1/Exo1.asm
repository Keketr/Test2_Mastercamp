PROCESSOR 18F458
#include <xc.inc>
__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF

SUM_HIGH EQU 0x240    
SUM_LOW  EQU 0x241    
COUNT    EQU 0x20     
BASE_ADR EQU 0x400    

    ORG 0x0000
    


    CLRF SUM_HIGH, 0  ; initialisation à 0 de sum_high
    CLRF SUM_LOW, 0   ; initialisation à 0 de sum_low
    MOVLW 8         ; compteur à 8   
    MOVWF COUNT, 0    
    LFSR FSR0, BASE_ADR ; initialise le pointeur à 0

LOOP:
    MOVF POSTINC0, W, 0 
    ADDWF SUM_LOW, F, 0 ; ajoute à sum_low
    BTFSC STATUS, C     ; vérifie un débordement
    INCF SUM_HIGH, F, 0 
    DECFSZ COUNT, F, 0  ; décrémente le compteur
    BRA LOOP            

    MOVFF SUM_HIGH, 0x240
    MOVFF SUM_LOW, 0x241               

    END
