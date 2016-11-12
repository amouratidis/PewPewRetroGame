		processor 	6502					; Select the 6502 as the processor    		
		org 		$1001					; The first spot in usable RAM
		
		.byte		$0C, $10				; Link to the next line
		.byte		$E0, $07				; Line 2016
	
		.byte		$9E						; SYS key
		
		.byte		$20						; Blank
		
		.byte		$34, $31, $31, $30		; 4110 - Start of machine language
		
		.byte       $00						; End of line
		.byte       $00, $00				; End of Basic Program
		
		
		
; Start of the program		
main	JSR	clrscn
		JSR scnSUp
		JSR objSUp
		JSR shipSUp
		JSR lsrSUp

		LDX #0
		STX $10									; Box Starts at 0,0
		STX $11
		
		JMP inp

		
inp		JSR wait1
		
		JSR clrscn							; Clear the screen at the start of each re-draw
		JSR drwObj
		JSR drwShip
		JSR incObj
		
		LDA 197
		CMP #9									; Compare with W
		BEQ mvUp								; W - Move Up
		CMP #17									; Compare with A
		BEQ mvLeft								; A - Move Left
		CMP #41									; Compare with S
		BEQ mvDown								; S - Move Down
		CMP #18									; Compare with D
		BEQ mvRight								; D - Move Right
		CMP #$20									; Compare with ' '
		BEQ shoot								; Shoot a laser
endinp	JMP inp

		
mvUp	LDX $11
		DEX										; Move one spot up
		TXA
		CMP #$FF								; Ensure we're not crossing a screen edge
		BEQ endinp
		STX $11
		jmp endinp
		
mvLeft	LDX $10
		DEX										; Move one spot left
		TXA
		CMP #$FF								; Ensure we're not crossing a screen edge
		BEQ endinp
		STX $10
		jmp endinp

mvRight	LDX $10
		INX
		TXA
		CMP #$16
		BEQ endinp
		STX $10
		jmp endinp


mvDown	LDX $11
		INX
		TXA
		CMP #$15
		BEQ endinp
		STX $11
		jmp endinp	

		
shoot	LDX #01
		STX $00
		LDX #04
		STX $01
		LDX $10
		STX $02
		LDX $11
		STX $03
		JSR addObj
		JMP endinp
	
drwShip	LDX #$1
		STX $12
		LDX $10
		STX $00
		LDX $11
		STX $01
		JSR draw
		RTS

drwObj	LDX #$0								; Current offset
		STX $12								; Make sure we draw lasers
		LDY #$0								; Current object
drwObj1	LDA $21,X							; Check the current object
		CMP #$FF							; Check if this object is empty
		BEQ drwObj2
		LDA $23,X
		STA $00
		LDA $24,X
		STA $01
		STX $02
		STY $03
		JSR	draw
		LDX $02
		LDY $03
drwObj2	TXA
		CLC									; Update variables and check if we're done
		ADC #4
		TAX
		INY
		CPY #20
		BNE drwObj1							; Return to start of loop if we havent checked all objects
		RTS
		
		
draw	LDX $1
		LDY #0
		TXA	
		CMP #$B
		BCC drawY
		SEC
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


draw1 	LDA $12
		STA 7724,Y
		JMP enddraw
		
draw2 	LDA $12
		STA 7944,Y
		JMP enddraw

; Iterate through the object list - Update the (X/Y Values based on the vector)
incObj	LDX #$0								; Current offset
		LDY #$0								; Current object
incObj1	LDA $21,X							; Check the current object
		CMP #$FF							; Check if this object is empty
		BEQ incObj2
		STX $00								; Object not empty - Store A/X/Y and JSR
		STA $01
		STY $02
		JSR upObj
		LDX $00
		LDA $01
		LDY $02
incObj2	TXA
		CLC									; Update variables and check if we're done
		ADC #4
		TAX
		INY
		CPY #20
		BNE incObj1							; Return to start of loop if we havent checked all objects
		RTS
		

; Update the current object ( X = Offset of object, Y = Speed, A = Direction )
upObj	LDY	$22,X							; Get the Vector for the object
		STY $03								; Store the Vector for use
		LDA #$1C
		AND $03								; Get the Speed from memory
		LSR
		LSR
		TAY
		STY	$04
		LDA #$03							
		AND $03								; Get the Direction from memory
		CMP #00
		BEQ upObj1							; Moving Up
		CMP #01
		BEQ upObj2							; Moving Right
		CMP #02
		BEQ upObj3							; Moving Down
		CMP #03
		BEQ upObj4							; Moving Left
		JMP upObj5							; This line should never be reached! - Use it for safety
upObj1	LDA $24,X							; Get the Y Value
		CMP $04
		BCS	upObj11							; Branch when Y Value is >= Speed
		JSR remObj							; Remove the Object indexed by Y (This Object)
		JMP upObj5							; Done - Jump to end
upObj11	SEC
		SBC	$04								; Subtract the movement
		STA	$24,X
		JMP upObj5
upObj2	LDA $23,X							; Get the X Value
		CLC
		ADC	$04								; Add the movement
		STA	$23,X
		CMP #22								; Compare X with Screen Edge
		BCS upObj21							; Branch when X is >= Screen Edge				
		JMP upObj5							; Done - Jump to end
upObj21	JSR remObj							; Remove the Object indexed by Y (This Object)
		JMP upObj5
upObj3	LDA $24,X							; Get the Y Value
		CLC
		ADC	$04								; Add the movement
		STA	$24,X
		CMP #22								; Compare Y with Screen Edge
		BCS upObj31							; Branch when X is >= Screen Edge				
		JMP upObj5							; Done - Jump to end
upObj31	JSR remObj							; Remove the Object indexed by Y (This Object)
		JMP upObj5
upObj4	LDA $23,X							; Get the X Value
		CMP $04
		BCS	upObj41							; Branch when X Value is >= Speed
		JSR remObj							; Remove the Object indexed by Y (This Object)
		JMP upObj5							; Done - Jump to end
upObj41	SEC
		SBC	$04
		STA	$23,X
		JMP upObj5
upObj5	RTS
		
	
; Add an object to our list ( $00 = Object Type, $01 = Vector, $02 = X Cord, $03 = Y Cord )
; Object list size at $20, Object list stored from $21 onward
addObj	LDX #$0								; X is the current offset
		LDY #$0								; Y is the current object - Make sure this doesn't exceed our maximum list size
addObj1	LDA $21,X							; Get the value of the first byte at the current object
		INY
		CMP #$FF							; Check if this object is empty
		BEQ addObj2
		CPY	#20								; Compare Y with 20
		BEQ addObj3							; End this function if we've checked all 20 slots
		TXA
		CLC
		ADC #4
		TAX
		JMP addObj1							; Not done yet, keep checking
addObj2	LDA $00								; Clear to add the object at this point
		STA $21,X
		LDA $01
		STA $22,X
		LDA $02
		STA $23,X
		LDA $03
		STA $24,X
addObj3	RTS									; We're done attempting to add, return now
		
		
; Remove an object from the list ( X Register = Object Offset )
; Decrement object counter
remObj	LDA #$FF
		STA $21,X							; Clear all four object bytes
		STA $22,X
		STA $23,X
		STA $24,X
		DEC $20								; Decrement the total number of objects
		RTS
		
; Setup the screen
scnSUp	LDX #$A8							; Pink
		STX 36879
		LDX #$FF							; Set the characters to be programmable
		STX 36869
		RTS
		
		
; Setup the object list
objSUp	LDX #$00							; List starts at size 0
		STX $20
		LDY #20								; List is size 20
		LDX #0
oSUpLp	LDA #$FF							; Load a "no-object"
		STA $21,X							; Clear all 4 bytes of this object
		STA $22,X
		STA $23,X
		STA $24,X
		TXA
		CLC
		ADC #4								; Add 4 to A (Next Obj)
		TAX
		DEY									; Decrement Y
		CPY #$0								; Check if we're done looping (20 times total)
		BNE oSUpLp
		RTS

; Setup the laser objects to be drawable
; #$00 = Whole laser, #$01 = Top half, #$02 = Bottom half
lsrSUp	LDX #$24							; Laser Line
		STX 7168							; Line 1
		STX 7169							; Line 2
		STX 7170							; Line 3
		STX 7171							; Line 4
		STX 7172							; Line 5
		STX 7173							; Line 6
		STX 7174							; Line 7
		STX 7175							; Line 8
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

		
shipSUp	LDX #$18	; Block line 1:
		STX 7176
		LDX #$18	; Block line 2:
		STX 7177
		LDX #$5A	; Block line 3:
		STX 7178
		LDX #$7E	; Block line 4:
		STX 7179
		LDX #$7E	; Block line 5:
		STX 7180
		LDX #$7E	; Block line 6:
		STX 7181
		LDX #$24	; Block line 7:
		STX 7182
		LDX #$00	; Block line 8:
		STX 7183
		RTS
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS