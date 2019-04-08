
arch snes.cpu

// MSU memory map I/O
constant MSU_STATUS($2000)
constant MSU_ID($2002)
constant MSU_AUDIO_TRACK_LO($2004)
constant MSU_AUDIO_TRACK_HI($2005)
constant MSU_AUDIO_VOLUME($2006)
constant MSU_AUDIO_CONTROL($2007)

// SPC communication ports
constant SPC_COMM_0($2140)

// MSU_STATUS possible values
constant MSU_STATUS_TRACK_MISSING($8)
constant MSU_STATUS_AUDIO_PLAYING(%00010000)
constant MSU_STATUS_AUDIO_REPEAT(%00100000)
constant MSU_STATUS_AUDIO_BUSY($40)
constant MSU_STATUS_DATA_BUSY(%10000000)


// Variables



// **********
// * Macros *
// **********
// seek converts SNES LoROM address to physical address
macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}


seek($7fd80)  //physical 0x3fd80, ganz viel platz hier
playSongCatch:
	plx
	// Das X Register enthält nun die Songnummer, die zu spielen ist.
	// Ist das 5. Bit gesetzt, so
	cpx #$80
	bcs msuSong
	
	//ok, also normal abspielen
	inc
	stx $2140
	sta $2143
	sta $04
	pld   
	plb
	plp
    
	rtl

msuSong:
	//also ein MSU Song
	//sta $04
	
    inc
	stx $2140
	sta $2143
	sta $04

endless:
    jmp endless
    
	pld   
	plb
	plp
	
	
	rtl


//ganz viel Platz noch bei 0x44800


//seek($81ba53)
//	nop
//	nop
//	nop
//	nop

//seek($09d6a6)
//	rts


//seek($89d649)
//	nop
//	nop
//	nop


//89d454 inc                    A:0b98 X:0014 Y:0004 S:02f2 D:0b08 B:00 nvMXdIZC
//89d455 plx                    A:0b99 X:0014 Y:0004 S:02f2 D:0b08 B:00 NvMXdIzC Letzter Write
//89d456 stx $2140     [002140] A:0b99 X:0000 Y:0004 S:02f3 D:0b08 B:00 nvMXdIZC //SPC Write 0 <= 00
//89d459 sta $2143     [002143] A:0b99 X:0000 Y:0004 S:02f3 D:0b08 B:00 nvMXdIZC //SPC Write 3 <= b99
//89d45c sta $04       [000b0c] A:0b99 X:0000 Y:0004 S:02f3 D:0b08 B:00 nvMXdIZC
//89d45e pld                    A:0b99 X:0000 Y:0004 S:02f3 D:0b08 B:00 nvMXdIZC

//seek($89d456)
//	nop
//	nop
//	nop
	
//	nop
//	nop
//	nop
	
//bfad69 1fad69 lda $13ed     [bf13ed] A:8000 X:008b Y:0009 S:02f5 D:1000 B:bf NvMXdIZC
//seek($bfad69)
//	lda.w #$0007

//seek($bfab4a)
//	lda.w #$0000

//81ba50 00ba50 ldy #$0004             A:0000 X:0005 Y:ea09 S:02fa D:0000 B:80 nvmxdIzC
//seek($81ba50)
//	ldy.w #$00ff

//89d447 04d447 ldx #$14               A:0ba9 X:0005 Y:0004 S:02f2 D:0b08 B:00 NvMXdIzC
//89d449 04d449 stx $2140     [002140] A:0ba9 X:0014 Y:0004 S:02f2 D:0b08 B:00 nvMXdIzC SPC Write 0 <= 14

//seek($89d447)
//	ldx.b #$04

//seek($81ba4d)
//	ldx.w #$0009


	//ldx #$0002
	//ldy #$000a

//89d44f 04d44f cmp $2143     [002143] A:0bf9 X:0014 Y:000a S:02d9 D:0b08 B:00 nvMXdIzC
//89d452 04d452 bne $d44f     [89d44f] A:0bf9 X:0014 Y:000a S:02d9 D:0b08 B:00 nvMXdIZC
	//89d454 04d454 inc                    A:0bf9 X:0014 Y:000a S:02d9 D:0b08 B:00 nvMXdIZC
//89d455 04d455 plx                    A:0bfa X:0014 Y:000a S:02d9 D:0b08 B:00 NvMXdIzC
	//89d456 04d456 stx $2140     [002140] A:0bfa X:0001 Y:000a S:02da D:0b08 B:00 nvMXdIzC SPC Write 0 <= 01 >>>>> Das ist der Song?!?!
	//89d459 04d459 sta $2143     [002143] A:0bfa X:0001 Y:000a S:02da D:0b08 B:00 nvMXdIzC SPC Write 3 <= bfa
//89d45c 04d45c sta $04       [000b0c] A:0bfa X:0001 Y:000a S:02da D:0b08 B:00 nvMXdIzC
//89d45e 04d45e pld                    A:0bfa X:0001 Y:000a S:02da D:0b08 B:00 nvMXdIzC
//89d45f 04d45f plb                    A:0bfa X:0001 Y:000a S:02dc D:0000 B:00 nvMXdIZC
//89d460 04d460 plp                    A:0bfa X:0001 Y:000a S:02dd D:0000 B:82 NvMXdIzC
//89d461 04d461 rtl                    A:0bfa X:0001 Y:000a S:02de D:0000 B:82 nvmxdIzC

//seek($89d454)
//	nop
	
//	plx
	
//	nop
//	nop
//	nop
	
//	nop
//	nop
//	nop
	

//ingame. Kurz bevor der Befehl zum Abspielen eines Songs gegeben wird.
seek($89d454)
	jml playSongCatch

//ingame werden Songs meist über 'jsl $89d012' abgerufen

//ersetzt Level 1-1 Wüste
seek($81ba4a)
    //lda #$0001 //Spielt Buggy Musik
    //lda #$00ff
	lda #$0081

//ersetzt Level 1-1 Buggy
seek($82979f)
	lda #$0082

//ersetzt Level 1-2 City
seek($81bfac)
	lda #$0083

//ersetzt Level 1-3 Gas
seek($81c450)
	lda #$0083

//ersetzt den Wurm-Boss
seek($81ce2b)
	lda #$0084

