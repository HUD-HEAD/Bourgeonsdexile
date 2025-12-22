##Executes pan in/out of comic panels
extends Node

## Sequence of panels
@export var panels : Array [Node2D]

#TESTING variable/invariable pan speed
@export_category("Panning speed")
@export var constant_speed_pan : bool = true
## Camera panning speed in [px/s] if constant_speed_pan is true
@export var px_per_sec : float = 1000
## Time to pan to next panel in [s] if constant_speed_pan is false
@export var panning_time : float = 2.0

## Camera to pan
var camera : Camera2D
## Index of current panel
var idx : int = 0


func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	SignalManager.next_panel.connect(_next_panel)

## Triggers panning to next panel in the list
func _next_panel():
	assert(idx + 1< panels.size(), "idx inside panels number")
	idx += 1
	_pan_to(panels[idx])


## Pans to target
func _pan_to(panel : Node2D):
	var tween : Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	
	#TESTING
	var panning_speed : float = panning_time if !constant_speed_pan \
		else abs(panel.global_position.x - camera.global_position.x)/px_per_sec
	
	tween.tween_property(camera, "global_position", Vector2(panel.global_position.x, camera.global_position.y), panning_speed)
