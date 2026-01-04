extends Node2D

@onready var hitbox: Area2D = $MeleeHitbox
@onready var visual_controller: Node2D = $"../VisualsController"
var is_attacking: bool

func _ready() -> void:
	hitbox.monitoring = false
	is_attacking = false

func attack() -> void:
	if PlayerStats.is_weapon_lost:
		print("dont have weapon to attack")
		return
	
	visual_controller.play_attack()
	
	match PlayerStats.loadout.weapon:
		"rusty_blade": rusty_attack()
		"blade": slash_attack()
		"gun": gun_shot()
		null: no_weapon()

func start_attack(duration: float) -> void:
	is_attacking = true
	hitbox.monitoring = true
	await get_tree().create_timer(duration).timeout
	hitbox.monitoring = false
	is_attacking = false

func rusty_attack() -> void:
	if is_attacking:
		return
	if randf() < 0.2:
		var lost_sword = preload("res://Scenes/lost_weapon.tscn")
		var rusty_sword = lost_sword.instantiate()
		get_tree().current_scene.add_child(rusty_sword)
		rusty_sword.position = global_position
		
		PlayerStats.lost_weapon()
		return
	start_attack(0.5)
	print('rusty attack')

func slash_attack() -> void:
	if is_attacking:
		return
	start_attack(0.2)
	print('normal melee attack')

func gun_shot() -> void:
	start_attack(0.1)
	print('false gun attack')

func no_weapon() -> void:
	print('healpless animation')


func _on_melee_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.take_damage(2)
