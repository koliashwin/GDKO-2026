extends Area2D

@export var speed: int = 350
@export var lifetime: float = 4

var target: Node2D = null

func _ready() -> void:
	find_target()
	
	await get_tree().create_timer(lifetime).timeout
	# projectile end animation or logic
	queue_free()

func _physics_process(delta: float) -> void:
	if target and is_instance_valid(target):
		var dir = (target.global_position - global_position).normalized()
		global_position += dir * speed * delta 
	else:
		global_position.y -= speed/3 * delta

func find_target() -> void:
	var candidates = get_tree().get_nodes_in_group("Enemies")
	
	if candidates.is_empty():
		print("no one in group")
		return
	
	var closest_dist: float = INF
	for c in candidates:
		var d = global_position.distance_to(c.global_position)
		if d < closest_dist:
			closest_dist = d
			target = c

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.take_damage(3)
		queue_free()
