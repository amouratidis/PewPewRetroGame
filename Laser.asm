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
sound	LDX #$E7							; Load 200 as sound
		STX 36876							; Store into Sound Reg
		JSR wait1							
		LDX #$E5							; Load 200 as sound
		STX 36876							; Store into Sound Reg
		JSR wait1							
		LDX #$E3							; Load 200 as sound
		STX 36876							; Store into Sound Reg
		JSR wait1							
		LDX #$E2							; Load 200 as sound
		STX 36876							; Store into Sound Reg
		JSR wait1							
		LDX #$E1							; Load 200 as sound
		STX 36876							; Store into Sound Reg
		JSR wait1			
		BRK
		
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS
		
wait1	LDY #$16							; Spin the CPU for roughly one-twentyith second
reset1	LDX #$FF
waitlp1	DEX
		CPX #$0
		BNE waitlp1
		DEY
		CPY #$0
		BNE reset1
		RTS