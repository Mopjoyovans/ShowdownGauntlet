extends Node


@export var creature_scene: PackedScene

@onready var player_team = $PlayerTeam
@onready var enemy_team = $EnemyTeam


func _ready():
#	print(GameData.abilities)
#	print(GameData.creatures)
	populate_creature_data("Squirtle", true)
	populate_creature_data("Charmander", false)
	
	
func populate_creature_data(creature_name: String, is_player: bool) -> void:
	var creature = creature_scene.instantiate()
	creature.init_child_refs()
	creature.hydrate_creature_data(creature_name, is_player)
	
	if is_player:
		player_team.add_child(creature)
	else:
		enemy_team.add_child(creature)
