		processor 	6502					; Select the 6502 as the processor    		
		org 		$1001					; The first spot in usable RAM
		
		.byte		$0C, $10				; Link to the next line
		.byte		$E0, $07				; Line 2016
	
		.byte		$9E						; SYS key
		
		.byte		$20						; Blank
		
		.byte		$34, $31, $31, $30		; 4110 - Start of machine language
		
		.byte       $00						; End of line
		.byte       $00, $00				; End of Basic Program
		
		
main	LDX #$A8								; Pink
		STX 36879
		JSR clrscn
		
		LDX #$FF	; Block line 1: 1111 1111
		STX 7168
		LDX #$81	; Block line 2: 1000 0001
		STX 7169
		LDX #$81	; Block line 3: 1000 0001
		STX 7170
		LDX #$81	; Block line 4: 1000 0001
		STX 7171
		LDX #$81	; Block line 5: 1000 0001
		STX 7172
		LDX #$81	; Block line 6: 1000 0001
		STX 7173
		LDX #$81	; Block line 7: 1000 0001
		STX 7174
		LDX #$FF	; Block line 8: 1111 1111
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
			
		LDX #$0
		
mvloop1 LDA #$0
		STA 7690,X
		STX $00
		JSR wait1
		LDX $00		
		LDA #$1
		STA 7690,X
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		INX
		CPX #$F2
		BNE mvloop1
		
		LDX #$0
		
mvloop2 LDA #$0
		STA 7932,X
		STX $00
		JSR wait1
		LDX $00		
		LDA #$1
		STA 7932,X
		CLC
		TXA
		ADC #22
		TAX
		CPX #$F2
		BNE mvloop2
		LDX #$0
		LDA #$0
		STA 8174
		JSR wait1
		LDA #$1
		STA 8174
		JMP mvloop1

wait1	LDY #$64							; Spin the CPU for roughly one-twentyith second
reset1	LDX #$FF
waitlp1	DEX
		CPX #$0
		BNE waitlp1
		DEY
		CPY #$0
		BNE reset1
		RTS
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS