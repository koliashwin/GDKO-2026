extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and !PlayerStats.loadout.gadget == "mud_boots":
		body.SPEED_FACTOR = 0.35
		body.JUMP_FACTOR = 0.4


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.SPEED_FACTOR = 1
		body.JUMP_FACTOR = 1
