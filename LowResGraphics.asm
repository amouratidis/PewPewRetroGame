		processor 	6502					; Select the 6502 as the processor    		
		org 		$1001					; The first spot in usable RAM
		
		.byte		$0C, $10				; Link to the next line
		.byte		$E0, $07				; Line 2016
	
		.byte		$9E						; SYS key
		
		.byte		$20						; Blank
		
		.byte		$34, $31, $31, $30		; 4110 - Start of machine language
		
		.byte       $00						; End of line
		.byte       $00, $00				; End of Basic Program
		
		
main	LDX #8								
		STX 36879
		
		JSR clrscn
		
		LDX #0		;@ - 7168						
		STX 7690		
		LDX #40		;( - 7208						
		STX 7691
		LDX #41		;. - 7272						
		STX 7692
		LDX #34		;" - 7328				
		STX 7712
		LDX #42		;* - 7332						
		STX 7713
		LDX #58		;: - 7348						
		STX 7714
		LDX #35		;# - 7388				
		STX 7734
		LDX #43		;+ - 7396				
		STX 7735
		LDX #59		;; - 7412						
		STX 7736	
	
		LDX #$FF	;; - Set the characters to be programmable
		STX 36869
		
		; Ship Top Left
		LDX #$00
		STX 7168
		LDX #$00
		STX 7169
		LDX #$00
		STX 7170
		LDX #$01
		STX 7171
		LDX #$01
		STX 7172
		LDX #$01
		STX 7173
		LDX #$01
		STX 7174
		LDX #$03
		STX 7175
		
		; Ship Top Middle
		LDX #$00
		STX 7488
		LDX #$00
		STX 7489
		LDX #$18
		STX 7490
		LDX #$18
		STX 7491
		LDX #$18
		STX 7492
		LDX #$7E
		STX 7493
		LDX #$FF
		STX 7494
		LDX #$FF
		STX 7495
		
		; Ship Top Right
		LDX #$00
		STX 7496
		LDX #$00
		STX 7497
		LDX #$00
		STX 7498
		LDX #$80
		STX 7499
		LDX #$80
		STX 7500
		LDX #$80
		STX 7501
		LDX #$80
		STX 7502
		LDX #$C0
		STX 7503
		
		; Ship Middle Left
		LDX #$07
		STX 7440
		LDX #$0F
		STX 7441
		LDX #$03
		STX 7442
		LDX #$01
		STX 7443
		LDX #$00
		STX 7444
		LDX #$00
		STX 7445
		LDX #$00
		STX 7446
		LDX #$00
		STX 7447
		
		; Ship Middle Middle
		LDX #$FF
		STX 7504
		LDX #$FF
		STX 7505
		LDX #$FF
		STX 7506
		LDX #$FF
		STX 7507
		LDX #$FF
		STX 7508
		LDX #$E7
		STX 7509
		LDX #$E7
		STX 7510
		LDX #$E7
		STX 7511
		
		; Ship Middle Right
		LDX #$E0
		STX 7632
		LDX #$F0
		STX 7633
		LDX #$C0
		STX 7634
		LDX #$80
		STX 7635
		LDX #$00
		STX 7636
		LDX #$00
		STX 7637
		LDX #$00
		STX 7638
		LDX #$00
		STX 7639
		
		; Ship Bottom Left
		LDX #$00
		STX 7448
		LDX #$00
		STX 7449
		LDX #$00
		STX 7450
		LDX #$00
		STX 7451
		LDX #$00
		STX 7452
		LDX #$00
		STX 7453
		LDX #$00
		STX 7454
		LDX #$00
		STX 7455
		
		; Ship Bottom Middle
		LDX #$42
		STX 7512
		LDX #$00
		STX 7513
		LDX #$00
		STX 7514
		LDX #$00
		STX 7515
		LDX #$00
		STX 7516
		LDX #$00
		STX 7517
		LDX #$00
		STX 7518
		LDX #$00
		STX 7519
		
		; Ship Bottom Right
		LDX #$00
		STX 76#40
		LDX #$00
		STX 7641
		LDX #$00
		STX 7642
		LDX #$00
		STX 7643
		LDX #$00
		STX 7644
		LDX #$00
		STX 7645
		LDX #$00
		STX 7646
		LDX #$00
		STX 7647
		
		RTS		
		
clrscn	LDA #$93							; Load the Clear-Screen command
        JSR $FFD2							; Run the Print Channel subroutine
		RTS
		
		
		; Ship
		.byte		$00						; 0000 0000
		.byte		$18						; 0001 1000
		.byte		$18						; 0001 1000
		.byte		$BC						; 1011 1101
		.byte		$FF						; 1111 1111
		.byte		$7E						; 0111 1110
		.byte		$24						; 0010 0100
		.byte		$00						; 0000 0000