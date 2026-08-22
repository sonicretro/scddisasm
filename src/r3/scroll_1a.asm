; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_20281A
	lea	player_object_2,a6

locret_20281A:
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
	lea	unk_202878,a0
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
	bra.w	loc_2028A4

; ------------------------------------------------------------------------------

unk_202878:
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

unk_202884:
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

loc_2028A4:
	tst.b	spawn_mode
	beq.s	loc_2028C4
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_2028C2
	moveq	#0,d0

loc_2028C2:
	bra.s	loc_202900

; ------------------------------------------------------------------------------

loc_2028C4:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_2028E6
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202884,a1
	adda.w	d0,a1
	bra.s	loc_2028F0

; ------------------------------------------------------------------------------

loc_2028E6:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_2028F0:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202900:
	subi.w	#$A0,d1
	bcc.s	loc_202908
	moveq	#0,d1

loc_202908:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202912
	move.w	d2,d1

loc_202912:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20291E
	moveq	#0,d0

loc_20291E:
	cmp.w	bottom_bound,d0
	blt.s	loc_202928
	move.w	bottom_bound,d0

loc_202928:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202944
	lea	unk_202940,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r3/spawn_1a.bin"
	even

unk_202940:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202944:
	move.w	#$218,d0
	move.w	#$520,d2
	sub.w	scroll_fg_y,d2
	bcs.s	loc_20295A
	lsr.w	#1,d2
	sub.w	d2,d0
	bpl.s	loc_20295A
	moveq	#0,d0

loc_20295A:
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
	lea	bg_scroll_lines,a2
	moveq	#$E,d2

loc_202990:
	clr.l	(a2)+
	dbf	d2,loc_202990
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_2029A4
	rts

; ------------------------------------------------------------------------------

loc_2029A4:
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
	lea	bg_scroll_lines+$3C,a1
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
	bcs.s	loc_202A1C
	lsr.w	#1,d1
	sub.w	d1,d0
	bpl.s	loc_202A1C
	moveq	#0,d0

loc_202A1C:
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
	addi.l	#$C000,(a2)+
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
	addi.l	#$C000,(a2)+
	moveq	#$3F,d6
	moveq	#0,d1

loc_202AA8:
	move.w	d1,d2
	mulu.w	#$400,d2
	addi.l	#$8000,d2
	add.l	d2,(a2)+
	addq.b	#1,d1
	dbf	d6,loc_202AA8
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divs.w	#$1C,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#6,d6
	lea	bg_scroll_lines+$14A,a1

loc_202AE8:
	move.w	d3,d0
	neg.w	d0
	move.w	d0,-(a1)
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202AE8
	lea	bg_scroll_lines+$14A,a1
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#2,d6

loc_202B04:
	move.w	d0,(a1)+
	dbf	d6,loc_202B04
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202B12:
	move.w	d0,(a1)+
	dbf	d6,loc_202B12
	lea	bg_scroll_lines,a2
	moveq	#$E,d6

loc_202B1E:
	move.l	(a2)+,d1
	swap	d1
	add.w	scroll_bg_x,d1
	neg.w	d1
	moveq	#0,d5
	lea	unk_202BFE,a3
	move.b	(a3,d6.w),d5

loc_202B34:
	move.w	d1,(a1)+
	dbf	d5,loc_202B34
	dbf	d6,loc_202B1E
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#5,d6

loc_202B46:
	move.w	d0,(a1)+
	dbf	d6,loc_202B46
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202B54:
	move.w	d0,(a1)+
	dbf	d6,loc_202B54
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202B62:
	move.w	d0,(a1)+
	dbf	d6,loc_202B62
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202B70:
	move.w	d0,(a1)+
	dbf	d6,loc_202B70
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divs.w	#$28,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	moveq	#9,d6
	move.w	scroll_bg_x,d3

