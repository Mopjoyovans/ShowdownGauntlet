extends Node
class_name Battle


@export var ability_scene: PackedScene
@export var creature_scene: PackedScene
@export var ability_buttons: Array

var current_creature: Creature
var active_enemy: Creature
var active_player: Creature

@onready var player_team: Team = $PlayerTeam
@onready var enemy_team: Team = $EnemyTeam
@onready var player_name_label = %PlayerNameLabel
@onready var player_health_bar = %PlayerHealthBar
@onready var player_hp_label = %PlayerHPLabel
@onready var enemy_name_label = %EnemyNameLabel
@onready var enemy_health_bar = %EnemyHealthBar
@onready var enemy_hp_label = %EnemyHPLabel


func _ready():
	GameEvents.ability_used_on_enemy.connect(on_ability_used_on_enemy)
	GameEvents.ability_used_on_player.connect(on_ability_used_on_player)
	player_team.active_creature_set.connect(on_player_creature_set)
	enemy_team.active_creature_set.connect(on_enemy_creature_set)
	populate_player_creatures(["Salamander", "Archon", "Gebbu", "Grippel"])
	populate_enemy_creatures(["Chimera", "Shadow", "Hag", "Vampire"])
	populate_abilities()


func populate_player_creatures(creature_names: Array[String]) -> void:
	for creature_name_key in creature_names:
		var creature = creature_scene.instantiate() as Creature
		creature.init_child_refs()
		creature.hydrate_creature_data(creature_name_key, true)
		creature.health_bar = player_health_bar
		creature.name_label = player_name_label
		creature.hp_label = player_hp_label
		active_player = creature
		player_team.add_creature(creature)
		if creature_name_key == "Salamander":
			set_current_creature(creature)


func populate_enemy_creatures(creature_names: Array[String]) -> void:
	for creature_name_key in creature_names:
		var creature = creature_scene.instantiate() as Creature
		creature.init_child_refs()
		creature.hydrate_creature_data(creature_name_key, false)
		creature.health_bar = enemy_health_bar
		creature.name_label = enemy_name_label
		creature.hp_label = enemy_hp_label
		active_enemy = creature
		enemy_team.add_creature(creature)


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


func on_player_creature_set(creature: Creature):
	creature.update_nameplate()
	active_player = creature


func on_enemy_creature_set(creature: Creature):
	creature.update_nameplate()
	active_enemy = creature
