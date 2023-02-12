; ---------------------------------------------------------------------------
; FM Note Values: b-0 to a#8
; ---------------------------------------------------------------------------
; word_72790: FM_Notes:
FMFrequencies:
	dc.w $025E,$0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C
	dc.w $0A5E,$0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C
	dc.w $125E,$1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C
	dc.w $1A5E,$1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C
	dc.w $225E,$2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C
	dc.w $2A5E,$2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C
	dc.w $325E,$3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C
	dc.w $3A5E,$3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C

; ---------------------------------------------------------------------------
; PSG instruments used in music
; ---------------------------------------------------------------------------
PSGIndex:
		dc.l PSG1, PSG2, PSG3
		dc.l PSG4, PSG5, PSG6
		dc.l PSG7, PSG8, PSG9
PSG1:		incbin	"sound/psg/psg1.bin"
PSG2:		incbin	"sound/psg/psg2.bin"
PSG3:		incbin	"sound/psg/psg3.bin"
PSG4:		incbin	"sound/psg/psg4.bin"
PSG6:		incbin	"sound/psg/psg6.bin"
PSG5:		incbin	"sound/psg/psg5.bin"
PSG7:		incbin	"sound/psg/psg7.bin"
PSG8:		incbin	"sound/psg/psg8.bin"
PSG9:		incbin	"sound/psg/psg9.bin"

; word_729CE:
PSGFrequencies:
		dc.w $356, $326, $2F9, $2CE, $2A5, $280, $25C, $23A
		dc.w $21A, $1FB, $1DF, $1C4, $1AB, $193, $17D, $167
		dc.w $153, $140, $12E, $11D, $10D,  $FE,  $EF,  $E2
		dc.w  $D6,  $C9,  $BE,  $B4,  $A9,  $A0,  $97,  $8F
		dc.w  $87,  $7F,  $78,  $71,  $6B,  $65,  $5F,  $5A
		dc.w  $55,  $50,  $4B,  $47,  $43,  $40,  $3C,  $39
		dc.w  $36,  $33,  $30,  $2D,  $2B,  $28,  $26,  $24
		dc.w  $22,  $20,  $1F,  $1D,  $1B,  $1A,  $18,  $17
		dc.w  $16,  $15,  $13,  $12,  $11,    0

; ---------------------------------------------------------------------------
; Priority of sound. New music or SFX must have a priority higher than or equal
; to what is stored in v_sndprio or it won't play. If bit 7 of new priority is
; set ($80 and up), the new music or SFX will not set its priority -- meaning
; any music or SFX can override it (as long as it can override whatever was
; playing before). Usually, SFX will only override SFX, special SFX ($D0-$DF)
; will only override special SFX and music will only override music.
; ---------------------------------------------------------------------------
; SoundTypes:
SoundPriorities:
		dc.b $90, $90, $90, $90, $90, $90, $90,	$90, $90, $90, $90, $90, $90, $90, $90,	$90
		dc.b $90, $90, $90, $90, $90, $90, $90,	$90, $90, $90, $90, $90, $90, $90, $90,	$80
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $68, $70, $70, $70, $60, $70,	$70
		dc.b $60, $70, $60, $70, $70, $70, $70,	$70, $70, $70, $70, $70, $70, $70, $7F,	$60
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $70, $70, $70, $70, $70, $70,	$80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80, $80, $80, $80, $80, $80,	$90
		dc.b $90, $90, $90, $90

; ---------------------------------------------------------------------------
; New tempos for songs during speed shoes
; ---------------------------------------------------------------------------
; DANGER! several songs will use the first few bytes of MusicIndex as their main
; tempos while speed shoes are active. If you don't want that, you should add
; their "correct" sped-up main tempos to the list.
; byte_71A94:
SpeedUpIndex:
		dc.b 7		; GHZ
		dc.b $72	; LZ
		dc.b $73	; MZ
		dc.b $26	; SLZ
		dc.b $15	; SYZ
		dc.b 8		; SBZ
		dc.b $FF	; Invincibility
		dc.b 5		; Extra Life
		dc.b 4		; Special Stage
		dc.b $FF	; Title Screen
		dc.b 5		; Ending
		dc.b 8		; Boss
		dc.b 8		; FZ
		dc.b $FF	; Sonic Got Through
		dc.b 1		; Game Over
		dc.b 8		; Continue Screen
		dc.b 1		; Credits
		dc.b 1		; Drowning
		dc.b 1		; Chaos Emeralds
		even

; ---------------------------------------------------------------------------
; Music	Pointers
; ---------------------------------------------------------------------------
MusicIndex:
ptr_mus81:	dc.l Music81
ptr_mus82:	dc.l Music82
ptr_mus83:	dc.l Music83
ptr_mus84:	dc.l Music84
ptr_mus85:	dc.l Music85
ptr_mus86:	dc.l Music86
ptr_mus87:	dc.l Music87
ptr_mus88:	dc.l Music88
ptr_mus89:	dc.l Music89
ptr_mus8A:	dc.l Music8A
ptr_mus8B:	dc.l Music8B
ptr_mus8C:	dc.l Music8C
ptr_mus8D:	dc.l Music8D
ptr_mus8E:	dc.l Music8E
ptr_mus8F:	dc.l Music8F
ptr_mus90:	dc.l Music90
ptr_mus91:	dc.l Music91
ptr_mus92:	dc.l Music92
ptr_mus93:	dc.l Music93
ptr_musend

SonicDriverVer	equ 1
	include "sound/_smps2asm_inc.asm"
Music81:	include	"sound/music/Mus81 - GHZ.asm"
		even
Music82:	include	"sound/music/Mus82 - LZ.asm"
		even
Music83:	include	"sound/music/Mus83 - MZ.asm"
		even
Music84:	include	"sound/music/Mus84 - SLZ.asm"
		even
Music85:	include	"sound/music/Mus85 - SYZ.asm"
		even
Music86:	include	"sound/music/Mus86 - SBZ.asm"
		even
Music87:	include	"sound/music/Mus87 - Invincibility.asm"
		even
Music88:	include	"sound/music/Mus88 - Extra Life.asm"
		even
Music89:	include	"sound/music/Mus89 - Special Stage.asm"
		even
Music8A:	include	"sound/music/Mus8A - Title Screen.asm"
		even
Music8B:	include	"sound/music/Mus8B - Ending.asm"
		even
Music8C:	include	"sound/music/Mus8C - Boss.asm"
		even
Music8D:	include	"sound/music/Mus8D - FZ.asm"
		even
Music8E:	include	"sound/music/Mus8E - Sonic Got Through.asm"
		even
Music8F:	include	"sound/music/Mus8F - Game Over.asm"
		even
Music90:	include	"sound/music/Mus90 - Continue Screen.asm"
		even
Music91:	include	"sound/music/Mus91 - Credits.asm"
		even
Music92:	include	"sound/music/Mus92 - Drowning.asm"
		even
Music93:	include	"sound/music/Mus93 - Get Emerald.asm"
		even

; ---------------------------------------------------------------------------
; Sound	effect pointers
; ---------------------------------------------------------------------------

SoundIndex:
ptr_sndA0:	dc.l SoundA0
ptr_sndA1:	dc.l SoundA1
ptr_sndA2:	dc.l SoundA2
ptr_sndA3:	dc.l SoundA3
ptr_sndA4:	dc.l SoundA4
ptr_sndA5:	dc.l SoundA5
ptr_sndA6:	dc.l SoundA6
ptr_sndA7:	dc.l SoundA7
ptr_sndA8:	dc.l SoundA8
ptr_sndA9:	dc.l SoundA9
ptr_sndAA:	dc.l SoundAA
ptr_sndAB:	dc.l SoundAB
ptr_sndAC:	dc.l SoundAC
ptr_sndAD:	dc.l SoundAD
ptr_sndAE:	dc.l SoundAE
ptr_sndAF:	dc.l SoundAF
ptr_sndB0:	dc.l SoundB0
ptr_sndB1:	dc.l SoundB1
ptr_sndB2:	dc.l SoundB2
ptr_sndB3:	dc.l SoundB3
ptr_sndB4:	dc.l SoundB4
ptr_sndB5:	dc.l SoundB5
ptr_sndB6:	dc.l SoundB6
ptr_sndB7:	dc.l SoundB7
ptr_sndB8:	dc.l SoundB8
ptr_sndB9:	dc.l SoundB9
ptr_sndBA:	dc.l SoundBA
ptr_sndBB:	dc.l SoundBB
ptr_sndBC:	dc.l SoundBC
ptr_sndBD:	dc.l SoundBD
ptr_sndBE:	dc.l SoundBE
ptr_sndBF:	dc.l SoundBF
ptr_sndC0:	dc.l SoundC0
ptr_sndC1:	dc.l SoundC1
ptr_sndC2:	dc.l SoundC2
ptr_sndC3:	dc.l SoundC3
ptr_sndC4:	dc.l SoundC4
ptr_sndC5:	dc.l SoundC5
ptr_sndC6:	dc.l SoundC6
ptr_sndC7:	dc.l SoundC7
ptr_sndC8:	dc.l SoundC8
ptr_sndC9:	dc.l SoundC9
ptr_sndCA:	dc.l SoundCA
ptr_sndCB:	dc.l SoundCB
ptr_sndCC:	dc.l SoundCC
ptr_sndCD:	dc.l SoundCD
ptr_sndCE:	dc.l SoundCE
ptr_sndCF:	dc.l SoundCF
ptr_sndend
; ---------------------------------------------------------------------------
; Special sound effect pointers
; ---------------------------------------------------------------------------
SpecSoundIndex:
ptr_sndD0:	dc.l SoundD0
ptr_specend

