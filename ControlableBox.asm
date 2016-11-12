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
		JSR boxSUp
		
		LDX #$A8								; Pink
		STX 36879
		
		LDX #$F									; Load max volume
		STX 36878								; Store into volume reg
		
		LDA #$0									; Draw the box starting point
		STA 7724
		
		LDX #0
		STX $0									; Box Starts at 0,0
		STX $1
		
inp		JSR wait1
		LDA 197
		CMP #9									; Compare with W
		BEQ mvUp								; W - Move Up
		CMP #17									; Compare with A
		BEQ mvLeft								; A - Move Left
		CMP #41									; Compare with S
		BEQ mvDown								; S - Move Down
		CMP #18									; Compare with D
		BEQ mvRight								; D - Move Right
		JMP inp
endinp	JSR draw
		jmp inp
		
mvUp	LDX $1
		DEX										; Move one spot up
		TXA
		CMP #$FF								; Ensure we're not crossing a screen edge
		BEQ endinp
		STX $1
		jmp endinp
		
mvLeft	LDX $0
		DEX										; Move one spot left
		TXA
		CMP #$FF								; Ensure we're not crossing a screen edge
		BEQ endinp
		STX $0
		jmp endinp

mvRight	LDX $0
		INX
		TXA
		CMP #$16
		BEQ endinp
		STX $0
		jmp endinp


mvDown	LDX $1
		INX
		TXA
		CMP #$15
		BEQ endinp
		STX $1
		jmp endinp	


draw	LDX $1
		LDY #0
		TXA	
		CMP #$B
		BCC drawY
		CLC
		SBC #$A
		CMP #0
		BEQ drawX1
		TAX
drawY	TXA
		CMP #0
		BEQ drawX1
		CLC
		TYA
		ADC #$16
		TAY
		DEX
		JMP drawY
drawX1	LDX $0
drawX2	TXA
		CMP #0
		BEQ doneX
		DEX
		INY
		JMP drawX2
doneX	LDX $1
		TXA
		CMP #$B
		BCS draw2
		JMP draw1
enddraw RTS


draw1 	JSR clrscn
		LDA #$0
		STA 7724,Y
		JMP enddraw
		
draw2 	JSR clrscn
		LDA #$0
		STA 7966,Y
		JMP enddraw

wait1	LDY #$16							; Spin the CPU for roughly one-twentyith second
reset1	LDX #$FF
waitlp1	DEX
		CPX #$0
		BNE waitlp1
		DEY
		CPY #$0
		BNE reset1
		RTS		

		
boxSUp	LDX #$18	; Block line 1:
		STX 7168
		LDX #$18	; Block line 2:
		STX 7169
		LDX #$5A	; Block line 3:
		STX 7170
		LDX #$7E	; Block line 4:
		STX 7171
		LDX #$7E	; Block line 5:
		STX 7172
		LDX #$7E	; Block line 6:
		STX 7173
		LDX #$24	; Block line 7:
		STX 7174
		LDX #$00	; Block line 8:
		STX 7175
		
		LDX #$00	; Empty line 1: 0000 0000
		STX 7176
		LDX #$00	; Empty line 2: 0000 0000
		STX 7177
		LDX #$00	; Empty line 3: 0000 0000
		STX 7178
		LDX #$00	; Empty line 4: 0000 0000
		STX 7179
		LDX #$00	; Empty line 5: 0000 0000
		STX 7180
		LDX #$00	; Empty line 6: 0000 0000
		STX 7181
		LDX #$00	; Empty line 7: 0000 0000
		STX 7182
		LDX #$00	; Empty line 8: 0000 0000
		STX 7183
		
		LDX #$FF	;; - Set the characters to be programmable
		STX 36869
		RTS
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS