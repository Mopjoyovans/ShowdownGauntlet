extends Node


signal ability_used_on_enemy(ability: Ability)
signal ability_used_on_player(ability: Ability)
signal switched_creature(ability: Ability)


func emit_ability_used_on_enemy(ability: Ability):
	ability_used_on_enemy.emit(ability)


func emit_ability_used_on_player(ability: Ability):
	ability_used_on_player.emit(ability)


func emit_switched_creature(creature: Creature):
	switched_creature.emit(creature)
