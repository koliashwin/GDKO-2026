extends Node2D

@onready var player_sprite : AnimatedSprite2D = $PlayerSprite
@onready var weapon_sprite : AnimatedSprite2D = $WeaponSprite
@onready var player: CharacterBody2D = $".."
@onready var weapon_controller: Node2D = $"../WeaponController"

enum AnimState {IDLE, RUN, JUMP, FALL, ATTACK, ABILITY}
var curr_state: AnimState = AnimState.IDLE

var locked: bool = false
var facing_dir: int= 1

func _process(delta: float) -> void:
	if locked:
		return
	var new_state = get_anim_state()
	
	if curr_state != new_state:
		curr_state = new_state
		handle_animations(curr_state)
	
	update_facing()
	#flip_sprite()

func handle_animations(state: AnimState) -> void:
	match state:
		AnimState.IDLE: 
			player_sprite.play('idle')
			weapon_sprite.play(get_weapon_anim('idle'))
		AnimState.RUN: 
			player_sprite.play('run')
			weapon_sprite.play(get_weapon_anim('run'))
		AnimState.JUMP: 
			player_sprite.play('jump')
			weapon_sprite.play(get_weapon_anim('jump'))
		AnimState.FALL: 
			player_sprite.play('fall')
			weapon_sprite.play(get_weapon_anim('fall'))

func get_anim_state() -> AnimState:
	if player.is_on_floor():
		if abs(player.velocity.x) < 1:
			return AnimState.IDLE
		else:
			return AnimState.RUN
	else:
		if player.velocity.y < 0:
			return AnimState.JUMP
		else:
			return AnimState.FALL

func get_weapon_anim(base_anim: String) -> String:
	var weapon_name = PlayerStats.loadout.weapon
	
	if weapon_name == null:
		return "null_" + base_anim
	return weapon_name + "_" + base_anim


func play_attack() -> void:
	if locked:
		return
	locked = true
	curr_state = AnimState.ATTACK
	
	if PlayerStats.loadout.weapon != null:
		weapon_sprite.offset.x = facing_dir * 36
	player_sprite.play('idle')
	weapon_sprite.play(get_weapon_anim('attack'))
	await weapon_sprite.animation_finished
	weapon_sprite.offset.x = 0
	locked = false

func play_ability() -> bool:
	if locked:
		return false
	
	var ability_name = PlayerStats.loadout.ability
	locked = true
	curr_state = AnimState.ABILITY
	if ability_name == null:
		player_sprite.play("energy_orb")
		#weapon_sprite.play("null_attack")
		await player_sprite.animation_finished
	else:
		player_sprite.play(ability_name)
		weapon_sprite.play(ability_name)
		await weapon_sprite.animation_finished
	locked = false
	
	return true

func flip_sprite() -> void:
	if player.velocity.x != 0:
		player_sprite.flip_h = player.velocity.x < 0
		weapon_sprite.flip_h = player.velocity.x < 0

func update_facing() -> void:
	if player.velocity.x > 0:
		facing_dir = 1
	elif player.velocity.x < 0:
		facing_dir = -1
	
	player_sprite.flip_h = facing_dir == -1
	weapon_sprite.flip_h = facing_dir == -1
	
	weapon_controller.scale.x = facing_dir
