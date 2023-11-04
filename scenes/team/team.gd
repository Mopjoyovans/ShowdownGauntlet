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


func get_creature_by_name(creature_name: String) -> Creature:
	for creature in creatures:
		if creature.creature_name == creature_name:
			return creature
			
	return null
