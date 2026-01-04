extends Node

signal loadout_changed

var is_weapon_lost: bool = false

var weapons = [null, "rusty_blade", "blade", "gun"]
var gadget = [null, "wing_boots", "mud_boots"]
var ability = [null, "energy_orb", "stone_wall"]

var curr_weapon: int = 0
var curr_ability: int = 0
var curr_gadget: int = 0

var loadout = {
	"weapon": weapons[curr_weapon],
	"ability": ability[curr_ability],
	"gadget": gadget[curr_gadget]
}

func lost_weapon() -> void:
	curr_weapon = 0
	loadout.weapon = weapons[curr_weapon]
	is_weapon_lost = true
	print("lost weapon")
	emit_signal("loadout_changed")

func found_weapon() -> void:
	curr_weapon = 1
	loadout.weapon = weapons[curr_weapon]
	is_weapon_lost = false
	print("found weapon")
	emit_signal("loadout_changed")

func next_weapon() -> void:
	curr_weapon = (curr_weapon + 1) % weapons.size()
	loadout.weapon = weapons[curr_weapon]
	print("Weapon Switched to : ", loadout.weapon)
	emit_signal("loadout_changed")

func next_ability() -> void:
	curr_ability = (curr_ability + 1) % ability.size()
	loadout.ability = ability[curr_ability]
	print("Ability Switched to : ", loadout.ability)
	emit_signal("loadout_changed")

func next_gadget() -> void:
	curr_gadget = (curr_gadget + 1) % gadget.size()
	loadout.gadget = gadget[curr_gadget]
	print("Gadget Switched to : ", loadout.gadget)
	emit_signal("loadout_changed")
