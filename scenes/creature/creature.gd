extends Node2D
class_name Creature


var attack: int = 50
var defense: int = 50
var endurance: int = 50
var magic: int = 50
var resistance: int = 50
var speed: int = 50
var abilities: Array

@onready var health_component = $HealthComponent
@onready var sprite = $Sprite


func _ready():
	init_child_refs()


func init_child_refs():
	health_component = $HealthComponent
	sprite = $Sprite


func hydrate_creature_data(creature_name: String, is_player: bool) -> Creature:
	var creature_data = GameData.creatures[creature_name]
	attack = int(creature_data.attack)
	defense = int(creature_data.defense)
	endurance = int(creature_data.endurance)
	magic = int(creature_data.magic)
	resistance = int(creature_data.resistance)
	speed = int(creature_data.speed)
	abilities = populate_abilities(creature_data.abilities)

	health_component.max_health = float(creature_data.hp)
	health_component.current_health = health_component.max_health
	
	if is_player:
		sprite.position.x = 60
		sprite.position.y = 120
	else:
		sprite.position.x = 260
		sprite.position.y = 50
		sprite.frame = 9
	
	return self


func populate_abilities(ability_data) -> Array:
	var abilities: Array = []
	var ability_names = ability_data.split(", ")
	
	for ability_name in ability_names:
		abilities.push_front(GameData.abilities[ability_name])
		
	return abilities
