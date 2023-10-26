extends Node2D
class_name Creature


@export var is_player: bool = true

var attack: int = 50
var defense: int = 50
var endurance: int = 50
var magic: int = 50
var resistance: int = 50
var speed: int = 50

@onready var health_component = $HealthComponent


func _ready():
	pass
