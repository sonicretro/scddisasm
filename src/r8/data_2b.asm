; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R82B)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r82b_e_1.bin"

StageChunks:
	incbin	"src/maps/r8/chunks_2b.bin"
	even

LaserAnims:
	include	"src/anims/r8/laser.asm"
	even

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r8/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r8/flower.nem"
	even

LaserGfx:
	incbin	"src/gfx/r8/laser.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r8/title_card_text.nem"
	even

byte_21DF96:
	incbin	"src/data/r8/byte_21DF96_2b.bin"
	even

byte_21FC16:
	incbin	"src/data/r8/byte_21FA16.bin"
	even

byte_21FC96:
	incbin	"src/data/r8/byte_21FA96.bin"
	even

byte_21FD16:
	incbin	"src/data/r8/byte_21FB16.bin"
	even

byte_21FD96:
	incbin	"src/data/r8/byte_21FB96.bin"
	even

byte_21FE16:
	incbin	"src/data/r8/byte_21FC16.bin"
	even

byte_21FE96:
	incbin	"src/data/r8/byte_21FE96_2b.bin"
	even

PlayerGfx:
	incbin	"src/gfx/r8/player.unc"
	even

PlayerSprites:
	include	"src/sprites/r8/player.asm"
	even

PlayerGfxScript:
	include	"src/sprites/r8/player_gfx.asm"
	even

PointsGfx:
	incbin	"src/gfx/points.nem"
	even

BigRingGfx:
	incbin	"src/gfx/big_ring.nem"
	even

GoalGfx:
	incbin	"src/gfx/goal.nem"
	even

SignpostGfx:
	incbin	"src/gfx/signpost.nem"
	even

ResultsGfx:
	incbin	"src/gfx/results.nem"
	even

TimeOverGfx:
	incbin	"src/gfx/time_over.unc"
	even

GameOverGfx:
	incbin	"src/gfx/game_over.unc"
	even

TitleCardGfx:
	incbin	"src/gfx/title_card.nem"
	even

ShieldGfx:
	incbin	"src/gfx/shield.unc"
	even

InvincibleGfx:
	incbin	"src/gfx/invincible.unc"
	even

WarpGfx:
	incbin	"src/gfx/warp.unc"
	even

Spring45Gfx:
	incbin	"src/gfx/spring_45.nem"
	even

SpringGfx:
	incbin	"src/gfx/spring.nem"
	even

MonitorTimeGfx:
	incbin	"src/gfx/monitor_time.nem"
	even

ExplosionGfx:
	incbin	"src/gfx/explosion.nem"
	even

RingGfx:
	incbin	"src/gfx/ring.nem"
	even

LivesIconsGfx:
	incbin	"src/gfx/lives_icons.unc"
	even

HudNumbersGfx:
	incbin	"src/gfx/hud_numbers.unc"
	even

HudGfx:
	incbin	"src/gfx/hud.nem"
	even

CheckpointGfx:
	incbin	"src/gfx/checkpoint.nem"
	even

RevolveDoorGfx:
	incbin	"src/gfx/r8/revolve_door.nem"
	even

BossDoorGfx:
	incbin	"src/gfx/r8/boss_door.nem"
	even

BossPanelsGfx1:
	incbin	"src/gfx/r8/boss_panels_1.nem"
	even

BossPanelsGfx2:
	incbin	"src/gfx/r8/boss_panels_2.nem"
	even

BossPanelsGfx3:
	incbin	"src/gfx/r8/boss_panels_3.nem"
	even

BossMachineGfx:
	incbin	"src/gfx/r8/boss_machine.nem"
	even

BossPanelSprites:
	dc.w	BossPanelSprites1-BossPanelSprites
	dc.w	BossPanelSprites2-BossPanelSprites
	dc.w	BossPanelSprites3-BossPanelSprites
	dc.w	BossPanelSprites4-BossPanelSprites
	dc.w	BossPanelSprites5-BossPanelSprites
	dc.w	BossPanelSprites6-BossPanelSprites

EggMobileSprites:
	include	"src/sprites/r8/eggmobile.asm"
	even

SparksSprites:
	include	"src/sprites/r8/sparks.asm"
	even

EggmanSprites:
	include	"src/sprites/r8/eggman.asm"
	even

BossPanelSprites1:
	include	"src/sprites/r8/boss_panel_1.asm"
	even

BossPanelSprites2:
	include	"src/sprites/r8/boss_panel_2.asm"
	even

BossPanelSprites3:
	include	"src/sprites/r8/boss_panel_3.asm"
	even

BossPanelSprites4:
	include	"src/sprites/r8/boss_panel_4.asm"
	even

