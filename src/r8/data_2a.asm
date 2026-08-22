; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R82A)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r82a_e_1.bin"

StageChunks:
	incbin	"src/maps/r8/chunks_2a.bin"
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
	incbin	"src/data/r8/byte_2345CA.bin"
	even

byte_21E096:
	incbin	"src/data/r8/byte_2346CA.bin"
	even

byte_21E196:
	incbin	"src/data/r8/byte_2347CA.bin"
	even

byte_21E296:
	incbin	"src/data/r8/byte_2348CA.bin"
	even

byte_21E396:
	incbin	"src/data/r8/byte_2349CA.bin"
	even

byte_21E496:
	incbin	"src/data/r8/byte_234ACA.bin"
	even

byte_21E596:
	incbin	"src/data/r8/byte_234BCA.bin"
	even

byte_21E696:
	incbin	"src/data/r8/byte_234CCA.bin"
	even

byte_21E896:
	incbin	"src/data/r8/byte_234ECA.bin"
	even

byte_21EA96:
	incbin	"src/data/r8/byte_2350CA.bin"
	even

byte_21EC96:
	incbin	"src/data/r8/byte_2352CA_a.bin"
	even

byte_2354CA:
	incbin	"src/data/r8/byte_2354CA_a.bin"
	even

byte_2356CA:
	incbin	"src/data/r8/byte_2356CA_a.bin"
	even

byte_2358CA:
	incbin	"src/data/r8/byte_2358CA_a.bin"
	even

byte_235ACA:
	incbin	"src/data/r8/byte_235ACA_a.bin"
	even

byte_21F696:
	incbin	"src/data/r8/byte_235CCA.bin"
	even

byte_21F716:
	incbin	"src/data/r8/byte_235D4A.bin"
	even

byte_21F796:
	incbin	"src/data/r8/byte_235DCA.bin"
	even

byte_21F816:
	incbin	"src/data/r8/byte_235E4A.bin"
	even

byte_21F896:
	incbin	"src/data/r8/byte_235ECA.bin"
	even

byte_21F916:
	incbin	"src/data/r8/byte_235F4A.bin"
	even

byte_21F996:
	incbin	"src/data/r8/byte_21FD96.bin"
	even

byte_21FA16:
	incbin	"src/data/r8/byte_21FA16.bin"
	even

byte_21FA96:
	incbin	"src/data/r8/byte_21FA96.bin"
	even

byte_21FB16:
	incbin	"src/data/r8/byte_21FB16.bin"
	even

byte_21FB96:
	incbin	"src/data/r8/byte_21FB96.bin"
	even

byte_21FC16:
	incbin	"src/data/r8/byte_21FC16.bin"
	even

byte_21FC96:
	incbin	"src/data/r8/byte_21FC96.bin"

Padding2:
	incbin	"padding/r82a_e_2.bin"

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
	incbin	"src/maps/r8/collision_2a.bin"
	even

StageMaps:
	dc.w	StageMapFg-*
	dc.w	StageMapBg-StageMaps

StageMapFg:
	incbin	"src/maps/r8/foreground_2a.bin"
	even

StageMapBg:
	incbin	"src/maps/r8/background_2a.bin"
	even

StageBlocks:
	incbin	"src/maps/r8/blocks_2a.nem"
	even

StageGfx:
	incbin	"src/maps/r8/gfx_2a.nem"
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

RevolveDoorGfx:
	incbin	"src/gfx/r8/revolve_door.nem"

Padding3:
	incbin	"padding/r82a_e_3.bin"

; ------------------------------------------------------------------------------
