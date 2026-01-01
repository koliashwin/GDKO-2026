extends Node2D

@onready var hitbox: Area2D = $MeleeHitbox

var is_attacking: bool

func _ready() -> void:
	hitbox.monitoring = false
	is_attacking = false

func attack() -> void:
	if PlayerStats.is_weapon_lost:
		print("dont have weapon to attack")
		return
	
	match PlayerStats.loadout.weapon:
		"rusty_blade": rusty_attack()
		"blade": slash_attack()
		"gun": gun_shot()
		null: no_weapon()

func start_attack(duration: float) -> void:
	hitbox.monitoring = true
	is_attacking = true
	print("hit box monitoring")
	await get_tree().create_timer(duration).timeout
	hitbox.monitoring = false
	is_attacking = false
	print("hit box not monitoring")

func rusty_attack() -> void:
	if is_attacking:
		return
	if randf() < 0.2:
		print('sword is stuck')
		PlayerStats.lost_weapon()
		return
	start_attack(0.3)
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
	pass # enemy health reduction logic goes here
