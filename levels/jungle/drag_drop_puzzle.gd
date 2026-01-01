extends Node2D

@export var puzzle_pieces : Dictionary[Draggable, Area2D]
@export var complete_image : Sprite2D

func _ready() -> void:
	# Associate each draggable piece with its receptacle
	for piece in puzzle_pieces:
		piece.receptacle = puzzle_pieces[piece]
		piece.piece_correctly_placed.connect(_on_correct_piece)

## Called every time a puzzle piece is correctly placed
func _on_correct_piece():
	if _check_complete():
		_complete_puzzle()

## When puzzle is complete, disable interaction
func _complete_puzzle():
	print_debug("puzzle complete")
	process_mode = Node.PROCESS_MODE_DISABLED
	complete_image.show()
	SignalManager.obstacle_cleared.emit()
	

## Check if all puzzles are in the correct place
func _check_complete() -> bool:
	for piece in puzzle_pieces:
		if !piece.is_correctly_placed():
			return false
	
	return true
