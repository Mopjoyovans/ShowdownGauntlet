extends Node
class_name Team


signal active_creature_set(creature: Creature)

var creatures: Array[Creature]
var active_creature: Creature


func add_creature(creature: Creature):
	creatures.push_front(creature)
	add_child(creature)
	
	if active_creature == null:
		set_active_creature(creature)


func set_active_creature(creature: Creature):
	active_creature = creature
	active_creature_set.emit(creature)


func get_active_creature() -> Creature:
	return active_creature
