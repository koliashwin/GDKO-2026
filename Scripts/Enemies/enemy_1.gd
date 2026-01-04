extends CharacterBody2D

@export var speed: float = 120
@export var gravity: float = 900
@export var max_health: int = 5
@export var chase_range: int = 320

var health: int
var player: CharacterBody2D

func _ready() -> void:
	add_to_group("Enemies")
	
	health = max_health

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_movment()
	
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

func handle_movment() -> void:
	if !player:
		return
	
	var dist = global_position.distance_to(player.global_position)
	if dist < chase_range:
		chase_player()
	else:
		idle()

func idle() -> void:
	velocity.x = 0

func chase_player() -> void:
	var dir = sign(player.global_position.x - global_position.x)
	velocity.x = speed * dir

func take_damage(amount = 1) -> void:
	health -= amount
	
	if health <= 0:
		die()

func die() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
