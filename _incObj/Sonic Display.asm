; ---------------------------------------------------------------------------
; Subroutine to display Sonic and set music
; ---------------------------------------------------------------------------

Sonic_Display:
		move.w	flashtime(a0),d0
		beq.s	@display
		subq.w	#1,flashtime(a0)
		lsr.w	#3,d0
		bcc.s	@chkinvincible

	@display:
		jsr	(DisplaySprite).l

	@chkinvincible:
		tst.b	(v_invinc).w	; does Sonic have invincibility?
		beq.s	@chkshoes	; if not, branch
		tst.w	invtime(a0)	; check	time remaining for invinciblity
		beq.s	@chkshoes	; if no	time remains, branch
		subq.w	#1,invtime(a0)	; subtract 1 from time
		bne.s	@chkshoes
		tst.b	(f_lockscreen).w
		bne.s	@removeinvincible
		cmpi.w	#$C,(v_air).w
		bcs.s	@removeinvincible
		moveq	#0,d0
		move.b	(v_zone).w,d0
		cmpi.w	#(id_LZ<<8)+3,(v_zone).w ; is level SBZ3?
		bne.s	@not_sbz3 ; if not, branch
		moveq	#5,d0		; use 5th music (SBZ)

	@not_sbz3:
		cmpi.w	#(id_SBZ<<8)+2,(v_zone).w ; is level FZ?
		bne.s	@music	; if not, branch
		moveq	#6,d0		; use 6th music (FZ)

	@music:
		lea	(MusicList).l,a1
		move.b	(a1,d0.w),d0
		jsr	(PlaySound).l	; play normal music

	@removeinvincible:
		move.b	#0,(v_invinc).w ; cancel invincibility

	@chkshoes:
		tst.b	(v_shoes).w	; does Sonic have speed	shoes?
		beq.s	@exit		; if not, branch
		tst.w	shoetime(a0)	; check	time remaining
		beq.s	@exit
		subq.w	#1,shoetime(a0)	; subtract 1 from time
		bne.s	@exit
		move.w	#$600,(v_sonspeedmax).w ; restore Sonic's speed
		move.w	#$C,(v_sonspeedacc).w ; restore Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w ; restore Sonic's deceleration
	;Mercury Speed Shoes Work Underwater
		btst	#6,obStatus(a0)	; is Sonic underwater?	;Mercury Constants
		beq.s	@isdry		; if not, branch
		move.w	#$300,(v_sonspeedmax).w ; change Sonic's top speed
		move.w	#$6,(v_sonspeedacc).w	; change Sonic's acceleration
		move.w	#$40,(v_sonspeeddec).w	; change Sonic's deceleration
	@isdry:
	;end Speed Shoes Work Underwater
		move.b	#0,(v_shoes).w	; cancel speed shoes
		music	bgm_Slowdown	; run music at normal speed
		rts

	@exit:
		rts	