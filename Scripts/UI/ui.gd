extends CanvasLayer

@onready var weapon_label: Label = $PanelContainer/VBoxContainer/WeaponRow/WeaponLabel
@onready var ability_label: Label = $PanelContainer/VBoxContainer/AbilityRow/AbilityLabel
@onready var gadget_label: Label = $PanelContainer/VBoxContainer/GadgetRow/GadgetLabel

func _ready() -> void:
	PlayerStats.loadout_changed.connect(update_ui)
	update_ui()

func update_ui() -> void:
	weapon_label.text = "Weapon: " + fromat_name(PlayerStats.loadout.weapon)
	ability_label.text = "Ability: " + fromat_name(PlayerStats.loadout.ability)
	gadget_label.text = "Gadget: " + fromat_name(PlayerStats.loadout.gadget)

func fromat_name(value) -> StringName:
	if value == null:
		return "None"
	return value.replace("_", " ").capitalize()
