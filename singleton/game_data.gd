extends Node


var abilities = {}
var creatures = {}
var ability_data_path = "res://data/Abilities.csv"
var creature_data_path = "res://data/Creatures.csv"


func _ready():
	abilities = load_csv_data(ability_data_path)
	creatures = load_csv_data(creature_data_path)


func load_csv_data(path: String):
	var data = {}

	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var header_found: bool = false
		var headers = []
#		var parsed_data = JSON.parse_string(file.get_as_text())
#
#		if parsed_data is Dictionary:
#			print(parsed_data)
##			return parsed_data
#		else:
#			print("Error reading ability data")
		
		while !file.eof_reached():
			var data_set = Array(file.get_csv_line())
			if not header_found:
				headers = data_set
				header_found = true
			else:
				var csv_line = {}
				var index = 0
				for label in headers:
					csv_line[label] = data_set[index]
					index += 1
				data[csv_line["Name"]] = csv_line
		file.close()
		
#		print(data)

	else:
		print("Ability data file not found")
		
	return data