SoundA0:	include	"sound/sfx/SndA0 - Jump.asm"
		even
SoundA1:	include	"sound/sfx/SndA1 - Lamppost.asm"
		even
SoundA2:	include	"sound/sfx/SndA2.asm"
		even
SoundA3:	include	"sound/sfx/SndA3 - Death.asm"
		even
SoundA4:	include	"sound/sfx/SndA4 - Skid.asm"
		even
SoundA5:	include	"sound/sfx/SndA5.asm"
		even
SoundA6:	include	"sound/sfx/SndA6 - Hit Spikes.asm"
		even
SoundA7:	include	"sound/sfx/SndA7 - Push Block.asm"
		even
SoundA8:	include	"sound/sfx/SndA8 - SS Goal.asm"
		even
SoundA9:	include	"sound/sfx/SndA9 - SS Item.asm"
		even
SoundAA:	include	"sound/sfx/SndAA - Splash.asm"
		even
SoundAB:	include	"sound/sfx/SndAB.asm"
		even
SoundAC:	include	"sound/sfx/SndAC - Hit Boss.asm"
		even
SoundAD:	include	"sound/sfx/SndAD - Get Bubble.asm"
		even
SoundAE:	include	"sound/sfx/SndAE - Fireball.asm"
		even
SoundAF:	include	"sound/sfx/SndAF - Shield.asm"
		even
SoundB0:	include	"sound/sfx/SndB0 - Saw.asm"
		even
SoundB1:	include	"sound/sfx/SndB1 - Electric.asm"
		even
SoundB2:	include	"sound/sfx/SndB2 - Drown Death.asm"
		even
SoundB3:	include	"sound/sfx/SndB3 - Flamethrower.asm"
		even
SoundB4:	include	"sound/sfx/SndB4 - Bumper.asm"
		even
SoundB5:	include	"sound/sfx/SndB5 - Ring.asm"
		even
SoundB6:	include	"sound/sfx/SndB6 - Spikes Move.asm"
		even
SoundB7:	include	"sound/sfx/SndB7 - Rumbling.asm"
		even
SoundB8:	include	"sound/sfx/SndB8.asm"
		even
SoundB9:	include	"sound/sfx/SndB9 - Collapse.asm"
		even
SoundBA:	include	"sound/sfx/SndBA - SS Glass.asm"
		even
SoundBB:	include	"sound/sfx/SndBB - Door.asm"
		even
SoundBC:	include	"sound/sfx/SndBC - Teleport.asm"
		even
SoundBD:	include	"sound/sfx/SndBD - ChainStomp.asm"
		even
SoundBE:	include	"sound/sfx/SndBE - Roll.asm"
		even
SoundBF:	include	"sound/sfx/SndBF - Get Continue.asm"
		even
SoundC0:	include	"sound/sfx/SndC0 - Basaran Flap.asm"
		even
SoundC1:	include	"sound/sfx/SndC1 - Break Item.asm"
		even
SoundC2:	include	"sound/sfx/SndC2 - Drown Warning.asm"
		even
SoundC3:	include	"sound/sfx/SndC3 - Giant Ring.asm"
		even
SoundC4:	include	"sound/sfx/SndC4 - Bomb.asm"
		even
SoundC5:	include	"sound/sfx/SndC5 - Cash Register.asm"
		even
SoundC6:	include	"sound/sfx/SndC6 - Ring Loss.asm"
		even
SoundC7:	include	"sound/sfx/SndC7 - Chain Rising.asm"
		even
SoundC8:	include	"sound/sfx/SndC8 - Burning.asm"
		even
SoundC9:	include	"sound/sfx/SndC9 - Hidden Bonus.asm"
		even
SoundCA:	include	"sound/sfx/SndCA - Enter SS.asm"
		even
SoundCB:	include	"sound/sfx/SndCB - Wall Smash.asm"
		even
SoundCC:	include	"sound/sfx/SndCC - Spring.asm"
		even
SoundCD:	include	"sound/sfx/SndCD - Switch.asm"
		even
SoundCE:	include	"sound/sfx/SndCE - Ring Left Speaker.asm"
		even
SoundCF:	include	"sound/sfx/SndCF - Signpost.asm"
		even
SoundD0:	include	"sound/sfx/SndD0 - Waterfall.asm"
		even

	include "MegaPCM.asm"

; ---------------------------------------------------------------
; DAC Samples Files
; ---------------------------------------------------------------

	IncludeDAC	kick, wav
	IncludeDAC	snare, wav
	IncludeDAC	timpani, wav
	IncludeDAC	timpanih, wav
	IncludeDAC	timpanim, wav
	IncludeDAC	timpaniml, wav
	IncludeDAC	timpanil, wav
	IncludeDAC	sega, wav
	even