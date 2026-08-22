; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2026D4
	lea	player_object_2,a6

locret_2026D4:
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
	lea	unk_202732,a0
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
	bra.w	loc_20275E

; ------------------------------------------------------------------------------

unk_202732:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2E
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	5
	dc.b	$10
	dc.b	0
	dc.b	$60

unk_20273E:
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

loc_20275E:
	tst.b	spawn_mode
	beq.s	loc_20277E
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc2_20277C
	moveq	#0,d0

loc2_20277C:
	bra.s	loc_2027BA

; ------------------------------------------------------------------------------

loc_20277E:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_2027A0
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_20273E,a1
	adda.w	d0,a1
	bra.s	loc_2027AA

; ------------------------------------------------------------------------------

loc_2027A0:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_2027AA:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2027BA:
	subi.w	#$A0,d1
	bcc.s	loc_2027C2
	moveq	#0,d1

loc_2027C2:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2027CC
	move.w	d2,d1

loc_2027CC:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_2027D8
	moveq	#0,d0

loc_2027D8:
	cmp.w	bottom_bound,d0
	blt.s	loc_2027E2
	move.w	bottom_bound,d0

loc_2027E2:
	move.w	d0,scroll_fg_y
	bsr.w	sub_2027FE
	lea	unk_2027FA,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r3/spawn_1b.bin"
	even

unk_2027FA:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_2027FE:
	move.w	#$218,d0
	move.w	#$520,d2
	sub.w	scroll_fg_y,d2
	bcs.s	loc_202814
	lsr.w	#1,d2
	sub.w	d2,d0
	bpl.s	loc_202814
	moveq	#0,d0

loc_202814:
	move.w	d0,scroll_bg_y
	move.w	#0,scroll_bg_y+2
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#4,d1
	move.w	d1,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg2_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg_x
	moveq	#$C,d2
	lea	bg_scroll_lines,a2

loc_20284A:
	clr.l	(a2)+
	dbf	d2,loc_20284A
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_20285E
	rts

; ------------------------------------------------------------------------------

loc_20285E:
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
	asl.l	#4,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#3,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines+$34,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#2,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	#$218,d0
	move.w	#$520,d1
	sub.w	scroll_fg_y,d1
	bcs.s	loc_2028D6
	lsr.w	#1,d1
	sub.w	d1,d0
	bpl.s	loc_2028D6
	moveq	#0,d0

loc_2028D6:
	bsr.w	ScrollBgY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_lines,a2
	addi.l	#$8000,(a2)+
	addi.l	#$6000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$3000,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$1000,(a2)+
	addi.l	#$800,(a2)+
	addi.l	#$1000,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$3000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$6000,(a2)+
	addi.l	#$8000,(a2)+
	moveq	#$3F,d6
	moveq	#0,d1

loc_202956:
	move.w	d1,d2
	mulu.w	#$100,d2
	addi.l	#$8000,d2
	add.l	d2,(a2)+
	addq.b	#1,d1
	dbf	d6,loc_202956
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#5,d1
	asl.l	d1,d2
	divs.w	#$C,d2
	ext.l	d2
	moveq	#$B,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#2,d6
	lea	bg_scroll_lines+$144,a1

loc_202996:
	move.w	d3,d0
	neg.w	d0
	lea	unk_202ADA,a3
	moveq	#0,d5
	move.b	(a3,d6.w),d5

loc_2029A6:
	move.w	d0,-(a1)
	dbf	d5,loc_2029A6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202996
	lea	bg_scroll_lines+$144,a1
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_2029C2:
	move.w	d0,(a1)+
	dbf	d6,loc_2029C2
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#5,d6

loc_2029D0:
	move.w	d0,(a1)+
	dbf	d6,loc_2029D0
	lea	bg_scroll_lines,a2
	moveq	#$C,d6

loc_2029DC:
	move.l	(a2)+,d1
	swap	d1
	add.w	scroll_bg_x,d1
	neg.w	d1
	moveq	#0,d5
	lea	unk_202ACC,a3
	move.b	(a3,d6.w),d5

loc_2029F2:
	move.w	d1,(a1)+
	dbf	d5,loc_2029F2
	dbf	d6,loc_2029DC
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202A04:
	move.w	d0,(a1)+
	dbf	d6,loc_202A04
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A12:
	move.w	d0,(a1)+
	dbf	d6,loc_202A12
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202A20:
	move.w	d0,(a1)+
	dbf	d6,loc_202A20
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A2E:
	move.w	d0,(a1)+
	dbf	d6,loc_202A2E
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divs.w	#$18,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	moveq	#5,d6
	move.w	scroll_bg_x,d3

