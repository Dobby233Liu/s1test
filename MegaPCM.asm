
; ===============================================================
; Mega PCM Driver Include File
; (c) 2012, Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables used in DAC table
; ---------------------------------------------------------------

; flags
panLR	= $C0
panL	= $80
panR	= $40
pcm		= 0
dpcm	= 4
loop	= 2
pri		= 1

; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

z80word macro Value
	dc.w	((\Value)&$FF)<<8|((\Value)&$FF00)>>8
	endm

DAC_Entry macro Pitch,Offset,Flags
	dc.b	\Flags					; 00h	- Flags
	dc.b	\Pitch					; 01h	- Pitch
	dc.b	(\Offset>>15)&$FF		; 02h	- Start Bank
	dc.b	(\Offset\_End>>15)&$FF	; 03h	- End Bank
	z80word	(\Offset)|$8000			; 04h	- Start Offset (in Start bank)
	z80word	(\Offset\_End-1)|$8000	; 06h	- End Offset (in End bank)
	endm
	
IncludeDAC macro Name,Extension
\Name:
	if strcmp('\extension','wav')
		incbin	'sound/dac/\Name\.\Extension\',$3A
	else
		incbin	'sound/dac/\Name\.\Extension\'
	endc
\Name\_End:
	endm

; ---------------------------------------------------------------
; Driver's code
; ---------------------------------------------------------------

MegaPCM:
	incbin	"MegaPCM.z80"

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

	DAC_Entry	$05, kick, pcm			; $81	- Kick
	DAC_Entry	$05, snare, pcm			; $82	- Snare
	DAC_Entry	$08, timpani, pcm		; $83	- Timpani
	DAC_Entry	$02, timpani, pcm		; $84	- Hi-Timpani
	DAC_Entry	$04, timpani, pcm		; $85	- Mid-Timpani
	DAC_Entry	$06, timpani, pcm		; $86	- Mid-Low-Timpani
	DAC_Entry	$08, timpani, pcm		; $87	- Low-Timpani
	DAC_Entry	$05, sega, pcm+pri		; $88	- "Sega" sound

MegaPCM_End: