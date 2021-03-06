          ORG $100
PORTA EQU $1000
PORTB EQU $1004
MASKA EQU $03

INICIO    CLR PORTB
          LDS #FINPRO+10
SECDEC    JSR RUTEC ; SECUENCIA DE
          LDAA BANTEC; DETECCION DE TECLA
          BEQ  SECDEC;BANTEC=0 ->NO HAY TECLA OPRIMIDA
PRUINC    LDAA REGTEC
          CMPA #01
          BEQ INCREPB
          CMPA #02
          BEQ DECREPB
          BRA SECDEC
INCREPB   INC PORTB
          BRA SECDEC
DECREPB   DEC PORTB
          BRA SECDEC

;**********************************************************
;                         SUBRUTINA
;**********************************************************
RUTEC     CLR  BANTEC
          LDAA PORTA
          ANDA #MASKA
          CMPA #MASKA
          BEQ SALTEC; NO HUBO TECLA
          BSR REBOTE
          LDAA PORTA
          ANDA #MASKA
          CMPA #MASKA
          BEQ SALTEC
          CLR REGTEC
          LDAA BANTEC
          CMPA #$02
          BNE REGTEC
          INC REGTEC
          CLR BANTEC
          DEC BANTEC ; BANTEC=FF
          BRA SALTEC
RUTRC1    CMPA #$01
          BEQ RUTEC2
          CLR BANTEC
          BRA SALTEC
RUTEC2    INC REGTEC
          INC REGTEC
          CLR BANTEC
          DEC BANTEC
SALTEC    LDAA PORTA
          ANDA #MASKA
          CMPA #MASKA
          BNE SALTEC
          BSR REBOTE
          RTS
REBOTE    LDX #2C72
REBOTE1   DEX
          BNE REBOTE1
          RTS
REGTEC    RMB 1
BANTEC    RMB 1
FINPRO    NOP