loc_202A54:
	move.w	d3,d0
	neg.w	d0
	lea	unk_202ADE,a3
	moveq	#0,d5
	move.b	(a3,d6.w),d5

loc_202A64:
	move.w	d0,(a1)+
	dbf	d5,loc_202A64
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202A54
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202A7C:
	move.w	d0,(a1)+
	dbf	d6,loc_202A7C
	lea	scroll_lines,a1
	lea	bg_scroll_lines+$134,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	move.w	d0,d4
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	move.w	d0,d3
	lsr.w	#1,d3
	moveq	#$57,d1
	moveq	#$1C,d5
	sub.w	d3,d1
	bcs.s	loc_202AC8
	cmpi.w	#$1B,d1
	bcs.s	loc_202AAC
	moveq	#$1C,d1

loc_202AAC:
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	lea	word_202AE4,a3
	lea	WobbleTable,a4
	addi.w	#$40,bg_water_deform
	bsr.w	sub_202B3A

loc_202AC8:
	bra.w	loc_202AEA

; ------------------------------------------------------------------------------

unk_202ACC:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	3
	dc.b	1
	dc.b	0

unk_202ADA:
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	0

unk_202ADE:
	dc.b	5
	dc.b	1
	dc.b	1
	dc.b	3
	dc.b	1
	dc.b	1

word_202AE4:
	dc.w	$40
	dc.w	$210
	dc.w	$7FFF

; ------------------------------------------------------------------------------

loc_202AEA:
	move.w	d5,d1
	lsl.w	#3,d1
	subq.w	#1,d1
	bmi.s	locret_202B38
	lea	bg_scroll_lines+$34,a2
	move.b	bg_water_deform,d5
	sub.w	scroll_bg_y,d4

loc_202AFE:
	move.l	(a2)+,d2
	swap	d2
	add.w	scroll_bg_x,d2
	neg.w	d2
	move.w	d2,d0
	move.w	#$5C0,d3
	sub.w	scroll_fg_y,d3
	cmp.w	d3,d4
	bcs.s	loc_202B2E
	andi.w	#$FF,d5
	move.b	(a4,d5.w),d3
	ext.w	d3
	add.w	d3,d3
	add.w	scroll_fg_x,d3
	neg.w	d3
	swap	d0
	move.w	d3,d0
	swap	d0

loc_202B2E:
	move.l	d0,(a1)+
	addq.w	#1,d4
	addq.w	#1,d5
	dbf	d1,loc_202AFE

locret_202B38:
	rts

; ------------------------------------------------------------------------------

sub_202B3A:
	cmp.w	(a3),d4
	bcc.s	loc_202B70

