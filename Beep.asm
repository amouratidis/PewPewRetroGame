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
		LDX #$F								; Load max volume
		STX 36878							; Store into volume reg
		LDX #$C8							; Load 200 as sound
		STX 36875							; Store into Sound Reg
		JSR lwait							; Wait roughly one-half second
		LDX #$A8							; Load 168 as sound
		STX 36875							; Store into Sound Reg
		JSR lwait							; Wait roughly one-half second
		JMP main
		
		
lwait	LDY #$FF							; Spin the CPU for roughly one-half second
resetx	LDX #$FF
waitlp	DEX
		CPX #$0
		BNE waitlp
		DEY
		CPY #$0
		BNE resetx
		RTS
		
		
inloop	JMP inloop							; Infinite Loop
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS