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
		JMP brdloop
		
brdloop	LDX #$08								; Black
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$09								; White
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0A								; Dark Red
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0B								; Cyan
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0C								; Purple
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0D								; Green
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0E								; Blue
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0F								; Yellow
		STX 36879								; Store in Color Reg
		JSR lwait
		JMP brdloop	
		
lwait	LDY #$FF							; Spin the CPU for roughly one-half second
resetx	LDX #$FF
waitlp	DEX
		CPX #$0
		BNE waitlp
		DEY
		CPY #$0
		BNE resetx
		RTS
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS