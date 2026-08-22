; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R81D)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r81d_e_1.bin"

StageChunks:
	incbin	"src/maps/r8/chunks_1d.bin"
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

byte_21E396:
	incbin	"src/data/r8/byte_2345CA.bin"
	even

byte_21E496:
	incbin	"src/data/r8/byte_2346CA.bin"
	even

byte_21E596:
	incbin	"src/data/r8/byte_2347CA.bin"
	even

byte_21E696:
	incbin	"src/data/r8/byte_2348CA.bin"
	even

byte_21E796:
	incbin	"src/data/r8/byte_2349CA.bin"
	even

byte_21E896:
	incbin	"src/data/r8/byte_234ACA.bin"
	even

byte_21E996:
	incbin	"src/data/r8/byte_234BCA.bin"
	even

byte_21EA96:
	incbin	"src/data/r8/byte_234CCA.bin"
	even

byte_21EC96:
	incbin	"src/data/r8/byte_234ECA.bin"
	even

byte_21EE96:
	incbin	"src/data/r8/byte_2350CA.bin"
	even

byte_21F096:
	incbin	"src/data/r8/byte_21F096_d.bin"
	even

byte_21FA96:
	incbin	"src/data/r8/byte_235CCA.bin"
	even

byte_21FB16:
	incbin	"src/data/r8/byte_235D4A.bin"
	even

byte_21FB96:
	incbin	"src/data/r8/byte_235DCA.bin"
	even

byte_21FC16:
	incbin	"src/data/r8/byte_235E4A.bin"
	even

byte_21FC96:
	incbin	"src/data/r8/byte_235ECA.bin"
	even

byte_21FD16:
	incbin	"src/data/r8/byte_235F4A.bin"
	even

byte_21FD96:
	incbin	"src/data/r8/byte_21FD96.bin"

Padding2:
	incbin	"padding/r81d_e_2.bin"

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

CapsuleGfx:
	incbin	"src/gfx/capsule.nem"
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
	incbin	"src/maps/r8/collision_1d.bin"
	even

StageMaps:
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
	incbin	"src/maps/r8/foreground_1d.bin"
	even

StageMapBg:
	incbin	"src/maps/r8/background_1d.bin"
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
	incbin	"src/maps/r8/blocks_1d.nem"
	even

StageGfx:
	incbin	"src/maps/r8/gfx_1d.nem"
	even

PowerupAnims:
	include	"src/anims/powerup.asm"
	even

PowerupSprites:
	include	"src/sprites/powerup.asm"
	even

SplashAnims:
	include	"src/anims/splash.asm"
	even

SplashSprites:
	include	"src/sprites/splash.asm"
	even

HDoorAnims:
	include	"src/anims/r1/h_door.asm"
	even

HDoorSprites:
	include	"src/sprites/r1/h_door.asm"
	even

TunnelSplashAnims:
	include	"src/anims/r1/tunnel_splash.asm"
	even

TunnelSplashSprites:
	include	"src/sprites/r1/tunnel_splash.asm"
	even

ExplosionAnims:
	include	"src/anims/explosion.asm"
	even

ExplosionSprites:
	include	"src/sprites/explosion.asm"
	even

WobbleTable:
	incbin	"src/data/wobble.bin"
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

CapsuleAnims:
	include	"src/anims/capsule.asm"
	even

CapsuleSprites:
	include	"src/sprites/capsule.asm"
	even

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

VanishPlatformGfx:
	incbin	"src/gfx/r8/vanish_platform.nem"
	even

PropellerGfx:
	incbin	"src/gfx/r8/propeller.nem"
	even

BuzzsawGfxABD:
	incbin	"src/gfx/r8/buzzsaw_abd.nem"
	even

BuzzsawGfxC:
	incbin	"src/gfx/r8/buzzsaw_c.nem"
	even

TrapDoorGfx:
	incbin	"src/gfx/r8/trap_door.nem"
	even

HVPlatformGfx:
	incbin	"src/gfx/r8/hv_platform.nem"
	even

SeesawGfxABD:
	incbin	"src/gfx/r8/seesaw_abd.nem"
	even

SeesawGfxC:
	incbin	"src/gfx/r8/seesaw_c.nem"
	even

RotatePlatformGfx:
	incbin	"src/gfx/r8/rotate_platform.nem"
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

PohBeeGfx:
	incbin	"src/gfx/r8/poh_bee.nem"
	even

ScarabGfx:
	incbin	"src/gfx/r8/scarab.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r8/animals.nem"
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

BuzzsawSprites:
	include	"src/sprites/r8/buzzsaw_cd.asm"
	even

RobotTransportSprites:
	include	"src/sprites/robot_transport.asm"

Padding3:
	incbin	"padding/r81d_e_3.bin"

; ------------------------------------------------------------------------------
