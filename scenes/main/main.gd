extends Node


@export var creature_scene: PackedScene
@export var battle_scene: Node

@onready var player_team = $PlayerTeam
@onready var enemy_team = $EnemyTeam


func _ready():
	pass
#	print(GameData.abilities)
#	print(GameData.creatures)
#	populate_creature_data("Salamander", true)
#	populate_creature_data("Archon", false)
#	(battle_scene as Battle).populate_abilities()
#
#
#func populate_creature_data(creature_name: String, is_player: bool) -> void:
#	var creature = creature_scene.instantiate() as Creature
#	creature.init_child_refs()
#	creature.hydrate_creature_data(creature_name, is_player)
#
#	if is_player:
##		active_player = creature
#		player_team.add_child(creature)
#		(battle_scene as Battle).set_current_creature(creature)
#	else:
##		active_enemy = creature
#		enemy_team.add_child(creature)
