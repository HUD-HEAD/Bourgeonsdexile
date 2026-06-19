extends Node

@export var puzzle : DragDropPuzzle
@export var woman : Woman
@export var wayto : CanvasItem
@export var wayback : CanvasItem

func _ready() -> void:
	#return
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
	wayback.hide()
	
func _on_puzzle_complete():
	wayto.hide()
	wayback.show()
	
	woman.dir *= -1
