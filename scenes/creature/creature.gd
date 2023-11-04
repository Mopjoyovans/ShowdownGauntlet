extends Node2D
class_name Creature


# Attributes
var creature_name: String = "Creature Name"
var attack: int = 50
var defense: int = 50
var endurance: int = 50
var magic: int = 50
var resistance: int = 50
var speed: int = 50
var abilities: Array

# UI elements
var health_bar: ProgressBar
var name_label: Label
var hp_label: Label

@onready var health_component = $HealthComponent


func _ready():
	health_component.health_changed.connect(on_health_changed)
	init_child_refs()
	update_health_display()


func init_child_refs():
	health_component = $HealthComponent


func hydrate_creature_data(creature_name_key: String) -> Creature:
	var creature_data = GameData.creatures[creature_name_key]
	creature_name = creature_data.name
	attack = int(creature_data.attack)
	defense = int(creature_data.defense)
	endurance = int(creature_data.endurance)
	magic = int(creature_data.magic)
	resistance = int(creature_data.resistance)
	speed = int(creature_data.speed)
	abilities = populate_abilities(creature_data.abilities)

	health_component.max_health = float(creature_data.hp)
	health_component.current_health = health_component.max_health
	return self


func populate_abilities(ability_data) -> Array:
	var new_abilities: Array = []
	var ability_names = ability_data.split(", ")
	
	for ability_name in ability_names:
		if ability_name != "":
			new_abilities.push_front(GameData.abilities[ability_name])
		
	return new_abilities


func damage(damage_amount: float):
	health_component.damage(damage_amount)


func is_alive() -> bool:
	return health_component.current_health > 0

	
func update_nameplate():
	name_label.text = creature_name
	hp_label.text = str(health_component.current_health, "/", health_component.max_health)
	update_health_display()


func update_health_display():
	health_bar.value = health_component.get_health_percent()
	hp_label.text = str(health_component.current_health, "/", health_component.max_health)


func on_health_changed():
	update_health_display()
