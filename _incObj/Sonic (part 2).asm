; ---------------------------------------------------------------------------
; Sonic	when he	gets hurt
; ---------------------------------------------------------------------------

Sonic_Hurt:	; Routine 4
		jsr	(SpeedToPos).l
		addi.w	#$30,obVelY(a0)
		btst	#6,obStatus(a0)
		beq.s	loc_1380C
		subi.w	#$20,obVelY(a0)

loc_1380C:
		bsr.w	Sonic_HurtStop
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Water
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp	(DisplaySprite).l

; ---------------------------------------------------------------------------
; Subroutine to	stop Sonic falling after he's been hurt
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HurtStop:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0
		bcs.w	KillSonic
		bsr.w	Sonic_Floor
		btst	#1,obStatus(a0)
		bne.s	locret_13860
		moveq	#0,d0
		move.w	d0,obVelY(a0)
		move.w	d0,obVelX(a0)
		move.w	d0,obInertia(a0)
		move.b	#id_Walk,obAnim(a0)
		subq.b	#2,obRoutine(a0)
		move.w	#$78,$30(a0)

locret_13860:
		rts	
; End of function Sonic_HurtStop

; ---------------------------------------------------------------------------
; Sonic	when he	dies
; ---------------------------------------------------------------------------

Sonic_Death:	; Routine 6
		move.w	(v_screenposy).w,d0
		addi.w	#$100,d0
		cmp.w	obY(a0),d0
		bge.w	@cont

		bra.s	Sonic_Death_RestartLevelOrShowOver
		; the game should really have changed obRoutine now
		; i hope

	@cont:
		jsr		(ObjectFall).l
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp		(DisplaySprite).l

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

Sonic_Death_RestartLevelOrShowOver:
		move.w	#-$38,obVelY(a0)
		clr.b	(f_timecount).w		; stop time counter
		move.w	#60,flashtime(a0)	; set time delay to 1 second
		addq.b	#2,obRoutine(a0)

		cmpi.b	#0,(v_lives).w	; are lives at min?
		beq.s	@actuallydead	; then we *are* dead
		addq.b	#1,(f_lifecount).w ; update lives counter
		subq.b	#1,(v_lives).w	; subtract 1 from number of lives
		beq.s	@actuallydead	; if 0, then we are dead

		tst.b	(f_timeover).w	; is time over flag set?
		beq.s	@locret			; exit if not
		bra.s	@cont
	@actuallydead:
		clr.b	(f_timeover).w
	@cont:

		addq.b	#4,obRoutine(a0)

		move.b	#id_GameOverCard,(v_objspace+$80).w ; load GAME object
		move.b	#id_GameOverCard,(v_objspace+$C0).w ; load OVER object

		tst.b	(f_timeover).w		; is TIME OVER flag set?
		beq.s	@gameover			; if no, branch

		; Show TIME OVER
		move.b	#2,(v_objspace+$80+obFrame).w
		move.b	#3,(v_objspace+$C0+obFrame).w
		music	bgm_Fade
		bra.s	@loadplc

@gameover:
		move.b	#1,(v_objspace+$C0+obFrame).w ; set OVER object to correct frame
		music	bgm_GameOver	; play game over music

@loadplc:
		move.w	#3,d0
		jmp	AddPLC	; load game over patterns

@locret:
		rts	
; End of function GameOver

; ---------------------------------------------------------------------------
; Sonic	when the level is restarted
; ---------------------------------------------------------------------------

Sonic_OverReset:	; Routine 8
		tst.w	flashtime(a0)
		beq.s	Sonic_Empty
		subq.w	#1,flashtime(a0)	; subtract 1 from time delay
		bne.s	Sonic_Empty
		move.w	#1,(f_restart).w ; restart the level

Sonic_Empty:	; Routine 12
		rts	