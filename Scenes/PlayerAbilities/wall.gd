extends StaticBody2D

@export var raise_height: int = 96
@export var raise_speed: int = 120
@export var lifetime: float = 3.5

var start_y: float
var target_y: float

func _ready() -> void:
	start_y = global_position.y
	target_y = start_y - raise_height

func _physics_process(delta: float) -> void:
	if global_position.y > target_y:
		global_position.y -= raise_speed * 3 * delta
	else:
		global_position.y = target_y
		set_physics_process(false)
		
		await get_tree().create_timer(lifetime).timeout
		# exit logic/animation here
		queue_free()