BossPanelSprites5:
	include	"src/sprites/r8/boss_panel_5.asm"
	even

BossPanelSprites6:
	include	"src/sprites/r8/boss_panel_6.asm"
	even

AmyRoseGfx:
	incbin	"src/gfx/r8/amy_rose.nem"
	even

StageCollisionAngles:
	incbin	"src/maps/collision_angles.bin"
	even

StageCollisionColumns:
	incbin	"src/maps/collision_columns.bin"
	even

StageCollisionRows:
	incbin	"src/maps/collision_rows.bin"
	even

StageCollision:
	incbin	"src/maps/r8/collision_2b.bin"
	even

StageMaps:
	dc.w	StageMapFg-*
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps

StageMapFg:
	incbin	"src/maps/r8/foreground_2b.bin"
	even

StageMapBg:
	incbin	"src/maps/r8/background_2b.bin"
	even

StageMapNull:
	incbin	"src/maps/empty.bin"
	even

StageMapUnk1:
	incbin	"src/maps/ghz2_foreground.bin"
	even

StageMapUnk3:
	incbin	"src/maps/empty.bin"
	even

StageMapUnk4:
	incbin	"src/maps/ghz3_foreground.bin"
	even

StageMapUnk2:
	incbin	"src/maps/empty.bin"
	even

StageMapUnk5:
	incbin	"src/maps/empty.bin"
	even

StageBlocks:
	incbin	"src/maps/r8/blocks_2b.nem"
	even

StageGfx:
	incbin	"src/maps/r8/gfx_2b.nem"
	even

PowerupAnims:
	include	"src/anims/powerup.asm"
	even

PowerupSprites:
	include	"src/sprites/powerup.asm"
	even

TunnelSplashSprites:
TunnelSplashAnims:
HDoorSprites:
HDoorAnims:
SplashSprites:
SplashAnims:

ExplosionAnims:
	include	"src/anims/explosion.asm"
	even

ExplosionSprites:
	include	"src/sprites/explosion.asm"
	even

CheckpointAnims:
	include	"src/anims/checkpoint.asm"
	even

CheckpointSprites:
	include	"src/sprites/checkpoint.asm"
	even

BigRingAnims:
	include	"src/anims/big_ring.asm"
	even

BigRingSprites:
	include	"src/sprites/big_ring.asm"
	even

SignpostAnims:
	include	"src/anims/signpost.asm"
	even

SignpostSprites:
	include	"src/sprites/signpost.asm"
	even

CapsuleSprites:
CapsuleAnims:

DoorGfx:
	incbin	"src/gfx/r8/door.nem"
	even

SpikesV4Gfx:
	incbin	"src/gfx/spikes_v4.nem"
	even

CrusherGfx:
	incbin	"src/gfx/r8/crusher.nem"
	even

CollapseFloorGfx:
	incbin	"src/gfx/r8/collapse_floor.nem"
	even

BigbomGfx:
	incbin	"src/gfx/r8/bigbom.nem"
	even

TrapDoorGfx:
	incbin	"src/gfx/r8/trap_door.nem"
	even

SeesawGfxABD:
	incbin	"src/gfx/r8/seesaw_abd.nem"
	even

SeesawGfxC:
	incbin	"src/gfx/r8/seesaw_c.nem"
	even

SpikeCrusherGfx:
	incbin	"src/gfx/r8/spike_crusher.nem"
	even

TwinWalkerGfx:
	incbin	"src/gfx/r8/twin_walker.nem"
	even

SwitchGfx:
	incbin	"src/gfx/switch.nem"
	even

SpringWheelGfx:
	incbin	"src/gfx/spring_wheel.nem"
	even

MechaBuGfx:
	incbin	"src/gfx/r8/mecha_bu.nem"
	even

TubeCoverGfx:
	incbin	"src/gfx/r8/tube_cover.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r8/animals.nem"
	even

DangoGfx:
	incbin	"src/gfx/r8/dango.nem"
	even

RobotTransportGfxA:
	incbin	"src/gfx/robot_transport_a.nem"
	even

RobotTransportGfxB:
	incbin	"src/gfx/robot_transport_b.nem"
	even

SpinPlatform1Data:
	incbin	"src/data/r8/spin_platform_1.bin"
	even

RobotTransportSprites:
	include	"src/sprites/robot_transport.asm"
	even

LaserSprites:
	include	"src/sprites/r8/laser.asm"
	even
LaserSprites1		equ .Sprites1
LaserSprites2		equ .Sprites2

Padding3:
	incbin	"padding/r82b_e_3.bin"

; ------------------------------------------------------------------------------