loc_202B3E:
	andi.w	#7,d2
	addq.w	#8,d4
	sub.w	d2,d4
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B5A(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B4E:
	tst.w	d1
	bmi.s	locret_202B6E
	cmp.w	(a3),d4
	bcc.s	loc_202B8A

loc_202B56:
	move.w	(a2)+,d0
	addq.w	#8,d4

loc_202B5A:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B4E

locret_202B6E:
	rts

; ------------------------------------------------------------------------------

loc_202B70:
	move.w	(a3)+,d3
	addi.w	#$20,d3
	sub.w	d4,d3
	bgt.s	loc_202B94
	cmp.w	(a3),d4
	bcs.s	loc_202B3E
	move.w	(a3)+,d3
	addi.w	#$20,d3
	sub.w	d4,d3
	ble.s	loc_202B3E
	bra.s	loc_202B94

; ------------------------------------------------------------------------------

loc_202B8A:
	move.w	(a3)+,d3
	addi.w	#$20,d3
	sub.w	d4,d3
	ble.s	loc_202B56

loc_202B94:
	subq.w	#1,d3
	move.w	d3,d6
	moveq	#0,d2
	move.b	bg_water_deform,d2

loc_202B9E:
	andi.w	#$FF,d2
	move.b	(a4,d2.w),d0
	ext.w	d0
	add.w	scroll_bg_x,d0
	neg.w	d0
	move.l	d0,(a1)+
	addq.w	#1,d4
	addq.w	#1,d2
	dbf	d3,loc_202B9E
	lsr.w	#3,d6

loc_202BBA:
	move.w	(a2)+,d0
	subq.w	#1,d1
	dbf	d6,loc_202BBA
	bra.s	loc_202B4E

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202BF6
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202BF0
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202BF0:
	bset	#3,scroll_flags_fg

locret_202BF6:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202C0A
	bcs.s	loc_202C3A
	bra.s	loc_202C10

; ------------------------------------------------------------------------------

loc_202C0A:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C10:
	cmpi.w	#$10,d0
	blt.s	loc_202C1A
	move.w	#$10,d0

loc_202C1A:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202C28
	move.w	right_bound,d0

loc_202C28:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C3A:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202C44
	move.w	#$FFF0,d0

loc_202C44:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202C28
	move.w	left_bound,d0
	bra.s	loc_202C28

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202C5E
	move.w	#$FFFE,d0
	bra.s	loc_202C3A

; ------------------------------------------------------------------------------

loc_202C5E:
	move.w	#2,d0
	bra.s	loc_202C10

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C78
	subq.w	#5,d0

loc_202C78:
	btst	#1,$22(a6)
	beq.s	loc_202C98
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202CE4
	subi.w	#$40,d0
	bcc.s	loc_202CE4
	tst.b	bottom_bound_shift
	bne.s	loc_202CF6
	bra.s	loc_202CA4

; ------------------------------------------------------------------------------

loc_202C98:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202CAA
	tst.b	bottom_bound_shift
	bne.s	loc_202CF6

loc_202CA4:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202CAA:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202CD2
	move.w	$14(a6),d1
	bpl.s	loc_202CBA
	neg.w	d1

loc_202CBA:
	cmpi.w	#$800,d1
	bcc.s	loc_202CE4
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202D44
	cmpi.w	#$FFFA,d0
	blt.s	loc_202D0E
	bra.s	loc_202CFC

; ------------------------------------------------------------------------------

loc_202CD2:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202D44
	cmpi.w	#$FFFE,d0
	blt.s	loc_202D0E
	bra.s	loc_202CFC

; ------------------------------------------------------------------------------

loc_202CE4:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202D44
	cmpi.w	#$FFF0,d0
	blt.s	loc_202D0E
	bra.s	loc_202CFC

; ------------------------------------------------------------------------------

loc_202CF6:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202CFC:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202D4E
	bra.w	loc_202D1A

; ------------------------------------------------------------------------------

loc_202D0E:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D1A:
	cmp.w	top_bound,d1
	bgt.s	loc_202D72
	cmpi.w	#$FF00,d1
	bgt.s	loc_202D3E
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D72

; ------------------------------------------------------------------------------

loc_202D3E:
	move.w	top_bound,d1
	bra.s	loc_202D72

; ------------------------------------------------------------------------------

loc_202D44:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D4E:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D72
	subi.w	#$800,d1
	bcs.s	loc_202D6E
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D72

; ------------------------------------------------------------------------------

loc_202D6E:
	move.w	bottom_bound,d1

loc_202D72:
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
	bne.s	locret_202DB4
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202DAE
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202DAE:
	bset	#1,scroll_flags_fg

locret_202DB4:
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
	bne.s	loc_202DEA
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DE4
	bset	#2,scroll_flags_bg
	bra.s	loc_202DEA

; ------------------------------------------------------------------------------

loc_202DE4:
	bset	#3,scroll_flags_bg

loc_202DEA:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E1E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E18
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E18:
	bset	#1,scroll_flags_bg

locret_202E1E:
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
	bne.s	locret_202E54
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E4E
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E4E:
	bset	#5,scroll_flags_bg

locret_202E54:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E84
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E7E
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E7E:
	bset	#1,scroll_flags_bg

locret_202E84:
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
	bne.s	locret_202EB8
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202EB2
	bset	d6,scroll_flags_bg
	bra.s	locret_202EB8

; ------------------------------------------------------------------------------

loc_202EB2:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202EB8:
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
	bne.s	locret_202EEC
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202EE6
	bset	d6,scroll_flags_bg2
	bra.s	locret_202EEC

; ------------------------------------------------------------------------------

loc_202EE6:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202EEC:
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
	bne.s	locret_202F20
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202F1A
	bset	d6,scroll_flags_bg3
	bra.s	locret_202F20

; ------------------------------------------------------------------------------

loc_202F1A:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202F20:
	rts

; ------------------------------------------------------------------------------
