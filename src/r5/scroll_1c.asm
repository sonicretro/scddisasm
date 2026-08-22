; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_20296E
	lea	player_object_2,a6

locret_20296E:
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
	lea	unk_2029CC,a0
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
	bra.w	loc_2029F8

; ------------------------------------------------------------------------------

unk_2029CC:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2A
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$10
	dc.b	0
	dc.b	$60

unk_2029D8:
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

loc_2029F8:
	tst.b	spawn_mode
	beq.s	loc_202A18
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	obj.x(a6),d1
	move.w	obj.y(a6),d0
	bpl.s	loc_202A16
	moveq	#0,d0

loc_202A16:
	bra.s	loc_202A54

; ------------------------------------------------------------------------------

loc_202A18:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202A3A
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_2029D8,a1
	adda.w	d0,a1
	bra.s	loc_202A44

; ------------------------------------------------------------------------------

loc_202A3A:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202A44:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202A54:
	subi.w	#$A0,d1
	bcc.s	loc_202A5C
	moveq	#0,d1

loc_202A5C:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202A66
	move.w	d2,d1

loc_202A66:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202A72
	moveq	#0,d0

loc_202A72:
	cmp.w	bottom_bound,d0
	blt.s	loc_202A7C
	move.w	bottom_bound,d0

loc_202A7C:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202A98
	lea	unk_202A94,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_1c.bin"
	even

unk_202A94:
	dc.b	$7F
	dc.b	$7F
	dc.b	$62
	dc.b	$18

; ------------------------------------------------------------------------------

sub_202A98:
	swap	d0
	lsr.l	#2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.w	d1,scroll_bg_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#2,d1
	move.l	d1,d2
	add.l	d2,d2
	add.l	d2,d1
	move.w	d1,scroll_bg3_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202AD0
	rts

; ------------------------------------------------------------------------------

loc_202AD0:
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
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
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
	btst	#0,r5_bg_change
	beq.w	loc_202B8A
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$D,d6

loc_202B7C:
	move.w	d0,(a1)+
	dbf	d6,loc_202B7C
	bsr.w	sub_202BE0
	bra.w	loc_202BC2

; ------------------------------------------------------------------------------

loc_202B8A:
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#9,d6

loc_202B92:
	move.w	d0,(a1)+
	dbf	d6,loc_202B92
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$15,d6

loc_202BA0:
	move.w	d0,(a1)+
	dbf	d6,loc_202BA0
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202BAE:
	move.w	d0,(a1)+
	dbf	d6,loc_202BAE
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202BBC:
	move.w	d0,(a1)+
	dbf	d6,loc_202BBC

loc_202BC2:
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202C20

; ------------------------------------------------------------------------------

sub_202BE0:
	move.w	scroll_bg2_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg2_x,d3
	moveq	#2,d6

loc_202C00:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202C1C(pc,d6.w),d5

loc_202C0A:
	move.w	d0,(a1)+
	dbf	d5,loc_202C0A
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202C00
	rts

; ------------------------------------------------------------------------------

byte_202C1C:
	dc.b	$27
	dc.b	3
	dc.b	9
	dc.b	0

; ------------------------------------------------------------------------------

loc_202C20:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202C2E(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202C2C:
	move.w	(a2)+,d0

loc_202C2E:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202C2C
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202C76
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202C70
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202C70:
	bset	#3,scroll_flags_fg

locret_202C76:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202C8A
	bcs.s	loc_202CBA
	bra.s	loc_202C90

; ------------------------------------------------------------------------------

loc_202C8A:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C90:
	cmpi.w	#$10,d0
	blt.s	loc_202C9A
	move.w	#$10,d0

loc_202C9A:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202CA8
	move.w	right_bound,d0

loc_202CA8:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202CBA:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202CC4
	move.w	#$FFF0,d0

loc_202CC4:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202CA8
	move.w	left_bound,d0
	bra.s	loc_202CA8

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202CDE
	move.w	#$FFFE,d0
	bra.s	loc_202CBA

; ------------------------------------------------------------------------------

loc_202CDE:
	move.w	#2,d0
	bra.s	loc_202C90

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202CF8
	subq.w	#5,d0

loc_202CF8:
	btst	#1,$22(a6)
	beq.s	loc_202D18
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202D64
	subi.w	#$40,d0
	bcc.s	loc_202D64
	tst.b	bottom_bound_shift
	bne.s	loc_202D76
	bra.s	loc_202D24

; ------------------------------------------------------------------------------

loc_202D18:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202D2A
	tst.b	bottom_bound_shift
	bne.s	loc_202D76

loc_202D24:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202D2A:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202D52
	move.w	$14(a6),d1
	bpl.s	loc_202D3A
	neg.w	d1

loc_202D3A:
	cmpi.w	#$800,d1
	bcc.s	loc_202D64
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202DC4
	cmpi.w	#$FFFA,d0
	blt.s	loc_202D8E
	bra.s	loc_202D7C

; ------------------------------------------------------------------------------

loc_202D52:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202DC4
	cmpi.w	#$FFFE,d0
	blt.s	loc_202D8E
	bra.s	loc_202D7C

; ------------------------------------------------------------------------------

loc_202D64:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202DC4
	cmpi.w	#$FFF0,d0
	blt.s	loc_202D8E
	bra.s	loc_202D7C

; ------------------------------------------------------------------------------

loc_202D76:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202D7C:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202DCE
	bra.w	loc_202D9A

; ------------------------------------------------------------------------------

loc_202D8E:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D9A:
	cmp.w	top_bound,d1
	bgt.s	loc_202DF2
	cmpi.w	#$FF00,d1
	bgt.s	loc_202DBE
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202DF2

; ------------------------------------------------------------------------------

loc_202DBE:
	move.w	top_bound,d1
	bra.s	loc_202DF2

; ------------------------------------------------------------------------------

loc_202DC4:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202DCE:
	cmp.w	bottom_bound,d1
	blt.s	loc_202DF2
	subi.w	#$800,d1
	bcs.s	loc_202DEE
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202DF2

; ------------------------------------------------------------------------------

loc_202DEE:
	move.w	bottom_bound,d1

loc_202DF2:
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
	bne.s	locret_202E34
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202E2E
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202E2E:
	bset	#1,scroll_flags_fg

locret_202E34:
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
	bne.s	loc_202E6A
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202E64
	bset	#2,scroll_flags_bg
	bra.s	loc_202E6A

; ------------------------------------------------------------------------------

loc_202E64:
	bset	#3,scroll_flags_bg

loc_202E6A:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E9E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E98
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E98:
	bset	#1,scroll_flags_bg

locret_202E9E:
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
	bne.s	locret_202ED4
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202ECE
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202ECE:
	bset	#5,scroll_flags_bg

locret_202ED4:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202F04
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202EFE
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202EFE:
	bset	#1,scroll_flags_bg

locret_202F04:
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
	bne.s	locret_202F38
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202F32
	bset	d6,scroll_flags_bg
	bra.s	locret_202F38

; ------------------------------------------------------------------------------

loc_202F32:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202F38:
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
	bne.s	locret_202F6C
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202F66
	bset	d6,scroll_flags_bg2
	bra.s	locret_202F6C

; ------------------------------------------------------------------------------

loc_202F66:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202F6C:
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
	bne.s	locret_202FA0
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202F9A
	bset	d6,scroll_flags_bg3
	bra.s	locret_202FA0

; ------------------------------------------------------------------------------

loc_202F9A:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202FA0:
	rts

; ------------------------------------------------------------------------------
