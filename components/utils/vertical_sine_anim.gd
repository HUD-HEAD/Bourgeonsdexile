extends Node2D

@export var amplitude : float = 50.0
@export var speed : float = 1.0

var base_pos_y : float
var offset : float = 0.0

func _ready() -> void:
	base_pos_y = position.y

func _process(delta):
	offset += delta*speed
	position.y = base_pos_y + sin(offset)*amplitude
	
	#print_debug("Position: ", position.y)
