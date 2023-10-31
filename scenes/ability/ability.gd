extends Node
class_name Ability


var ability_name: String = "Ability Name"
var type: String = "Fire"
var damage: float = 10.0
var cost: float = 1.0


func hydrate_ability_data(ability_name_key: String) -> Ability:
	var ability_data = GameData.abilities[ability_name_key]
	ability_name = ability_data.name
	type = ability_data.type
	damage = float(ability_data.damage)
	cost = float(ability_data.cost)
	return self


func use_ability(target_is_enemy: bool):
	print(str("use ability ", ability_name))
	if target_is_enemy:
		GameEvents.emit_ability_used_on_enemy(self)
	else:
		GameEvents.emit_ability_used_on_player(self)
		

func display_information() -> String:
	return str(ability_name, "\nType: ", type, "\nDamage: ", damage, "\nCost: ", cost)
