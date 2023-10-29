extends Button


var ability: Ability


func _ready():
	self.pressed.connect(on_pressed)


func on_pressed():
	print(str("pressed button ", ability.ability_name))
#	get_node("/root/BattleScene").cur_char.cast_combat_action(combat_action)
