extends Node
class_name Battle


@export var ability_scene: PackedScene
@export var creature_scene: PackedScene
@export var ability_buttons: Array

var current_creature: Creature
var active_enemy: Creature
var active_player: Creature

@onready var player_team = $PlayerTeam
@onready var enemy_team = $EnemyTeam


func _ready():
	GameEvents.ability_used_on_enemy.connect(on_ability_used_on_enemy)
	GameEvents.ability_used_on_player.connect(on_ability_used_on_player)
	populate_creature_data("Salamander", true)
	populate_creature_data("Archon", false)
	populate_abilities()


func populate_creature_data(creature_name: String, is_player: bool) -> void:
	var creature = creature_scene.instantiate() as Creature
	creature.init_child_refs()
	creature.hydrate_creature_data(creature_name, is_player)
	
	if is_player:
		active_player = creature
		player_team.add_child(creature)
		set_current_creature(creature)
	else:
		active_enemy = creature
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
		
		
func process_ability(creature: Creature, ability: Ability):
	creature.damage(ability.damage)


func on_ability_used_on_enemy(ability: Ability):
	if active_enemy == null:
		return
	process_ability(active_enemy, ability)
	
	
func on_ability_used_on_player(ability: Ability):
	if active_player == null:
		return
	process_ability(active_player, ability)
