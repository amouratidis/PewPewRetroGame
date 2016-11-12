		processor 	6502					; Select the 6502 as the processor    		
		org 		$1001					; The first spot in usable RAM
		
		.byte		$0C, $10				; Link to the next line
		.byte		$E0, $07				; Line 2016
	
		.byte		$9E						; SYS key
		
		.byte		$20						; Blank
		
		.byte		$34, $31, $31, $30		; 4110 - Start of machine language
		
		.byte       $00						; End of line
		.byte       $00, $00				; End of Basic Program
		
		
		
main	JSR	clrscn
		JSR palph
		JMP inloop

palph	LDX #$40							; Start at 'A'
		STX $00
		LDY #1
next	JSR pchar
		TYA
		ASL
		TAY
		JSR pchar
		TYA
		ASL
		TAY
		JSR pchar
		STY $01
		ASL $01
		TAY
		JSR pchar
		LDY $01
		JSR pchar
		RTS									; Done - Return
		
pchar	CLC
		TYA
		ADC $00
		JSR $FFD2							; Draw the letter in Accumulator
		RTS
		
		
	
inloop	JMP inloop							; Infinite Loop
	
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS