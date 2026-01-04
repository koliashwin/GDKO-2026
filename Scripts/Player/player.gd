extends CharacterBody2D

@export var SPEED: int = 300;
@export var SPEED_FACTOR: float = 1;

@export var JUMP_FORCE: int = 800;
@export var JUMP_FACTOR: float = 1;
var can_double_jump: bool = true;

@export var MAX_HEALTH: int = 10
var health: int

@export var GRAVITY: int = 980;

@onready var weapon_controller: Node2D = $WeaponController
@onready var ability_controller: Node2D = $AbilityController

func _ready() -> void:
	add_to_group("Player")
	
	health = MAX_HEALTH

func _physics_process(delta: float) -> void:
	var direction: int = Input.get_axis("move_left", "move_right")
	
	horizontal_movment(direction, delta)
	apply_gravity()
	jump()
	attack()
	ability()
	
	switch_loadout()
	move_and_slide()

func horizontal_movment(direction: int, delta: float) -> void:
	# player movment logic
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * SPEED_FACTOR * direction, 600 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, 900 * delta)

func apply_gravity() -> void:
	if !is_on_floor():
		velocity.y = move_toward(velocity.y, GRAVITY, 40)

func jump() -> void:
	# jump logic
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -JUMP_FORCE * JUMP_FACTOR
			can_double_jump = true
		elif !is_on_floor() and PlayerStats.loadout.gadget == "wing_boots" and can_double_jump:
			velocity.y = -JUMP_FORCE * JUMP_FACTOR
			can_double_jump = false

func attack() -> void:
	# attack logci
	if Input.is_action_just_pressed("attack"):
		weapon_controller.attack()

func ability() -> void:
	if Input.is_action_just_pressed("ability"):
		ability_controller.use_ability()

func took_damage(amount = 1) -> void:
	health -= amount
	
	velocity.y = -800
	print("Current health : ", health)
	if health <= 0:
		print("Player Died")
		queue_free()
	
func switch_loadout() -> void:
	# temporary logic to change loadout with button input
	
	# switch weapon
	if Input.is_action_just_pressed("switch_weapon"):
		PlayerStats.next_weapon()
	
	# switch ability
	if Input.is_action_just_pressed("switch_ability"):
		PlayerStats.next_ability()
	
	# swithc gadget
	if Input.is_action_just_pressed("switch_gadget"):
		PlayerStats.next_gadget()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		took_damage()
