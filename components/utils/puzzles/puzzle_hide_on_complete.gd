extends Node

@onready var puzzle : DragDropPuzzle = get_parent()

func _ready() -> void:
	assert(is_instance_valid(puzzle))
	puzzle.puzzle_complete.connect(puzzle.hide)
