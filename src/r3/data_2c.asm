; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R32C)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r32c_e_1.bin"

StageChunks:
	incbin	"src/maps/r3/chunks_2c.bin"
	even

MetalPlatformGfx:
	incbin	"src/gfx/r3/metal_platform.nem"
	even

SpikesHV4Gfx:
	incbin	"src/gfx/spikes_hv4.nem"
	even

BlockGfx:
	incbin	"src/gfx/r3/block.nem"
	even

RetractBlockGfx:
	incbin	"src/gfx/r3/retract_block.nem"
	even

OneWayBarrierGfx:
	incbin	"src/gfx/r3/one_way_barrier.nem"
	even

FireShootGfx:
	incbin	"src/gfx/r3/fire_shoot.nem"
	even

RotatePlatformGfx:
	incbin	"src/gfx/r3/rotate_platform.nem"
	even

KamaKamaGfx:
	incbin	"src/gfx/r3/kama_kama.nem"
	even

SpikesV2Gfx:
	incbin	"src/gfx/spikes_v2.nem"
	even

KamaKamaSprites1:
	include	"src/sprites/r3/kama_kama_1.asm"
	even

KamaKamaSprites2:
	include	"src/sprites/r3/kama_kama_2.asm"

Padding2:
	incbin	"padding/r32c_e_2.bin"

PlayerGfx:
	incbin	"src/gfx/player.unc"
	even

PlayerSprites:
	include	"src/sprites/player.asm"
	even

PlayerGfxScript:
	include	"src/sprites/player_gfx.asm"
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

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r3/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r3/flower.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r3/title_card_text.nem"
	even

byte_233A9A:
	incbin	"src/data/r3/byte_233A9A_2c.bin"
	even

byte_233F1A:
	incbin	"src/data/r3/byte_233F1A_2c.bin"
	even

byte_23405A:
	incbin	"src/data/r3/byte_23405A_2c.bin"
	even

byte_23415A:
	incbin	"src/data/r3/byte_23415A_2c.bin"
	even

byte_23429A:
	incbin	"src/data/r3/byte_23429A_2c.bin"
	even

FlipperGfx:
	incbin	"src/gfx/r3/flipper.nem"
	even

BumperGfx:
	incbin	"src/gfx/r3/bumper.nem"
	even

GaGfx:
	incbin	"src/gfx/r3/ga.nem"
	even

TentouGfx:
	incbin	"src/gfx/r3/tentou.nem"
	even

SpikeBombGfx:
	incbin	"src/gfx/spike_bomb.nem"
	even

TeleporterGfx:
	incbin	"src/gfx/r3/teleporter.nem"
	even

PocketGfxBC:
	incbin	"src/gfx/r3/pocket_bc.nem"
	even

BossBarrierGfx2:
	incbin	"src/gfx/r3/boss_barrier.nem"
	even

BossDrainBlockGfxC:
	incbin	"src/gfx/r3/boss_drain_block_c.nem"
	even

BouncePlatformGfxC:
	incbin	"src/gfx/r3/bounce_platform_c.nem"
	even

GlassBreakGfxC:
	incbin	"src/gfx/r3/glass_break_c.nem"
	even

SpikeChainGfx:
	incbin	"src/gfx/spike_chain.nem"
	even

BossBarrierGfx:
	incbin	"src/gfx/r3/boss_barrier.nem"
	even

EggmanGfx:
	incbin	"src/gfx/r3/eggman.nem"
	even

EggmanEscapeGfx:
	incbin	"src/gfx/r3/eggman_escape.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r3/animals.nem"
	even

BossBombLaunchGfx:
	incbin	"src/gfx/r3/boss_bomb_launch.nem"
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
	incbin	"src/maps/r3/collision_2c.bin"
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
	incbin	"src/maps/r3/foreground_2c.bin"
	even

StageMapBg:
	incbin	"src/maps/r3/background_2c.bin"
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
	incbin	"src/maps/r3/blocks_2c.nem"
	even

StageGfx:
	incbin	"src/maps/r3/gfx_2c.nem"
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

Padding3:
	incbin	"padding/r32c_e_3.bin"

; ------------------------------------------------------------------------------
