extends Node

@export var puzzle : DragDropPuzzle
@export var woman : Woman
@export var wayto : CanvasItem
@export var wayback : CanvasItem

@export var pathfollow_back : PathFollow2D

func _ready() -> void:
	#return
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
	wayto.show()
	wayback.hide()
	
func _on_puzzle_complete():
	wayto.hide()
	wayback.show()
	
	if pathfollow_back != null :
		var path_back : Path2D = pathfollow_back.get_parent()
		var new_progress = path_back.curve.get_closest_offset(woman.global_position)
		pathfollow_back.progress = new_progress
		woman.path_follow = pathfollow_back
		woman.reparent(pathfollow_back, true)
		
		
	else :
		woman.dir *= -1
