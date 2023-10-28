extends CanvasLayer
class_name Battle


@export var ability_buttons: Array

var current_creature: Creature

@onready var ability_panel_container = $Control/AbilityPanelContainer
@onready var info_panel_container = $Control/InfoPanelContainer


func _ready():
	pass
#	populate_abilities()


func set_current_creature(creature):
	current_creature = creature
	
	
func populate_abilities():
	print(current_creature.abilities)
	if ability_buttons == null or current_creature == null or current_creature.abilities == null:
		return

	var index = 0
	
	for button in ability_buttons:
		button.text = current_creature.abilities[index].name
		button.ability = current_creature.abilities[index]
		index += 1
