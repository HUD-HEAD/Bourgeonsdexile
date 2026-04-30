#TODO cleanup/refactor with other movement

extends Node2D

@export var char_area : Area2D

@export var move_speed : float = 75

var walking : bool

#TODO cleanup. Should we set a path on all scenes? 
var walk_along_path = false

func _ready() -> void:
	char_area.area_entered.connect(_on_area_entered)
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()


func _process(delta: float) -> void:
	if walking:
		self.global_position.x += move_speed*delta


func _on_area_entered(area : Area2D):
	_stop_walking()
	InputManager.show_mouse()

	
func _start_walking():
	walking = true

func _stop_walking():
	walking = false
	
