#TODO cleanup/refactor with other movement
class_name Vehicle
extends Node2D

@export var char_area : Area2D

@export var move_speed : float = 75

@export var visuals : Node2D

var walking : bool

@export_group("BodaBoda")
@export var bodaboda_visual_controller: BodaBodaVisualController

#TODO cleanup. Should we set a path on all scenes? 
var walk_along_path = false

func _ready() -> void:
	char_area.area_entered.connect(_on_area_entered)
	SignalManager.obstacle_cleared.connect(_start_walking)
	_start_walking()


func _process(delta: float) -> void:
	if walking:
		self.global_position.x += move_speed * delta


func _on_area_entered(area : Area2D):
	_stop_walking()
	InputManager.show_mouse()

	
func _start_walking():
	walking = true
	visuals.process_mode = Node.PROCESS_MODE_INHERIT
	if bodaboda_visual_controller != null:
		bodaboda_visual_controller.on_continue_bodaboda()

func _stop_walking():
	walking = false
	visuals.process_mode = Node.PROCESS_MODE_DISABLED
