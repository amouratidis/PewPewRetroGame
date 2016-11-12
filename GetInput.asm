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
inp		LDA 197
		CMP #9									; Compare with W
		BEQ blue								; W - Blue
		CMP #17									; Compare with A
		BEQ red									; A - Red
		CMP #41									; Compare with S
		BEQ grn									; S - Green
		CMP #18									; Compare with D
		BEQ yell								; D - Yellow
		JMP whit								; None of our inputs - White
		

whit 	LDX #$09								; White
		STX 36879								; Store in Color Reg
		JMP inp

blue 	LDX #$0E								; Blue
		STX 36879								; Store in Color Reg
		JMP inp

red 	LDX #$0A								; Dark Red
		STX 36879								; Store in Color Reg
		JMP inp

grn 	LDX #$0D								; Green
		STX 36879								; Store in Color Reg
		JMP inp

yell 	LDX #$0F								; Yellow
		STX 36879								; Store in Color Reg
		JMP inp

		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS