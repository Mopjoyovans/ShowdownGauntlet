extends Node


signal used_ability(ability: Ability, target: Creature)


func emit_used_ability(ability: Ability):
	used_ability.emit(ability)
