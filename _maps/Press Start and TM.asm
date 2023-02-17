; ---------------------------------------------------------------------------
; Sprite mappings - "PRESS START BUTTON" and "TM" from title screen
; ---------------------------------------------------------------------------
Map_PSB_internal:
		dc.w M_PSB_PSB-Map_PSB_internal
		dc.w M_PSB_TM-Map_PSB_internal
M_PSB_PSB:	dc.b 6			; "PRESS START BUTTON"
		dc.b 0,	$C, 0, $F0, 0
		dc.b 0,	0, 0, $F3, $20
		dc.b 0,	0, 0, $F3, $30
		dc.b 0,	$C, 0, $F4, $38
		dc.b 0,	8, 0, $F8, $60
		dc.b 0,	8, 0, $FB, $78
		even
M_PSB_TM:	dc.b 1			; "TM"
		dc.b $FC, 4, 0,	0, $F8
		even