; ------------------------------------------------------------------------------

CollapseLedgeSprites:
	include	"src/sprites/r1/collapse_ledge.asm"
	even

CollapseLedgeData:
	dc.w	@CollapseLedgeData_0-CollapseLedgeData

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

CollapseLedgeSprites2:
	include	"src/sprites/r1/collapse_ledge_pieces.asm"
	even

CollapseFloorSprites:
	include	"src/sprites/r1/collapse_floor_1cd.asm"
	even

CollapseFloorData:
	dc.w	@CollapseFloorData_0-CollapseFloorData
	dc.w	@CollapseFloorData_0-CollapseFloorData

@CollapseFloorData_0:
	dc.b	5
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

CollapseFloorSprites2:
	include	"src/sprites/r1/collapse_floor_pieces_1cd.asm"
	even

; ------------------------------------------------------------------------------
