extends CanvasLayer
class_name Battle


@export var ability_scene: PackedScene
@export var ability_buttons: Array

var current_creature: Creature

@onready var ability_panel_container = $Control/AbilityPanelContainer
@onready var info_panel_container = $Control/InfoPanelContainer


func _ready():
	pass


func set_current_creature(creature):
	current_creature = creature
	
	
func populate_abilities():
	if ability_buttons == null or current_creature == null or current_creature.abilities == null:
		return

	var index = 0
	
	for button in ability_buttons:
		var button_node = get_node(button)
		button_node.text = current_creature.abilities[index].name

		var ability = ability_scene.instantiate() as Ability
		button_node.ability = ability.hydrate_ability_data(current_creature.abilities[index].name)

		index += 1