loc_202B96:
	move.w	d3,d0
	neg.w	d0
	move.w	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202B96
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202BAE:
	move.w	d0,(a1)+
	dbf	d6,loc_202BAE
	lea	scroll_lines,a1
	lea	bg_scroll_lines+$13C,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	move.w	d0,d4
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	move.w	d0,d3
	lsr.w	#1,d3
	moveq	#$57,d1
	moveq	#$1D,d5
	sub.w	d3,d1
	bcs.s	loc_202BFA
	cmpi.w	#$1B,d1
	bcs.s	loc_202BDE
	moveq	#$1C,d1

loc_202BDE:
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	lea	word_202C0E,a3
	lea	WobbleTable,a4
	addi.w	#$40,bg_water_deform
	bsr.w	sub_202C64

loc_202BFA:
	bra.w	loc_202C14

; ------------------------------------------------------------------------------

unk_202BFE:
	dc.b	1
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	3
	dc.b	1
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	1
	dc.b	0

word_202C0E:
	dc.w	$38
	dc.w	$250
	dc.w	$7FFF

; ------------------------------------------------------------------------------

loc_202C14:
	move.w	d5,d1
	lsl.w	#3,d1
	subq.w	#1,d1
	lea	bg_scroll_lines+$3C,a2
	move.b	bg_water_deform,d5
	sub.w	scroll_bg_y,d4

loc_202C26:
	move.l	(a2)+,d2
	swap	d2
	add.w	scroll_bg_x,d2
	neg.w	d2
	move.w	d2,d0
	move.w	#$5C0,d3
	sub.w	scroll_fg_y,d3
	cmp.w	d3,d4
	bcs.s	loc_202C58
	andi.w	#$7F,d5
	move.w	d5,d6
	add.w	d6,d6
	move.b	(a4,d6.w),d3
	ext.w	d3
	add.w	scroll_fg_x,d3
	neg.w	d3
	swap	d0
	move.w	d3,d0
	swap	d0

loc_202C58:
	move.l	d0,(a1)+
	addq.w	#1,d4
	addq.w	#1,d5
	dbf	d1,loc_202C26
	rts

; ------------------------------------------------------------------------------

sub_202C64:
	cmp.w	(a3),d4
	bcc.s	loc_202C9A

loc_202C68:
	andi.w	#7,d2
	addq.w	#8,d4
	sub.w	d2,d4
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202C84(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202C78:
	tst.w	d1
	bmi.s	locret_202C98
	cmp.w	(a3),d4
	bcc.s	loc_202CB4

loc_202C80:
	move.w	(a2)+,d0
	addq.w	#8,d4

loc_202C84:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202C78

locret_202C98:
	rts

; ------------------------------------------------------------------------------

loc_202C9A:
	move.w	(a3)+,d3
	addi.w	#$18,d3
	sub.w	d4,d3
	bgt.s	loc_202CBE
	cmp.w	(a3),d4
	bcs.s	loc_202C68
	move.w	(a3)+,d3
	addi.w	#$18,d3
	sub.w	d4,d3
	ble.s	loc_202C68
	bra.s	loc_202CBE

; ------------------------------------------------------------------------------

loc_202CB4:
	move.w	(a3)+,d3
	addi.w	#$18,d3
	sub.w	d4,d3
	ble.s	loc_202C80

loc_202CBE:
	subq.w	#1,d3
	move.w	d3,d6
	moveq	#0,d2
	move.b	bg_water_deform,d2

loc_202CC8:
	andi.w	#$FF,d2
	move.b	(a4,d2.w),d0
	ext.w	d0
	add.w	scroll_bg_x,d0
	neg.w	d0
	move.l	d0,(a1)+
	addq.w	#1,d4
	addq.w	#1,d2
	dbf	d3,loc_202CC8
	lsr.w	#3,d6

loc_202CE4:
	move.w	(a2)+,d0
	subq.w	#1,d1
	dbf	d6,loc_202CE4
	bra.s	loc_202C78

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202D20
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202D1A
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D1A:
	bset	#3,scroll_flags_fg

locret_202D20:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202D34
	bcs.s	loc_202D64
	bra.s	loc_202D3A

; ------------------------------------------------------------------------------

loc_202D34:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D3A:
	cmpi.w	#$10,d0
	blt.s	loc_202D44
	move.w	#$10,d0

loc_202D44:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202D52
	move.w	right_bound,d0

loc_202D52:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D64:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202D6E
	move.w	#$FFF0,d0

loc_202D6E:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202D52
	move.w	left_bound,d0
	bra.s	loc_202D52

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202D88
	move.w	#$FFFE,d0
	bra.s	loc_202D64

; ------------------------------------------------------------------------------

loc_202D88:
	move.w	#2,d0
	bra.s	loc_202D3A

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202DA2
	subq.w	#5,d0

loc_202DA2:
	btst	#1,$22(a6)
	beq.s	loc_202DC2
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202E0E
	subi.w	#$40,d0
	bcc.s	loc_202E0E
	tst.b	bottom_bound_shift
	bne.s	loc_202E20
	bra.s	loc_202DCE

; ------------------------------------------------------------------------------

loc_202DC2:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202DD4
	tst.b	bottom_bound_shift
	bne.s	loc_202E20

loc_202DCE:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202DD4:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202DFC
	move.w	$14(a6),d1
	bpl.s	loc_202DE4
	neg.w	d1

loc_202DE4:
	cmpi.w	#$800,d1
	bcc.s	loc_202E0E
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202E6E
	cmpi.w	#$FFFA,d0
	blt.s	loc_202E38
	bra.s	loc_202E26

; ------------------------------------------------------------------------------

loc_202DFC:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202E6E
	cmpi.w	#$FFFE,d0
	blt.s	loc_202E38
	bra.s	loc_202E26

; ------------------------------------------------------------------------------

loc_202E0E:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202E6E
	cmpi.w	#$FFF0,d0
	blt.s	loc_202E38
	bra.s	loc_202E26

; ------------------------------------------------------------------------------

loc_202E20:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202E26:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202E78
	bra.w	loc_202E44

; ------------------------------------------------------------------------------

loc_202E38:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202E44:
	cmp.w	top_bound,d1
	bgt.s	loc_202E9C
	cmpi.w	#$FF00,d1
	bgt.s	loc_202E68
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202E9C

; ------------------------------------------------------------------------------

loc_202E68:
	move.w	top_bound,d1
	bra.s	loc_202E9C

; ------------------------------------------------------------------------------

loc_202E6E:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202E78:
	cmp.w	bottom_bound,d1
	blt.s	loc_202E9C
	subi.w	#$800,d1
	bcs.s	loc_202E98
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202E9C

; ------------------------------------------------------------------------------

loc_202E98:
	move.w	bottom_bound,d1

loc_202E9C:
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
	bne.s	locret_202EDE
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202ED8
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202ED8:
	bset	#1,scroll_flags_fg

locret_202EDE:
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
	bne.s	loc_202F14
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202F0E
	bset	#2,scroll_flags_bg
	bra.s	loc_202F14

; ------------------------------------------------------------------------------

loc_202F0E:
	bset	#3,scroll_flags_bg

loc_202F14:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202F48
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202F42
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202F42:
	bset	#1,scroll_flags_bg

locret_202F48:
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
	bne.s	locret_202F7E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202F78
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202F78:
	bset	#5,scroll_flags_bg

locret_202F7E:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202FAE
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202FA8
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FA8:
	bset	#1,scroll_flags_bg

locret_202FAE:
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
	bne.s	locret_202FE2
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202FDC
	bset	d6,scroll_flags_bg
	bra.s	locret_202FE2

; ------------------------------------------------------------------------------

loc_202FDC:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202FE2:
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
	bne.s	locret_203016
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_203010
	bset	d6,scroll_flags_bg2
	bra.s	locret_203016

; ------------------------------------------------------------------------------

loc_203010:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_203016:
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
	bne.s	locret_20304A
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203044
	bset	d6,scroll_flags_bg3
	bra.s	locret_20304A

; ------------------------------------------------------------------------------

loc_203044:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_20304A:
	rts

; ------------------------------------------------------------------------------
