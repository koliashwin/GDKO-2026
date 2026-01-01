extends Node

var weapons = [null, "rusty_blade", "blade", "gun"]
var ability = [null, "energy_orb", "stone_wall"]
var gadget = [null, "wing_boots", "mud_boots"]

var curr_weapon: int = 0
var curr_ability: int = 0
var curr_gadget: int = 0

var loadout = {
	"weapon": weapons[curr_weapon],
	"ability": ability[curr_ability],
	"gadget": gadget[curr_gadget]
}

func next_weapon() -> void:
	curr_weapon = (curr_weapon + 1) % weapons.size()
	loadout.weapon = weapons[curr_weapon]
	print("Weapon Switched to : ", loadout.weapon)

func next_ability() -> void:
	curr_ability = (curr_ability + 1) % ability.size()
	loadout.ability = ability[curr_ability]
	print("Ability Switched to : ", loadout.ability)

func next_gadget() -> void:
	curr_gadget = (curr_gadget + 1) % gadget.size()
	loadout.gadget = gadget[curr_gadget]
	print("Gadget Switched to : ", loadout.gadget)
