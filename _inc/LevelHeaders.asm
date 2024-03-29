; ---------------------------------------------------------------------------
; Level Headers
; ---------------------------------------------------------------------------

LevelHeaders:

lhead:	macro plc1,lvlgfx,plc2,sixteen,twofivesix,pal
	dc.l (plc1<<24)+lvlgfx
	dc.l (plc2<<24)+sixteen
	dc.l twofivesix
	dc.b pal, 0, 0, 0
	endm

	lhead	plcid_GHZ,	Nem_GHZ_2nd,	plcid_GHZ2,	Blk16_GHZ,	Blk256_GHZ,	palid_GHZ		; Green Hill
	lhead	plcid_LZ,	Nem_LZ,			plcid_LZ2,	Blk16_LZ,	Blk256_LZ,	palid_LZ		; Labyrinth
	lhead	plcid_MZ,	Nem_MZ,			plcid_MZ2,	Blk16_MZ,	Blk256_MZ,	palid_MZ		; Marble
	lhead	plcid_SLZ,	Nem_SLZ,		plcid_SLZ2,	Blk16_SLZ,	Blk256_SLZ,	palid_SLZ		; Star Light
	lhead	plcid_SYZ,	Nem_SYZ,		plcid_SYZ2,	Blk16_SYZ,	Blk256_SYZ,	palid_SYZ		; Spring Yard
	lhead	plcid_SBZ,	Nem_SBZ,		plcid_SBZ2,	Blk16_SBZ,	Blk256_SBZ,	palid_SBZ1		; Scrap Brain
	zonewarning LevelHeaders,$10
	lhead  	plcid_Ending,Nem_GHZ_2nd,			0,	Blk16_GHZ,	Blk256_GHZ,	palid_Ending	; Ending
	even

;	* music and level gfx are actually set elsewhere, so these values are useless