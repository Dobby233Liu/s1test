; ---------------------------------------------------------------------------
; Object 2E - contents of monitors
; ---------------------------------------------------------------------------

PowerUp:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Pow_Index(pc,d0.w),d1
		jsr	Pow_Index(pc,d1.w)
		bra.w	DisplaySprite
; ===========================================================================
Pow_Index:	dc.w Pow_Main-Pow_Index
		dc.w Pow_Move-Pow_Index
		dc.w Pow_Delete-Pow_Index
; ===========================================================================

Pow_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.w	#$680,obGfx(a0)
		move.b	#$24,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	#-$300,obVelY(a0)
		moveq	#0,d0
		move.b	obAnim(a0),d0	; get subtype
		addq.b	#2,d0
		move.b	d0,obFrame(a0)	; use correct frame
		movea.l	#Map_Monitor,a1
		add.b	d0,d0
		adda.w	(a1,d0.w),a1
		addq.w	#1,a1
		move.l	a1,obMap(a0)

Pow_Move:	; Routine 2
		tst.w	obVelY(a0)	; is object moving?
		bpl.w	Pow_Checks	; if not, branch
		bsr.w	SpeedToPos
		addi.w	#$18,obVelY(a0)	; reduce object	speed
		rts	
; ===========================================================================

Pow_Checks:
		addq.b	#2,obRoutine(a0)
		move.w	#$2A,obTimeFrame(a0) ; display icon for half a second
		move.b	obAnim(a0),d0

Pow_ChkEggman:
		cmpi.b	#0,d0		; does monitor contain Static?
		beq.s	Pow_ChkEggman_OK
		cmpi.b	#$A,d0		; does monitor contain Static+?
		bge.s	Pow_ChkEggman_OK
		cmpi.b	#1,d0		; does monitor contain Eggman?
		bne.s	Pow_ChkSonic
Pow_ChkEggman_OK:
		tst.b	(v_invinc).w	; is Sonic invincible?
		bne.s	locret_Pow_ChkEggman_OK
		jsr	(HurtSonic).l ; try to hurt Sonic
locret_Pow_ChkEggman_OK:
		rts
; ===========================================================================
Pow_ChkSonic:
		cmpi.b	#2,d0		; does monitor contain Sonic?
		bne.s	Pow_ChkShoes
	ExtraLife:
		cmpi.b	#$63,(v_lives).w	; are lives at max?
		beq.s	@playbgm
		addq.b	#1,(v_lives).w	; add 1 to number of lives
		addq.b	#1,(f_lifecount).w ; update the lives counter
	@playbgm:
		music	bgm_ExtraLife	; play extra life music
		rts
; ===========================================================================

Pow_ChkShoes:
		cmpi.b	#3,d0		; does monitor contain speed shoes?
		bne.s	Pow_ChkShield

		move.b	#1,(v_shoes).w	; speed up the BG music
		move.w	#$4B0,(v_player+$34).w	; time limit for the power-up
		move.w	#$C00,(v_sonspeedmax).w ; change Sonic's top speed
		move.w	#$18,(v_sonspeedacc).w	; change Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w	; change Sonic's deceleration
	;Mercury Speed Shoes Work Underwater
		btst	#6,(v_player+obStatus).w	; is Sonic underwater?	;Mercury Constants
		beq.s	@isdry		; if not, branch
		move.w	#$600,(v_sonspeedmax).w ; change Sonic's top speed
		move.w	#$C,(v_sonspeedacc).w	; change Sonic's acceleration
		move.w	#$40,(v_sonspeeddec).w	; change Sonic's deceleration
	@isdry:
	;end Speed Shoes Work Underwater
		music	bgm_Speedup		; Speed	up the music
		rts
; ===========================================================================

Pow_ChkShield:
		cmpi.b	#4,d0		; does monitor contain a shield?
		bne.s	Pow_ChkInvinc

		move.b	#1,(v_shield).w	; give Sonic a shield
		move.b	#id_ShieldItem,(v_objspace+$180).w ; load shield object ($38)
		sfx	sfx_Shield,1,0,0	; play shield sound
; ===========================================================================

Pow_ChkInvinc:
		cmpi.b	#5,d0		; does monitor contain invincibility?
		beq.s	Pow_ChkInvinc_OK
		cmpi.b	#7,d0		; does monitor contain S?
		bne.s	Pow_ChkRings
Pow_ChkInvinc_OK:
		move.b	#1,(v_invinc).w	; make Sonic invincible
		move.w	#$4B0,(v_player+$32).w ; time limit for the invincibility power-up
		move.w	#$4B0,(v_player+$34).w ; time limit for the shoes power-up
		move.w	#$C00,(v_sonspeedmax).w ; change Sonic's top speed
		move.w	#$18,(v_sonspeedacc).w	; change Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w	; change Sonic's deceleration
		move.b	#id_ShieldItem,(v_objspace+$200).w ; load stars object ($3801)
		move.b	#1,(v_objspace+$200+obAnim).w
		move.b	#id_ShieldItem,(v_objspace+$240).w ; load stars object ($3802)
		move.b	#2,(v_objspace+$240+obAnim).w
		move.b	#id_ShieldItem,(v_objspace+$280).w ; load stars object ($3803)
		move.b	#3,(v_objspace+$280+obAnim).w
		move.b	#id_ShieldItem,(v_objspace+$2C0).w ; load stars object ($3804)
		move.b	#4,(v_objspace+$2C0+obAnim).w
		tst.b	(f_lockscreen).w ; is boss mode on?
		bne.s	locret_Pow_ChkInvinc_OK	; if yes, branch
		cmpi.w	#$C,(v_air).w
		bls.s	locret_Pow_ChkInvinc_OK
		music	bgm_Invincible	; play invincibility music
		rts
locret_Pow_ChkInvinc_OK:
		rts

; ===========================================================================

Pow_ChkRings:
		cmpi.b	#6,d0		; does monitor contain 10 rings?
		bne.s	Pow_ChkEnd

		addi.w	#10,(v_rings).w	; add 10 rings to the number of rings you have
		ori.b	#1,(f_ringcount).w ; update the ring counter
		cmpi.w	#100,(v_rings).w ; check if you have 100 rings
		bcs.s	Pow_RingSound
		bset	#1,(v_lifecount).w
		beq.w	ExtraLife
		cmpi.w	#200,(v_rings).w ; check if you have 200 rings
		bcs.s	Pow_RingSound
		bset	#2,(v_lifecount).w
		beq.w	ExtraLife

	Pow_RingSound:
		sfx	sfx_Ring,1,0,0	; play ring sound
; ===========================================================================

Pow_ChkEnd:
		rts ; others do nothing!
; ===========================================================================

Pow_Delete:	; Routine 4
		subq.w	#1,obTimeFrame(a0)
		bmi.w	DeleteObject	; delete after half a second
		rts