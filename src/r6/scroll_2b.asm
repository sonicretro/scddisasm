; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2027E8
	lea	player_object_2,a6

locret_2027E8:
	rts

; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_202846,a0
	move.w	(a0)+,d0
	move.w	d0,unused_scroll_routine
	move.l	(a0)+,d0
	move.l	d0,left_bound
	move.l	d0,target_left_bound
	move.l	(a0)+,d0
	move.l	d0,top_bound
	move.l	d0,target_top_bound
	move.w	left_bound,d0
	addi.w	#$240,d0
	move.w	d0,unused_scroll_x_keep
	move.w	#$1010,scroll_cross_x
	move.w	(a0)+,d0
	move.w	d0,scroll_focus_y
	move.w	#$A0,scroll_focus_x
	bra.w	loc_202872

; ------------------------------------------------------------------------------

unk_202846:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$23
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	7
	dc.b	$10
	dc.b	0
	dc.b	$60

unk_202852:
	dc.b	0
	dc.b	$50
	dc.b	3
	dc.b	$B0
	dc.b	$E
	dc.b	$A0
	dc.b	4
	dc.b	$6C
	dc.b	$17
	dc.b	$50
	dc.b	0
	dc.b	$BD
	dc.b	$A
	dc.b	0
	dc.b	6
	dc.b	$2C
	dc.b	$B
	dc.b	$B0
	dc.b	0
	dc.b	$4C
	dc.b	$15
	dc.b	$70
	dc.b	1
	dc.b	$6C
	dc.b	1
	dc.b	$B0
	dc.b	7
	dc.b	$2C
	dc.b	$14
	dc.b	0
	dc.b	2
	dc.b	$AC

; ------------------------------------------------------------------------------

loc_202872:
	tst.b	spawn_mode
	beq.s	loc_202892
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202890
	moveq	#0,d0

loc_202890:
	bra.s	loc_2028CE

; ------------------------------------------------------------------------------

loc_202892:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_2028B4
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202852,a1
	adda.w	d0,a1
	bra.s	loc_2028BE

; ------------------------------------------------------------------------------

loc_2028B4:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_2028BE:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2028CE:
	subi.w	#$A0,d1
	bcc.s	loc_2028D6
	moveq	#0,d1

loc_2028D6:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2028E0
	move.w	d2,d1

loc_2028E0:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_2028EC
	moveq	#0,d0

loc_2028EC:
	cmp.w	bottom_bound,d0
	blt.s	loc_2028F6
	move.w	bottom_bound,d0

loc_2028F6:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202912
	lea	unk_20290E,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r6/spawn_2b.bin"
	even

unk_20290E:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202912:
	swap	d0
	lsr.l	#2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg3_x
	lsr.l	#2,d1
	move.l	d1,d2
	add.l	d2,d2
	add.l	d2,d1
	move.w	d1,scroll_bg_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_20294A
	rts

; ------------------------------------------------------------------------------

loc_20294A:
	clr.w	scroll_flags_fg
	clr.w	scroll_flags_bg
	clr.w	scroll_flags_bg2
	clr.w	scroll_flags_bg3
	bsr.w	ScrollFgX
	bsr.w	ScrollFgY
	bsr.w	StageEvents
	move.w	scroll_fg_y,scroll_y
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	scroll_fg_y,d0
	lsr.w	#2,d0
	bsr.w	ScrollBgY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_lines,a1
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	bsr.w	sub_202A78
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$D,d6

loc_2029EE:
	move.w	d0,(a1)+
	dbf	d6,loc_2029EE
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#1,d6

loc_2029FC:
	move.w	d0,(a1)+
	dbf	d6,loc_2029FC
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A0A:
	move.w	d0,(a1)+
	dbf	d6,loc_202A0A
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202A18:
	move.w	d0,(a1)+
	dbf	d6,loc_202A18
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A26:
	move.w	d0,(a1)+
	dbf	d6,loc_202A26
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202A34:
	move.w	d0,(a1)+
	dbf	d6,loc_202A34
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A42:
	move.w	d0,(a1)+
	dbf	d6,loc_202A42
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202ABC

; ------------------------------------------------------------------------------

byte_202A66:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0

; ------------------------------------------------------------------------------

sub_202A78:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$11,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#$10,d6
	adda.w	#$38,a1

loc_202A9C:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202A66(pc,d6.w),d5

loc_202AA6:
	move.w	d0,-(a1)
	dbf	d5,loc_202AA6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202A9C
	adda.w	#$38,a1
	rts

; ------------------------------------------------------------------------------

