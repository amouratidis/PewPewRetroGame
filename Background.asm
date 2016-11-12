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
		JMP bkgloop
		
bkgloop	LDX #$08								; Black
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$18								; White
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$28								; Dark Red
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$38								; Cyan
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$48								; Purple
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$58								; Green
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$68								; Blue
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$78								; Yellow
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$88								; Brown
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$98								; Orange
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$A8								; Pink
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$B8								; Light Blue
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$C8								; Light Purple
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$D8								; Light Green
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$E8								; Light Purple
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$F8								; Light Yellow
		STX 36879								; Store in Color Reg
		JSR lwait
		JMP bkgloop	
		
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