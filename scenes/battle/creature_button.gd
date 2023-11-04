extends Button


var creature: Creature


func _ready():
	self.pressed.connect(on_pressed)
#	self.mouse_entered.connect(on_hover)
#	self.mouse_exited.connect(on_blur)


func on_pressed():
	GameEvents.emit_switched_creature(creature)


#func on_hover():
#	info_label.text = ability.display_information()
#
#
#func on_blur():
#	info_label.text = ""
