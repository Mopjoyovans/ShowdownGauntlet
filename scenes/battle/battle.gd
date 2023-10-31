extends Node
class_name Battle


@export var ability_scene: PackedScene
@export var creature_scene: PackedScene
@export var ability_buttons: Array

var current_creature: Creature

@onready var ability_panel_container = %AbilityPanelContainer
@onready var info_panel_container = %InfoPanelContainer
@onready var player_team = $PlayerTeam
@onready var enemy_team = $EnemyTeam


func _ready():
	populate_creature_data("Salamander", true)
	populate_creature_data("Archon", false)
	populate_abilities()


func populate_creature_data(creature_name: String, is_player: bool) -> void:
	var creature = creature_scene.instantiate() as Creature
	creature.init_child_refs()
	creature.hydrate_creature_data(creature_name, is_player)
	
	if is_player:
#		active_player = creature
		player_team.add_child(creature)
		set_current_creature(creature)
	else:
#		active_enemy = creature
		enemy_team.add_child(creature)


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