loc_202ABC:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202ACA(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202AC8:
	move.w	(a2)+,d0

loc_202ACA:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AC8
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202AE8(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202AE8:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AC8
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B30
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B2A
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B2A:
	bset	#3,scroll_flags_fg

locret_202B30:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B44
	bcs.s	loc_202B74
	bra.s	loc_202B4A

; ------------------------------------------------------------------------------

loc_202B44:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B4A:
	cmpi.w	#$10,d0
	blt.s	loc_202B54
	move.w	#$10,d0

loc_202B54:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202B62
	move.w	right_bound,d0

loc_202B62:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B74:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B7E
	move.w	#$FFF0,d0

loc_202B7E:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202B62
	move.w	left_bound,d0
	bra.s	loc_202B62

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B98
	move.w	#$FFFE,d0
	bra.s	loc_202B74

; ------------------------------------------------------------------------------

loc_202B98:
	move.w	#2,d0
	bra.s	loc_202B4A

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202BB2
	subq.w	#5,d0

loc_202BB2:
	btst	#1,$22(a6)
	beq.s	loc_202BD2
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C1E
	subi.w	#$40,d0
	bcc.s	loc_202C1E
	tst.b	bottom_bound_shift
	bne.s	loc_202C30
	bra.s	loc_202BDE

; ------------------------------------------------------------------------------

loc_202BD2:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202BE4
	tst.b	bottom_bound_shift
	bne.s	loc_202C30

loc_202BDE:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202BE4:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202C0C
	move.w	$14(a6),d1
	bpl.s	loc_202BF4
	neg.w	d1

loc_202BF4:
	cmpi.w	#$800,d1
	bcc.s	loc_202C1E
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C7E
	cmpi.w	#$FFFA,d0
	blt.s	loc_202C48
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C0C:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C7E
	cmpi.w	#$FFFE,d0
	blt.s	loc_202C48
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C1E:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C7E
	cmpi.w	#$FFF0,d0
	blt.s	loc_202C48
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C30:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C36:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C88
	bra.w	loc_202C54

; ------------------------------------------------------------------------------

loc_202C48:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C54:
	cmp.w	top_bound,d1
	bgt.s	loc_202CAC
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C78
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202CAC

; ------------------------------------------------------------------------------

loc_202C78:
	move.w	top_bound,d1
	bra.s	loc_202CAC

; ------------------------------------------------------------------------------

loc_202C7E:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C88:
	cmp.w	bottom_bound,d1
	blt.s	loc_202CAC
	subi.w	#$800,d1
	bcs.s	loc_202CA8
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202CAC

; ------------------------------------------------------------------------------

loc_202CA8:
	move.w	bottom_bound,d1

loc_202CAC:
	move.w	scroll_fg_y,d4
	swap	d1
	move.l	d1,d3
	sub.l	scroll_fg_y,d3
	ror.l	#8,d3
	move.w	d3,scroll_y_move
	move.l	d1,scroll_fg_y
	move.w	scroll_fg_y,d0
	andi.w	#$10,d0
	move.b	scroll_cross_y,d1
	eor.b	d1,d0
	bne.s	locret_202CEE
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202CE8
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202CE8:
	bset	#1,scroll_flags_fg

locret_202CEE:
	rts

; ------------------------------------------------------------------------------

ScrollBgXY:
	move.l	scroll_bg_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_x,d3
	eor.b	d3,d1
	bne.s	loc_202D24
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D1E
	bset	#2,scroll_flags_bg
	bra.s	loc_202D24

; ------------------------------------------------------------------------------

loc_202D1E:
	bset	#3,scroll_flags_bg

loc_202D24:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D58
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D52
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D52:
	bset	#1,scroll_flags_bg

locret_202D58:
	rts

; ------------------------------------------------------------------------------

UnkScrollBgY:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D8E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D88
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D88:
	bset	#5,scroll_flags_bg

locret_202D8E:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DBE
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202DB8
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DB8:
	bset	#1,scroll_flags_bg

locret_202DBE:
	rts

; ------------------------------------------------------------------------------

ScrollBgX:
	move.l	scroll_bg_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_x,d3
	eor.b	d3,d1
	bne.s	locret_202DF2
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DEC
	bset	d6,scroll_flags_bg
	bra.s	locret_202DF2

; ------------------------------------------------------------------------------

loc_202DEC:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202DF2:
	rts

; ------------------------------------------------------------------------------

ScrollBg2X:
	move.l	scroll_bg2_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg2_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg2_x,d3
	eor.b	d3,d1
	bne.s	locret_202E26
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202E20
	bset	d6,scroll_flags_bg2
	bra.s	locret_202E26

; ------------------------------------------------------------------------------

loc_202E20:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202E26:
	rts

; ------------------------------------------------------------------------------

ScrollBg3X:
	move.l	scroll_bg3_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg3_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg3_x,d3
	eor.b	d3,d1
	bne.s	locret_202E5A
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202E54
	bset	d6,scroll_flags_bg3
	bra.s	locret_202E5A

; ------------------------------------------------------------------------------

loc_202E54:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202E5A:
	rts

; ------------------------------------------------------------------------------
