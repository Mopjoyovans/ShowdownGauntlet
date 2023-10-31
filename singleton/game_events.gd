extends Node


signal ability_used_on_enemy(ability: Ability)
signal ability_used_on_player(ability: Ability)


func emit_ability_used_on_enemy(ability: Ability):
	ability_used_on_enemy.emit(ability)


func emit_ability_used_on_player(ability: Ability):
	ability_used_on_player.emit(ability)
