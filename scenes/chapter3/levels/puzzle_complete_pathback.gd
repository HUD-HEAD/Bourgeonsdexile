extends Node

@export var puzzle : DragDropPuzzle
@export var woman : Woman
@export var wayto : CanvasItem
@export var wayback : CanvasItem

@export var pathfollow_back : PathFollow2D
##On way back, offsets camera x so it "looks ahead"
@export var adjust_camera : bool = true

var camera : Camera2D

func _ready() -> void:
	#return
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	camera = get_viewport().get_camera_2d()
	
	
	wayto.show()
	wayback.hide()
	
func _on_puzzle_complete():
	wayto.hide()
	wayback.show()
	_go_back()
	if adjust_camera:
		_adjust_camera()

## Transition to path back if defined, or turn around on current path
func _go_back():
	if pathfollow_back != null :
		#Make sure character is not offset from new path
		var path_back : Path2D = pathfollow_back.get_parent()
		var new_progress = path_back.curve.get_closest_offset(woman.global_position)
		pathfollow_back.progress = new_progress
		#Switch to path back
		woman.path_follow = pathfollow_back
		woman.reparent(pathfollow_back, true)	
	else :
		woman.dir *= -1

func _adjust_camera():
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(camera, "offset:x", -camera.offset.x, 3.0)
