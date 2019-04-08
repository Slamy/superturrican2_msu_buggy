all: out/supertur2_msu1_ntsc_sd2snes.ips adrConv

out/supertur2_msu1_ntsc_sd2snes.ips: SuperTurrican2MSU_NTSC.asm
	cp -r "Super Turrican 2 (USA).sfc" out/supertur2_msu1_ntsc_sd2snes.sfc
	bass                    -o out/supertur2_msu1_ntsc_sd2snes.sfc SuperTurrican2MSU_NTSC.asm
	
	cp out/supertur2_msu1_ntsc_sd2snes.sfc /home/andre/Emulation/Super\ Famicom/supertur2_msu1.sfc/program.rom


adrConv: adrConv.c
