extends Node2D

var ability_data = { 
	"energy_orb" : {
		"scene": preload("res://Scenes/PlayerAbilities/orb.tscn"),
		"cooldown": 3.0,
		"life": 2.5,
		"offset": Vector2(0, -96)
	}, 
	"stone_wall" : {
		"scene": preload("res://Scenes/PlayerAbilities/wall.tscn"),
		"cooldown": 5.0,
		"life": 3.5,
		"offset": Vector2(0, 64)
	}
}

@onready var visual_controller: Node2D = $"../VisualsController"

var is_ability_ready: bool = true
var ability_cooldown_duration: float = 3

func use_ability() -> void:
	if !is_ability_ready:
		print("ability not ready")
		return
	var ability = PlayerStats.loadout.ability
	var data = ability_data.get(ability)
	
	await visual_controller.play_ability()
	
	if !data or !ability:
		no_ability()
		return
	
	var instance = data.scene.instantiate()
	get_tree().current_scene.add_child(instance)
	instance.position = global_position + data.offset
	start_cooldown(data.cooldown)
	

func start_cooldown(cooldown_duration: float) -> void:
	is_ability_ready = false
	await get_tree().create_timer(cooldown_duration).timeout
	is_ability_ready = true

# no ability
func no_ability() -> void:
	print("no ability")
