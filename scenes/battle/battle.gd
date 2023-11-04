extends Node
class_name Battle


@export var ability_scene: PackedScene
@export var creature_scene: PackedScene
@export var ability_buttons: Array

var current_creature: Creature
var active_enemy: Creature
var active_player: Creature
var player_team_buttons: Array[Button]
var enemy_team_labels: Array[Label]

@onready var player_team: Team = $PlayerTeam
@onready var enemy_team: Team = $EnemyTeam
@onready var player_name_label = %PlayerNameLabel
@onready var player_health_bar = %PlayerHealthBar
@onready var player_hp_label = %PlayerHPLabel
@onready var enemy_name_label = %EnemyNameLabel
@onready var enemy_health_bar = %EnemyHealthBar
@onready var enemy_hp_label = %EnemyHPLabel
@onready var creature_button = %CreatureButton
@onready var creature_button_2 = %CreatureButton2
@onready var creature_button_3 = %CreatureButton3
@onready var creature_button_4 = %CreatureButton4
@onready var creature_label = %CreatureLabel
@onready var creature_label_2 = %CreatureLabel2
@onready var creature_label_3 = %CreatureLabel3
@onready var creature_label_4 = %CreatureLabel4

func _ready():
	GameEvents.ability_used_on_enemy.connect(on_ability_used_on_enemy)
	GameEvents.ability_used_on_player.connect(on_ability_used_on_player)
	GameEvents.switched_creature.connect(on_player_creature_set)
	player_team.active_creature_set.connect(on_player_creature_set)
	enemy_team.active_creature_set.connect(on_enemy_creature_set)
	player_team_buttons = [creature_button, creature_button_2, creature_button_3, creature_button_4]
	enemy_team_labels = [creature_label, creature_label_2, creature_label_3, creature_label_4]
	populate_player_creatures(["Salamander", "Archon", "Gebbu", "Grippel"])
	populate_enemy_creatures(["Chimera", "Shadow", "Hag", "Vampire"])
	populate_abilities(player_team.get_creature_by_name("Salamander"))


func populate_player_creatures(creature_names: Array[String]) -> void:
	var index: int = 0

	for creature_name_key in creature_names:
		var creature = creature_scene.instantiate() as Creature
		creature.init_child_refs()
		creature.hydrate_creature_data(creature_name_key)
		creature.health_bar = player_health_bar
		creature.name_label = player_name_label
		creature.hp_label = player_hp_label
		active_player = creature
		player_team.add_creature(creature)
		player_team_buttons[index].text = creature_name_key
		player_team_buttons[index].creature = creature
		if creature_name_key == "Salamander":
			set_current_creature(creature)
		
		index += 1


func populate_enemy_creatures(creature_names: Array[String]) -> void:
	var index: int = 0
	
	for creature_name_key in creature_names:
		var creature = creature_scene.instantiate() as Creature
		creature.init_child_refs()
		creature.hydrate_creature_data(creature_name_key)
		creature.health_bar = enemy_health_bar
		creature.name_label = enemy_name_label
		creature.hp_label = enemy_hp_label
		active_enemy = creature
		enemy_team_labels[index].text = creature_name_key
		enemy_team.add_creature(creature)
		index += 1


func populate_abilities(creature: Creature):
	if ability_buttons == null or creature == null or creature.abilities == null:
		return
	var index: int = 0
	
	for button in ability_buttons:
		var button_node = get_node(button)
		var ability = ability_scene.instantiate() as Ability
		if ability != null and creature.abilities.size() > index:
			button_node.ability = ability.hydrate_ability_data(creature.abilities[index].name)
			button_node.text = ability.ability_name
		else:
			button_node.text = ""
			button_node.ability = null
		index += 1


func set_current_creature(creature):
	current_creature = creature
	

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
	populate_abilities(creature)
	active_player = creature


func on_enemy_creature_set(creature: Creature):
	creature.update_nameplate()
	active_enemy = creature
