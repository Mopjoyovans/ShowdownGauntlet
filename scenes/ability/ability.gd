extends Node
class_name Ability


#signal damaged_opponent

var ability_name: String = "Ability Name"
var type: String = "Fire"
var damage: float = 10.0
var cost: float = 1.0


func hydrate_ability_data(ability_name: String) -> Ability:
	var ability_data = GameData.abilities[ability_name]
	self.ability_name = ability_data.name
	self.type = ability_data.type
	self.damage = float(ability_data.damage)
	self.cost = float(ability_data.cost)
	return self


func use_ability():
	print(str("use ability ", ability_name))
#	if is_player:
#		damaged_opponent.emit(damage)
		

func display_information() -> String:
	return str(ability_name, "\nType: ", type, "\nDamage: ", damage, "\nCost: ", cost)
