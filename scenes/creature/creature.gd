extends Node2D
class_name Creature


var creature_name: String = "Creature Name"
var attack: int = 50
var defense: int = 50
var endurance: int = 50
var magic: int = 50
var resistance: int = 50
var speed: int = 50
var abilities: Array

@onready var health_component = $HealthComponent
@onready var sprite = $Sprite
@onready var health_bar = %HealthBar
@onready var panel_container = $PanelContainer
@onready var name_label = %NameLabel
@onready var hp_label = %HPLabel


func _ready():
	health_component.health_changed.connect(on_health_changed)
	init_child_refs()
	update_health_display()


func init_child_refs():
	health_component = $HealthComponent
	sprite = $Sprite
	panel_container = $PanelContainer
	name_label = %NameLabel
	hp_label = %HPLabel


func hydrate_creature_data(creature_name_key: String, is_player: bool) -> Creature:
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
	
	if is_player:
		create_player_nameplate()
	else:
		create_enemy_nameplate()
	
	return self


func populate_abilities(ability_data) -> Array:
	var new_abilities: Array = []
	var ability_names = ability_data.split(", ")
	
	for ability_name in ability_names:
#		print(str('ability', ability_name))
		if ability_name != "":
			new_abilities.push_front(GameData.abilities[ability_name])
		
	return new_abilities


func damage(damage_amount: float):
	health_component.damage(damage_amount)


func create_player_nameplate():
	position.x = 80
	position.y = 190
	panel_container.position.x = 50
	panel_container.position.y = -19
	populate_nameplate()


func create_enemy_nameplate():
	position.x = 380
	position.y = 60
	sprite.frame = 9
	panel_container.position.x = -250
	panel_container.position.y = -51
	populate_nameplate()
	
	
func populate_nameplate():
	name_label.text = creature_name
	hp_label.text = str(health_component.current_health, "/", health_component.max_health)


func update_health_display():
	health_bar.value = health_component.get_health_percent()
	hp_label.text = str(health_component.current_health, "/", health_component.max_health)


func on_health_changed():
	update_health_display()
