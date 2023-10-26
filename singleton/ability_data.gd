extends Node


var ability_data = {}
var ability_data_path = "res://data/Showdown Gauntlet Data - Abilities.txt"


func _ready():
	load_ability_data(ability_data_path)


func load_ability_data(path: String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var parsed_data = JSON.parse_string(file.get_as_text())
		
		if parsed_data is Dictionary:
			print(parsed_data)
#			return parsed_data
		else:
			print("Error reading ability data")
		
#		while !file.eof_reached():
#			var data_set = Array(file.get_csv_line())
#			ability_data[ability_data.size()] = data_set
#
#		file.close()
	
	else:
		print("Ability data file not found")
