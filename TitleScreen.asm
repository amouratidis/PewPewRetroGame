		processor 	6502					; Select the 6502 as the processor    		
		org 		$1001					; The first spot in usable RAM
		
		.byte		$0C, $10				; Link to the next line
		.byte		$E0, $07				; Line 2016
	
		.byte		$9E						; SYS key
		
		.byte		$20						; Blank
		
		.byte		$34, $31, $31, $30		; 4110 - Start of machine language
		
		.byte       $00						; End of line
		.byte       $00, $00				; End of Basic Program
		
		
main	JSR	clrscn							; Clear the Screen First	
		JSR scnSUp							; Set up the Screen Colors
		JSR ttlSUp
		
brdloop LDX #$0A								; Dark Red
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$09								; White
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$0E								; Blue
		STX 36879								; Store in Color Reg
		JSR lwait
		LDX #$09								; White
		STX 36879								; Store in Color Reg
		JSR lwait
		JMP chkInp								; Check for a space-bar press	
	

; Spin the CPU for a tiny amount of time
lwait	LDY #$01							
resetx	LDX #$FF
waitlp	DEX
		CPX #$0
		BNE waitlp
		DEY
		CPY #$0
		BNE resetx
		RTS

		
; Check the input - If spacebar is pressed, enter the game loop, keep looping
chkInp	LDA 197
		CMP #$20								; Compare with ' '
		BEQ gmloop								; Space Bar - Break loop
		JMP brdloop								; No input, continue drawing background

		
; Main Game loop goes here
gmloop	JSR clrscn
		JSR scnSUp
		JMP inloop
	
	
; Write out the Title and Authors
ttlSUp	LDX #1								; Set Font to White
		STX 646

		LDX #6								; Draw PEW
		LDY #9
		JSR setCurs							; Set the Cursor to (8,5)
		LDA #$50							; Draw 'P'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$45							; Draw 'E'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$57							; Draw 'W'
		JSR $FFD2							; Draw the letter in Accumulator
		
		LDX #7								; Draw PEW
		LDY #10
		JSR setCurs							; Set the Cursor to (9,6)
		LDA #$50							; Draw 'P'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$45							; Draw 'E'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$57							; Draw 'W'
		JSR $FFD2							; Draw the letter in Accumulator
		
		LDX #14								; Draw Aaron Mouratidis
		LDY #3
		JSR setCurs							; Set the Cursor to (9,6)
		LDA #$41							; Draw 'A'
		JSR $FFD2							; Draw the letter in Accumulator	
		LDA #$41							; Draw 'A'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$52							; Draw 'R'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4F							; Draw 'O'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4E							; Draw 'N'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$20							; Draw ' '
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4D							; Draw 'M'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4F							; Draw 'O'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$55							; Draw 'U'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$52							; Draw 'R'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$41							; Draw 'A'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$54							; Draw 'T'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$49							; Draw 'I'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$44							; Draw 'D'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$49							; Draw 'I'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$53							; Draw 'S'
		JSR $FFD2							; Draw the letter in Accumulator
		
		LDX #16								; Draw Daniel LaCunte
		LDY #4
		JSR setCurs							; Set the Cursor to (9,6)
		LDA #$44							; Draw 'D'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$41							; Draw 'A'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4E							; Draw 'N'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$49							; Draw 'I'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$45							; Draw 'E'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4C							; Draw 'L'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$20							; Draw ' '
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4C							; Draw 'L'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$41							; Draw 'A'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$43							; Draw 'C'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$4F							; Draw 'O'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$53							; Draw 'S'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$54							; Draw 'T'
		JSR $FFD2							; Draw the letter in Accumulator
		LDA #$45							; Draw 'E'
		JSR $FFD2							; Draw the letter in Accumulator
		
		RTS
	
	
; Set up the Screen Colors
scnSUp 	LDX #5								; Set Border to Black
		JSR setBrdr
		
		LDX #0								; Set Background to Black
		JSR setBkgd
		RTS
	
	
; Takes X as an input for background color	
setBkgd TXA
		ROL
		ROL
		ROL
		ROL
		TAX
		LDA 36879
		AND	#$0F
		STX $1001
		ORA $1001
		STA 36879
		RTS

	
; Takes X as an input for border color
setBrdr	LDA 36879
		ORA #$08
		AND	#$F8
		STX $1001
		ORA $1001
		STA 36879
		RTS
	
	
; Takes X and Y as input for where to move the cursor to that location on screen
; X ( 0 - 21 ) Screen Height
; Y ( 0 - 22 ) Screen Width
setCurs	CLC
		JSR	$FFF0
		RTS
		
; Clears the Screen - No Input
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS
		
; Loops infinitely - This should never be used
inloop	JMP inloop							; Infinite Loop