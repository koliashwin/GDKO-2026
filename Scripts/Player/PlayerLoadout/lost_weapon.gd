extends CharacterBody2D

@export var gravity := 1200.0
@export var launch_force := Vector2(220, -620)
@export var spin_speed := 720.0

var landed : bool = false
var can_pick_up: bool = false

func _ready() -> void:
	velocity = Vector2(
		launch_force.x * randf_range(-1, 1),
		launch_force.y
	)

func _physics_process(delta):
	if can_pick_up and Input.is_action_just_pressed("Interact"):
		PlayerStats.found_weapon()
		queue_free()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		rotation_degrees += spin_speed * delta
	else:
		velocity = Vector2.ZERO
		rotation_degrees = 0
		landed = true
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print(body.name)
		can_pick_up = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print(body.name)
		can_pick_up = false
