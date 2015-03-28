;
; ********************************************
; * [Add Project title here]
;
; * [Add more info on software version here] *
; * (C)20xx by [Add Copyright Info here] *
; ********************************************
;
; Included header file for target AVR type
.NOLIST
.INCLUDE "m32def.inc" ; Header for ATMega32
.LIST
;
; ============================================
; H A R D W A R E I N F O R M A T I O N
; ============================================
;
; [Add all hardware information here]
;
; ============================================
;
; P O R T S A N D P I N S
; ============================================
;
; [Add names for hardware ports and pins here]
; Format: .EQU Controlportout = PORTA
;
.EQU SevenSeg = PORTC
.EQU SevenSegBank = PORTA
;
; ============================================
; C O N S T A N T S T O C H A N G E
; ============================================
;
; [Add all constants here that can be subject
; to change by the user]
; Format: .EQU const = $ABCD
;
; ============================================
; F I X + D E R I V E D C O N S T A N T S
; ============================================
;
; [Add all constants here that are not subject
; to change or calculated from constants]
; Format: .EQU const = $ABCD
;
; ============================================
; R E G I S T E R D E F I N I T I O N S
; ============================================
;
; [Add all register names here, include info on
; all used registers without specific names]
; Format: .DEF rmp = R16
;.DEF temp = R16 ; Multipurpose register
;
; ============================================
;
; S R A M D E F I N I T I O N S
; ============================================
;
.DSEG
.ORG 0X0060
; 
; Format: Label: .BYTE N ; reserve N Bytes from Label:
;
; ============================================
; R E S E T A N D I N T V E C T O R S
; ============================================
;
.CSEG
.ORG $0000
RJMP        main ; Reset
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
JMP         Timer1CompA_ISR
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        
RETI        

;
; ============================================
; I N T E R R U P T S E R V I C E S
; ============================================
;
Timer1CompA_ISR:
PUSH       R30
PUSH       R31
PUSH       R27
IN         R27, SREG
PUSH       R27
; your code goes here
POP        R27
OUT        SREG, R27
POP        R27
POP        R31
POP        R30
RETI
; end of _Timer1CompA_ISR

;
; ============================================
; Program Constants
; ============================================
; Example nums: .db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F



; ============================================
; M A I N P R O G R A M I N I T
; ============================================
main:

; Setup Stack
LDI        R27, LOW( RAMEND )
OUT        SPL, R27
LDI        R27, HIGH( RAMEND )
OUT        SPL+1, R27

RCALL      setup 					; Call setup

; while( 1 )
loop:

; Your code goes here

RJMP       loop
; end of _main
;


; =============================
;     Setup 
;==============================
setup:
LDI        R27, 15
OUT        DDRA, R27
; TCCR1A = 0x80;
LDI        R27, 128
OUT        TCCR1A, R27
; TCCR1B = 0x0C;
LDI        R27, 12
OUT        TCCR1B, R27
; OCR1AH = 0x7A;
LDI        R27, 122
OUT        OCR1AH, R27
; OCR1AL = 0x11;
LDI        R27, 17
OUT        OCR1AL, R27
; OCIE1A_bit = 1;
IN         R27, TIMSK
ORI        R27, ( 1 << OCIE1A )
OUT        TIMSK, R27
RET
; End of setup

