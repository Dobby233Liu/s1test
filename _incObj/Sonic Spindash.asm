; ---------------------------------------------------------------------------
; Subroutine to make Sonic perform a spindash
; ---------------------------------------------------------------------------
;||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

Sonic_Spindash_DoAnim:
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0) ; use "rolling" animation
		addq.w	#5,obY(a0)
		rts

Sonic_Spindash: 
		tst.b f_spindash(a0) 
		bne.s Sonic_Spindash_Loop 
		cmpi.b #id_Duck,obAnim(a0) 
		bne.s Sonic_Spindash_Quit
		move.b (v_jpadpress2).w,d0 
		andi.b #$70,d0 
		beq.w Sonic_Spindash_Quit 
		bsr.w Sonic_Spindash_DoAnim
		sfx sfx_Roll,0,0,0
		addq.l #4,sp ; skip rts
		move.b #1,f_spindash(a0) 
		move.w #0,spindash_speed(a0)

Sonic_Spindash_Postprocess: 
		bsr.w Sonic_LevelBound 
		bsr.w Sonic_AnglePos

Sonic_Spindash_Quit: 
		rts

;---------------------------------------------------------------------------

Sonic_Spindash_Loop:
		bsr.w Sonic_Spindash_DoAnim
		move.b (v_jpadhold2).w,d0 
		btst #1,d0 
		bne.w Sonic_Spindash_StillCharging
		; EDIT
		bsr.w Sonic_Spindash_DoAnim
		; EDIT
		move.b #0,f_spindash(a0) 
		moveq #0,d0 
		move.b spindash_speed(a0),d0 
		add.w d0,d0 
		move.w Sonic_Spindash_Speeds(pc,d0.w),obInertia(a0) 
		move.w obInertia(a0),d0 
		subi.w #$800,d0 
		add.w d0,d0 
		andi.w #$1F00,d0 
		neg.w d0 
		addi.w #$2000,d0 
		move.w d0,($FFFFC904).w 
		btst #0,obStatus(a0) 
		beq.s Sonic_Spindash_Release 
		neg.w obInertia(a0)

Sonic_Spindash_Release: 
		bset #2,obStatus(a0)
		sfx sfx_Teleport,0,0,0
		bra.s Sonic_Spindash_LookShift

;===========================================================================

Sonic_Spindash_Speeds: 
	dc.w $800 ; 0 
	dc.w $880 ; 1 
	dc.w $900 ; 2 
	dc.w $980 ; 3 
	dc.w $A00 ; 4 
	dc.w $A80 ; 5 
	dc.w $B00 ; 6 
	dc.w $B80 ; 7 
	dc.w $C00 ; 8

;===========================================================================

Sonic_Spindash_StillCharging: ; If Sonic is still charging the dash... 
		tst.w spindash_speed(a0) 
		beq.s Sonic_Spindash_Charging 
		move.w spindash_speed(a0),d0 
		lsr.w #5,d0 
		sub.w d0,spindash_speed(a0) 
		bcc.s Sonic_Spindash_Charging 
		move.w #0,spindash_speed(a0)

Sonic_Spindash_Charging: 
		move.b (v_jpadpress2).w,d0 
		andi.b #$70,d0
		beq.w Sonic_Spindash_LookShift
		sfx sfx_Roll,0,0,0
		addi.w #$200,spindash_speed(a0) 
		cmpi.w #$800,spindash_speed(a0) 
		bcs.s Sonic_Spindash_LookShift 
		move.w #$800,spindash_speed(a0)

Sonic_Spindash_LookShift:
		addq.l #4,sp 
		cmpi.w #$60,(v_lookshift).w 
		beq.s Sonic_Spindash_End 
		bcc.s Sonic_Spindash_LookShift_Subq 
		addq.w #4,(v_lookshift).w
	Sonic_Spindash_LookShift_Subq: 
			subq.w #2,(v_lookshift).w

Sonic_Spindash_End: 
		bsr.w Sonic_LevelBound 
		bsr.w Sonic_AnglePos
		move.w #$60,(v_lookshift).w
		rts
; End of subroutine Sonic_Spindash