; ------------------------------------------------------------------------------

CollapseLedgeSprites:
	include	"src/sprites/r1/collapse_ledge_1b.asm"
	even

CollapseLedgeData:
	dc.w	@CollapseLedgeData_0-CollapseLedgeData
	dc.w	@CollapseLedgeData_2-CollapseLedgeData

@CollapseLedgeData_0:
	dc.b	4
	dc.b	3
	dc.b	$FF
	dc.b	$FF
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	4
	dc.b	0
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6

@CollapseLedgeData_2:
	dc.b	3
	dc.b	2
	dc.b	1
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	5
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6

CollapseLedgeSprites2:
	include	"src/sprites/r1/collapse_ledge_pieces.asm"
	even

CollapseFloorSprites:
	include	"src/sprites/r1/collapse_floor_1b.asm"
	even

CollapseFloorData:
	dc.w	@CollapseFloorData_0-CollapseFloorData
	dc.w	@CollapseFloorData_0-CollapseFloorData
	dc.w	@CollapseFloorData_4-CollapseFloorData
	dc.w	@CollapseFloorData_6-CollapseFloorData
	dc.w	@CollapseFloorData_8-CollapseFloorData
	dc.w	@CollapseFloorData_A-CollapseFloorData

@CollapseFloorData_0:
	dc.b	5
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

@CollapseFloorData_4:
	dc.b	8
	dc.b	3
	dc.b	1
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	2

@CollapseFloorData_6:
	dc.b	4
	dc.b	2
	dc.b	4
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6

@CollapseFloorData_8:
	dc.b	4
	dc.b	2
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	6
	dc.b	5

@CollapseFloorData_A:
	dc.b	9
	dc.b	3
	dc.b	1
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	2
	dc.b	0

CollapseFloorSprites2:
	include	"src/sprites/r1/collapse_floor_pieces_1b.asm"
	even

; ------------------------------------------------------------------------------
