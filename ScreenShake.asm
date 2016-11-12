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
		JMP shkloop
		
shkloop LDX #$0D								; Right
		STX 36864								; Store in ImageXPos Reg
		LDX #$25								; Up
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0C								; Default Pos
		STX 36864								; Store in ImageXPos Reg
		LDX #$26								; Default Pos
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0B								; Left
		STX 36864								; Store in ImageXPos Reg
		LDX #$27								; Down
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0C								; Default Pos
		STX 36864								; Store in ImageXPos Reg
		LDX #$26								; Default Pos
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0D								; Right
		STX 36864								; Store in ImageXPos Reg
		LDX #$25								; Up
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0C								; Default Pos
		STX 36864								; Store in ImageXPos Reg
		LDX #$26								; Default Pos
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0B								; Left
		STX 36864								; Store in ImageXPos Reg
		LDX #$27								; Down
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		LDX #$0C								; Default Pos
		STX 36864								; Store in ImageXPos Reg
		LDX #$26								; Default Pos
		STX 36865								; Store in ImageYPos Reg
		JSR lwait
		;JMP shkloop	
		
lwait	LDY #$32							; Spin the CPU for roughly one-tenth second
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